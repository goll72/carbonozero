from rich.console import Console
from rich.prompt import Prompt
from rich.panel import Panel
from rich.table import Table

from rich.markup import escape

import re
import time

import inquirer

from .common import text_bar, conn_status, fix_ncm_nbs, prompt_for_mun, cnpj_validate, int_validate, cep_validate

import asyncpg


async def menu_org_adm(console: Console, conn: asyncpg.Connection):
    while True:
        console.print(text_bar("CarbonoZero --- Org. Adm.", console.width, aside=conn_status(conn)))

        menu = Panel(
            "\n".join([
                "[bold]\\[1][/bold] Consultar regras legislativas que se aplicam a uma jurisdição",
                "[bold]\\[2][/bold] Atualizar dados de um orgão administrativo",
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
                await reg_leg_query(console, conn)
            case "2":
                await org_adm_update(console, conn)


def print_reg_leg_query_results(console: Console, result: list[asyncpg.Record], *, show_ent_fed: bool = False):
    with console.pager(styles=True):
        for row in result:
            [ent, cat, nro, ano, dt_vigencia, dt_revogacao, nbs, ncm, lim_multa, base_calc_multa, meta_if, aliq_if, nbs_desc, ncm_desc] = row

            if ncm_desc:
                ncm_desc = fix_ncm_nbs(ncm_desc)

            if nbs_desc:
                nbs_desc = fix_ncm_nbs(nbs_desc)

            match cat:
                case "if":
                    tipo_desc = "[green]Incentivo Fiscal[/green]"
                    reg_desc = f"alíquota de {aliq_if:.3}% para emissões mensais que não excedam {meta_if:.3} ton. CO₂"
                case "multa":
                    tipo_desc = "[red]Multa[/red]"
                    reg_desc = f"multa de R$ {base_calc_multa:.3} para cada ton. de CO₂ após {lim_multa:.3} ton. CO₂ mensais"

            console.print(f"Lei ṇ. [blue]{nro: 5}/{ano}[/blue], de {tipo_desc}:")
            console.print(f"    Entrou em vigor em [yellow]{dt_vigencia}[/yellow]{f", foi revogada em [yellow]{dt_revogacao}[/yellow]" if dt_revogacao is not None else ""}")
            console.print(u"    Dispõe sobre:")

            obj_desc = []

            if ncm is not None:
                obj_desc.append(f"emissões oriundas da fabricação/processamento de [yellow]{escape(ncm_desc)}[/yellow] ({ncm.strip()})")

            if nbs is not None:
                obj_desc.append(f"emissões oriundas da prestação de [yellow]{escape(nbs_desc)}[/yellow] ({nbs.strip()})")

            if not obj_desc:
                obj_desc.append("emissões em geral")

            console.print(" " * 8 + f"\n{" " * 8}".join(obj_desc))
            console.print()
            console.print(f"    {reg_desc}")
            console.print()
            console.print()


async def reg_leg_query(console: Console, conn: asyncpg.Connection) -> Table:
    answer = inquirer.prompt([inquirer.List("ent_fed", message="Você quer conferir uma UF ou um município?", choices=["UF", "Município"])])

    result = await conn.fetch("SELECT sigla FROM uf ORDER BY sigla ASC")
    uf_list = [x[0] for x in result]

    match answer["ent_fed"]:
        case "UF":
            answer = inquirer.prompt([
                inquirer.List("uf", "Escolha a UF", choices=uf_list, carousel=True)
            ])

            result = await conn.fetch("""
                SELECT  ent, categoria, nro, ano,
                        to_char(dt_vigencia, 'DD/MM/YYYY') AS dt_vigencia,
                        to_char(dt_revogacao, 'DD/MM/YYYY') AS dt_revogacao,
                        serv, prod,
                        lim_multa, base_calc_multa,
                        meta_if, aliq_if,
                        serv_nbs.nome AS nbs_desc, prod_ncm.nome AS ncm_desc
                    FROM reg_leg
                    JOIN prod_ncm ON prod = ncm
                    JOIN serv_nbs ON serv = nbs
                    WHERE ent = (SELECT cod_ibge FROM uf WHERE sigla = $1)
                    ORDER BY ent, categoria, ano, dt_vigencia
            """, answer["uf"])

            print_reg_leg_query_results(console, result)
        case "Município":
            mun_cod = await prompt_for_mun(console, conn, uf_list=uf_list)

            result = await conn.fetch("""
                SELECT  ent, categoria, nro, ano,
                        to_char(dt_vigencia, 'DD/MM/YYYY') AS dt_vigencia,
                        to_char(dt_revogacao, 'DD/MM/YYYY') AS dt_revogacao,
                        serv, prod,
                        lim_multa, base_calc_multa,
                        meta_if, aliq_if,
                        serv_nbs.nome AS nbs_desc, prod_ncm.nome AS ncm_desc
                    FROM reg_leg
                    JOIN prod_ncm ON prod = ncm
                    JOIN serv_nbs ON serv = nbs
                    WHERE ent = $1 OR ent = substring($1, 1, 2)
                    ORDER BY ent, categoria, ano, dt_vigencia
            """, mun_cod)

            print_reg_leg_query_results(console, result, show_ent_fed=True)

async def org_adm_update(console: Console, conn: asyncpg.Connection):
    result = await conn.fetch("SELECT sigla FROM uf ORDER BY sigla ASC")
    uf_list = [x[0] for x in result]
    mun_cod = await prompt_for_mun(console, conn, uf_list=uf_list)

    row = await conn.fetchrow("SELECT cnpj, raz_soc, end_rua, end_nro, end_cep FROM org_adm_mun WHERE cod_ibge = $1", mun_cod)
    cnpj = row["cnpj"]
    raz_soc = row["raz_soc"]
    end_rua = row["end_rua"]
    end_nro = row["end_nro"]
    end_cep = row["end_cep"]

    answer = inquirer.prompt([inquirer.Checkbox(
        "fields",
        message="Quais campos atualizar? (Use as setas esquerda e direita para selecionar)",
        choices=[
            ("CNPJ", "cnpj"),
            ("Razão Social", "raz_soc"),
            ("Endereço", "end"),
        ])])

    if "cnpj" in answer["fields"]:
        while True:
            cnpj = inquirer.prompt([inquirer.Text("a", message="Digite o novo CNPJ", validate=cnpj_validate)])["a"]
            console.print(cnpj)

            if await conn.fetchrow("SELECT cnpj FROM org_adm_mun WHERE cnpj = $1", cnpj) == None:
                break
            console.print("Este CNPJ já está cadastrado.")

    if "raz_soc" in answer["fields"]:
        raz_soc = inquirer.prompt([inquirer.Text("a", message="Digite a nova razão social")])["a"]
        
    if "end" in answer["fields"]:
        questions = [
            inquirer.Text("end_rua", message="Digite a rua", validate=lambda _,c: 0 < len(c) <= 50),
            inquirer.Text("end_nro", message="Digite o número", validate=int_validate),
            inquirer.Text("end_cep", message="Digite o CEP", validate=cep_validate)
        ]
        end = inquirer.prompt(questions)
        end_rua = end["end_rua"]
        end_nro = int(end["end_nro"])
        end_cep = end["end_cep"]

    sql_status = await conn.execute('''
        UPDATE org_adm_mun SET (cnpj, raz_soc, end_rua, end_nro, end_cep) = ($1, $2, $3, $4, $5) WHERE cod_ibge = $6
        ''',
        cnpj, raz_soc, end_rua, end_nro, end_cep, mun_cod
    )
    console.print(sql_status)
    return
