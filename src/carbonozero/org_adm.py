from rich.console import Console
from rich.prompt import Prompt
from rich.panel import Panel
from rich.table import Table

from rich.markup import escape

import re
import time

import inquirer

from .common import text_bar, conn_status

import asyncpg


async def menu_org_adm(console: Console, conn: asyncpg.Connection):
    while True:
        console.print(text_bar("CarbonoZero --- Org. Adm.", console.width, aside=conn_status(conn)))

        menu = Panel(
            "\n".join([
                "[bold]\\[1][/bold] Consultar regras legislativas que se aplicam a uma jurisdição",
                "[bold]\\[2][/bold] Cadastrar regras legislativas",
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
                resp_text = await reg_leg_insertion(conn)
                console.print(resp_text[0] + ": " + resp_text[1])


def print_reg_leg_query_results(console: Console, result: list[asyncpg.Record], *, show_ent_fed: bool = False):
    with console.pager(styles=True):
        for row in result:
            [ent, tipo, nro, ano, dt_vigencia, dt_revogacao, nbs, ncm, lim_multa, base_calc_multa, meta_if, aliq_if, nbs_desc, ncm_desc] = row

            if ncm_desc:
                ncm_desc = re.sub(r"^\s*-+\s*([dD]e)?\s*", "", ncm_desc)

            if nbs_desc:
                nbs_desc = re.sub(r"^\s*-+\s*([dD]e)?\s*", "", nbs_desc)

            match tipo:
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
    available_uf = [x[0] for x in result]

    match answer["ent_fed"]:
        case "UF":
            answer = inquirer.prompt([
                inquirer.List("uf", "Escolha a UF", choices=available_uf, carousel=True)
            ])

            result = await conn.fetch("""
                SELECT  ent, tipo, nro, ano,
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
                    ORDER BY tipo, ano, dt_vigencia
            """, answer["uf"])

            print_reg_leg_query_results(console, result)
        case "Município":
            while True:
                answer = inquirer.prompt([
                    inquirer.Text("mun", "Município"),
                    inquirer.List("uf", "Escolha a UF", choices=available_uf, carousel=True)
                ])

                mun_cod = await conn.fetchval("""
                    SELECT cod_ibge FROM org_adm_mun WHERE nome_mun = $1 AND sigla_uf = $2
                """, answer["mun"], answer["uf"])

                if mun_cod is not None:
                    break

                console.print("[red]Município não encontrado[/red]")
                console.print()

            result = await conn.fetch("""
                SELECT  ent, tipo, nro, ano,
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
                    ORDER BY tipo, ano, dt_vigencia
            """, mun_cod)

            print_reg_leg_query_results(console, result, show_ent_fed=True)


async def reg_leg_insertion(conn: asyncpg.Connection):
    municipio_nome = str(Prompt.ask("Insira o nome do município > "))

    sigla_uf = str(Prompt.ask("Insira a sigla do estado > ")).upper()
    if len(sigla_uf) != 2:
        return;

    cod_ibge = await conn.fetchrow("SELECT cod_ibge FROM org_adm_mun AS adm WHERE adm.nome_mun = $1 AND adm.sigla_uf = $2;",
        municipio_nome, sigla_uf
    )

    ret_text = "Operação não-sucedida"
    ret_expl = "Donatello vagabundo"

    return [ret_text, ret_expl]
