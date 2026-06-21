from rich.console import Console
from rich.prompt import Prompt
from rich.panel import Panel
from rich.table import Table

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
                resp_table = await reg_leg_query(conn)
                console.print(resp_table)
            case "2":
                resp_text = await reg_leg_insertion(conn)
                console.print(resp_text[0] + ": " + resp_text[1])

async def reg_leg_query(conn: asyncpg.Connection) -> Table:
    municipio_nome = str(Prompt.ask("Insira o nome do município > "))

    sigla_uf = str(Prompt.ask("Insira a sigla do estado > ")).upper()
    if len(sigla_uf) != 2:
        return;

    reg_leg_list = await conn.fetch('''
        WITH cod(mun, uf) AS (
            SELECT cod_ibge, substring(cod_ibge, 1, 2) FROM org_adm_mun WHERE nome_mun = $1 AND sigla_uf = $2
        )
        SELECT * FROM reg_leg, cod WHERE ent = cod.uf
            OR ent = cod.mun
        ORDER BY reg_leg.nro ASC;''',
        municipio_nome, sigla_uf
    )

    if len(reg_leg_list) == 0:
        return;

    query_list = Table(title = "Regras Legislativas")
    query_list.add_column("Número")
    query_list.add_column("Ano")
    query_list.add_column("Data de vigência")
    query_list.add_column("Data de revogação")
    query_list.add_column("Referente")
    query_list.add_column("NCM/NBS")
    query_list.add_column("Tipo")
    query_list.add_column("Limite/Meta")
    query_list.add_column("Multa por tCO2/Alíquota")


    for row in reg_leg_list:
        refer = "Geral"
        cod_nacional = "NULL"
        if row["prod"]:
            refer = "Produto"
            cod_nacional = str(row["prod"])
        elif row["serv"]:
            refer = "Serviço"
            cod_nacional = str(row["serv"])

        tipo_pretty = ""
        lim_meta = ""
        multa_if = ""
        if str(row["tipo"]) == "multa":
            tipo_pretty = "Multa"
            lim_meta = str(row["lim_multa"])
            multa_if = str(row["base_calc_multa"])
        elif str(row["tipo"]) == "if":
            tipo_pretty = "Isenção Fiscal"
            lim_meta = str(row["meta_if"])
            multa_if = str(row["aliq_if"])

        query_list.add_row(str(row["nro"]), str(row["ano"]), str(row["dt_vigencia"]), str(row["dt_revogacao"]), refer, cod_nacional, tipo_pretty, lim_meta, multa_if)

    return query_list;

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
