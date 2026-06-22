from rich.console import Console
from rich.prompt import Prompt
from rich.panel import Panel

import inquirer

from typing import Union

from .common import text_bar, conn_status, fix_ncm_nbs, trunc, date_br_to_datetime
from .common import ncm_pref_validate, nbs_pref_validate, cnpj_validate, dt_validate, float_validate

import asyncpg


async def menu_inst_cient(console: Console, conn: asyncpg.Connection):
    while True:
        console.print(text_bar("CarbonoZero --- Instituição Científica", console.width, aside=conn_status(conn)))

        menu = Panel(
            "\n".join([
                "[bold]\\[1][/bold] Cadastrar relatório",
                "",
                "[bold]\\[0][/bold] Voltar"
            ])
        )

        console.print(menu)
        ret = Prompt.ask("> ", choices=["1", "2", "0"])

        match ret:
            case "0":
                return
            case "1":
                await relatorio_insert(console, conn)


async def ask_prods_or_servs(console: Console, conn: asyncpg.Connection, *, item_type: Union["prod", "serv"]) -> list:
    match item_type:
        case "prod":
            initial_prompt = inquirer.List("search_type", "Busca por NCM ou descrição", choices=["NCM", "Descrição"])
            prompt = inquirer.Text("cod_pref", "NCM ou prefixo do NCM", validate=ncm_pref_validate)
            cod_query = "SELECT ncm AS cod, nome FROM prod_ncm WHERE ncm LIKE $1 || '%'"
            desc_query = "SELECT ncm AS cod, nome FROM prod_ncm WHERE UPPER(nome) LIKE '%' || UPPER($1) || '%'"

            no_cod_found_err_msg = "[red]Nenhum produto encontrado com esse NCM[/red]"
            no_desc_found_err_msg = "[red]Nenhum produto encontrado com essa descrição[/red]"
        case "serv":
            initial_prompt = inquirer.List("search_type", "Busca por NBS ou descrição", choices=["NBS", "Descrição"])
            prompt = inquirer.Text("cod_pref", "NBS ou prefixo do NBS", validate=nbs_pref_validate)
            cod_query = "SELECT nbs AS cod, nome FROM serv_nbs WHERE nbs LIKE $1 || '%'"
            desc_query = "SELECT nbs AS cod, nome FROM serv_nbs WHERE UPPER(nome) LIKE '%' || UPPER($1) || '%'"

            no_cod_found_err_msg = "[red]Nenhum serviço encontrado com esse NBS[/red]"
            no_desc_found_err_msg = "[red]Nenhum serviço encontrado com essa descrição[/red]"
        case _:
            raise ValueError("Invalid value for type")

    items = []

    while True:
        answer = inquirer.prompt([initial_prompt])

        match answer["search_type"]:
            case "NCM" | "NBS":
                while True:
                    answer = inquirer.prompt([prompt])
                    result = await conn.fetch(cod_query, answer["cod_pref"].replace("%", "%%"))

                    match len(result):
                        case 0:
                            console.print(no_cod_found_err_msg)
                            continue
                        case 1:
                            cod = result[0]["cod"]
                        case _:
                            cods_pp = [f"{x["cod"]} {trunc(fix_ncm_nbs(x["nome"]), 40)}" for x in result]
                            answer = inquirer.prompt([
                                inquirer.List("cod", "Resultados", choices=cods_pp, carousel=True)
                            ])

                            cod_index = cods_pp.index(answer["cod"]) 
                            cod = result[cod_index]["cod"]

                            break
            case "Descrição":
                while True:
                    answer = inquirer.prompt([
                        inquirer.Text("desc_subs", "Descrição (substring)")
                    ])

                    result = await conn.fetch(desc_query, answer["desc_subs"].replace("%", "%%"))

                    match len(result):
                        case 0:
                            console.print(no_desc_found_err_msg)
                            continue
                        case 1:
                            cod = result[0]["cod"]
                        case _:
                            cods = [f"{x["cod"]} {trunc(fix_ncm_nbs(x["nome"]), 40)}" for x in result]
                            answer = inquirer.prompt([
                                inquirer.List("cod", "Resultados", choices=cods, carousel=True)
                            ])

                            cod_index = cods.index(answer["cod"])
                            cod = result[cod_index]["cod"]

                            break

        match item_type:
            case "prod":
                answer = inquirer.prompt([
                    inquirer.Text("emissao_assoc", "Emissão associada a uma unidade desse produto (em ton. CO₂)", validate=pos_float_validate),
                    inquirer.Text("qtde", "Quantidade produzida", validate=pos_float_validate),
                    inquirer.Confirm("more", False, message="Deseja inserir mais um produto?")
                ])

                items.append((cod, float(answer["emissao_assoc"]), float(answer["qtde"])))
            case "serv":
                answer = inquirer.prompt([
                    inquirer.Text("emissao_assoc", "Emissão associada à prestação do serviço (em ton. CO₂)", validate=pos_float_validate),
                    inquirer.Text("dt_ocorrencia", "Data de ocorrência", validate=dt_validate),
                    inquirer.Confirm("more", False, message="Deseja inserir mais um serviço?")
                ])

                dt = date_br_to_datetime(answer["dt_ocorrencia"])

                items.append((cod, dt, float(answer["emissao_assoc"])))

        if not answer["more"]:
            break

    return items


async def relatorio_insert(console: Console, conn: asyncpg.Connection):
    # Obtém as inst. cient. válidas
    result = await conn.fetch("SELECT cnpj, nome, mun_cod FROM inst_cient")
    inst_cient_names = [x["nome"] for x in result]

    answer = inquirer.prompt([
        inquirer.List("inst", message="Escolha a inst. cient. desenvolvendo o relatório", choices=inst_cient_names)
    ])

    chosen_inst_index = inst_cient_names.index(answer["inst"])

    cnpj_inst_cient = result[chosen_inst_index]["cnpj"]
    mun_cod_inst_cient = result[chosen_inst_index]["mun_cod"]

    # Obtém as equipes válidas
    result = await conn.fetch("SELECT nome FROM equipe_inst_cient WHERE cnpj_inst_cient = $1", cnpj_inst_cient)
    team_names = [x["nome"] for x in result]

    answer = inquirer.prompt([
        inquirer.List("equipe", message="Escolha a equipe responsável", choices=team_names)
    ])

    equipe = answer["equipe"]

    # Obtém filiais na mesma UF que a inst. cient.
    result = await conn.fetch("""
        SELECT
                cnpj_raiz || '/' || cnpj_ordem AS cnpj,
                f.end_rua, f.end_nro, f.end_cep,
                nome_mun, sigla_uf
            FROM filial AS f
            JOIN org_adm_mun ON cod_ibge = mun_cod
            WHERE substring(mun_cod, 1, 2) = substring($1, 1, 2)
            ORDER BY nome_mun, sigla_uf
    """, mun_cod_inst_cient)

    filiais_prox = []

    for row in result:
        [cnpj, end_rua, end_nro, end_cep, nome_mun, sigla_uf] = row

        filiais_prox.append(f"{cnpj} ({end_rua}, {end_nro}, CEP: {end_cep}; {nome_mun}, {sigla_uf})")

    filiais_prox.append("Outra")

    answer = inquirer.prompt([
        inquirer.List("filial", message="Escolha a filial a ser analisada", choices=filiais_prox)
    ])

    filial_index = filiais_prox.index(answer["filial"])

    if filial_index == len(filiais_prox) - 1:
        filial_cnpj = None

        while True:
            answer = inquirer.prompt([inquirer.Text("filial", message="Digite o CNPJ da filial sendo analisada", validate=cnpj_validate)])
            filial_cnpj = answer["filial"]

            result = await conn.fetchval("""
                SELECT 1
                    FROM filial
                    WHERE cnpj_raiz = split_part($1, '/', 1) AND cnpj_ordem = split_part($1, '/', 2)
            """, filial_cnpj)

            if result is not None:
                break

            console.print("[red]Filial não encontrada[/red]")
    else:
        filial_cnpj = result[filial_index]["cnpj"]

    cnpj_raiz, cnpj_ordem = filial_cnpj.split("/")

    answer_p = inquirer.prompt([
        inquirer.Text("dt_pedido", "Data do pedido", validate=dt_validate),
        inquirer.Confirm("prod", False, message="Você deseja inserir produtos no relatório?"),
        inquirer.Confirm("serv", False, message="Você deseja inserir serviços no relatório?"),
        inquirer.Confirm("published", False, message="Já foi publicado?")
    ])

    dt_pedido = date_br_to_datetime(answer_p["dt_pedido"])

    if answer_p["published"]:
        answer = inquirer.prompt([
            inquirer.Text("dt_pub", "Data de publicação", validate=lambda p, x: dt_validate(p, x) and dt_pedido < date_br_to_datetime(x))
        ])

        dt_pub = date_br_to_datetime(answer["dt_pub"])
    else:
        dt_pub = None

    if answer_p["prod"]:
        prods = await ask_prods_or_servs(console, conn, item_type="prod")
    else:
        prods = None

    if answer_p["serv"]:
        servs = await ask_prods_or_servs(console, conn, item_type="serv")
    else:
        servs = None

    async with conn.transaction(isolation="read_committed") as trans:
        id_relatorio = await conn.fetchval("""
            INSERT INTO relatorio VALUES (DEFAULT, $1, $2, $3, $4, $5, $6, NULL, NULL, NULL) RETURNING id
        """, dt_pedido, dt_pub, cnpj_raiz, cnpj_ordem, cnpj_inst_cient, equipe)

        if prods is not None:
            await conn.executemany(
                "INSERT INTO relatorio_prod(id_relatorio, ncm, tco2_p_un, qtde) VALUES ($1, $2, $3, $4)",
                ((id_relatorio, *x) for x in prods)
            )

        if servs is not None:
            await conn.executemany(
                "INSERT INTO relatorio_serv(id_relatorio, nbs, ocorrencia, tco2) VALUES ($1, $2, $3, $4)",
                ((id_relatorio, *x) for x in servs)
            )
