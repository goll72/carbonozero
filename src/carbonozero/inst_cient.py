from rich.console import Console
from rich.prompt import Prompt
from rich.panel import Panel
from rich.table import Table

from rich.markup import escape

import inquirer

from .common import text_bar, conn_status, fix_ncm_nbs
from .common import ncm_pref_validate, nbs_pref_validate, cnpj_validate, dt_validate

import asyncpg


async def menu_inst_cient(console: Console, conn: asyncpg.Connection):
    while True:
        console.print(text_bar("CarbonoZero --- Instituição Científica", console.width, aside=conn_status(conn)))

        menu = Panel(
            "\n".join([
                "[bold]\\[1][/bold] Cadastrar relatório",
                "[bold]\\[2][/bold] Consultar relatório(s)",
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
        


async def relatorio_insert(console: Console, conn: asyncpg.Connection):
    # Obtém as inst. cient. válidas
    result = await conn.fetch("SELECT cnpj, nome, mun_cod FROM inst_cient")
    inst_cient_names = [x["nome"] for x in result]

    answer = inquirer.prompt([
        inquirer.List("inst", message="Qual inst. cient. está realizando o relatório?", choices=inst_cient_names)
    ])

    chosen_inst_index = inst_cient_names.index(answer["inst"])
    
    cnpj_inst_cient = result[chosen_inst_index]["cnpj"]
    mun_cod_inst_cient = result[chosen_inst_index]["mun_cod"]

    # Obtém as equipes válidas
    result = await conn.fetch("SELECT nome FROM equipe_inst_cient WHERE cnpj_inst_cient = $1", cnpj_inst_cient)
    team_names = [x["nome"] for x in result]

    answer = inquirer.prompt([
        inquirer.List("equipe", message="Qual a equipe responsável?", choices=team_names)
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
        inquirer.List("filial", message="Qual filial será analisada?", choices=filiais_prox)
    ])

    filial_index = filiais_prox.index(answer["filial"])

    if filial_index == len(filiais_prox) - 1:
        filial_cnpj = None

        while True:
            answer = inquirer.prompt([inquirer.Text("filial", message="Qual o CNPJ da filial sendo analisada?", validate=cnpj_validate)])
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

    answer = inquirer.prompt([
        inquirer.Text("dt_pedido", "Qual a data do pedido?", validate=dt_validate),
        inquirer.Confirm("prod", False, message="Você deseja inserir produtos no relatório?"),
        inquirer.Confirm("serv", False, message="Você deseja inserir serviços no relatório?"),
        inquirer.Confirm("published", False, message="Já foi publicado?")
    ])

    if answer["prod"]:
        prods = []

        while True:
            answer = inquirer.prompt([
                inquirer.List("search_type", "Busca por NCM ou descrição", choices=["NCM", "Descrição"])
            ])

            match answer["search_type"]:
                case "NCM":
                    while True:
                        answer = inquirer.prompt([
                            inquirer.Text("ncm_pref", "NCM ou prefixo do NCM", validate=ncm_pref_validate)
                        ])

                        result = await conn.fetch("""
                            SELECT ncm, nome FROM prod_ncm WHERE ncm LIKE $1 || '%'
                        """, answer["ncm_pref"].replace("%", "%%"))

                        match len(result):
                            case 0:
                                console.print("[red]Nenhum produto encontrado com esse NCM[/red]")
                                continue
                            case 1:
                                ncm = result[0]["ncm"]
                            case _:
                                ncms = [f"{x["ncm"]} {fix_ncm_nbs(x["nome"])}" for x in result]
                                answer = inquirer.prompt([
                                    inquirer.List("ncm", "Resultados", choices=)
                                ])

                                ncm_index = ncms.index(answer["ncm"]) 
                                ncm = result[ncm_index]["ncm"]

                                break
                case "Descrição":
                    while True
                        answer = inquirer.prompt([
                            inquirer.Text("desc_subs", "Descrição (substring)")
                        ])

                        result = await conn.fetch("""
                            SELECT ncm, nome FROM prod_ncm WHERE UPPER(nome) LIKE '%' || UPPER($1) || '%'
                        """, answer["desc_subs"].replace("%", "%%"))

                        match len(result):
                            case 0:
                                console.print("[red]Nenhum produto encontrado com essa descrição[/red]")
                                continue
                            case 1:
                                ncm = result[0]["ncm"]
                            case _:
                                ncms = [f"{x["ncm"]} {fix_ncm_nbs(x["nome"])}" for x in result]
                                answer = inquirer.prompt([
                                    inquirer.List("ncm", "Resultados", choices=)
                                ])

                                ncm_index = ncms.index(answer["ncm"]) 
                                ncm = result[ncm_index]["ncm"]

                                break

            # answer = inquirer.prompt([
            #     inquirer.Text()
            # ])


    async with conn.transaction(isolation="read_committed") as trans:
        ...

    return await conn.execute("INSERT INTO relatorio VALUES(DEFAULT, current_date, NULL, $1, $2, $3, $4, NULL, NULL, NULL)",
                                cnpj_empresa, cnpj_filial, inst_cient, equipe)
