from rich.console import Console
from rich.prompt import Prompt
from rich.panel import Panel
from rich.table import Table

from rich.markup import escape

import inquirer

from .common import text_bar, conn_status, cnpj_validation

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
                resp_text = await relatorio_insert(conn)
                console.print(escape(resp_text))


async def relatorio_insert(conn: asyncpg.Connection) -> str:
    inst_cient = inquirer.prompt([inquirer.Text("a", message="Qual o nome da inst. científica realizando o relatório?")])["a"]
    result = await conn.fetchrow("SELECT cnpj FROM inst_cient WHERE nome = $1;", inst_cient)
    if result == None:
        return "Nome da instituição científica não encontrada!"
    inst_cient = result["cnpj"]
    
    equipe = inquirer.prompt([inquirer.Text("a", message="Qual o nome da equipe de pesquisa?")])["a"]
    result = await conn.fetchrow("SELECT nome FROM equipe_inst_cient WHERE nome = $1 AND cnpj_inst_cient = $2;", equipe, inst_cient)
    if result == None:
        return "Nome da equipe não encontrada!"

    filial = inquirer.prompt([inquirer.Text("a", message="Qual o CNPJ da filial sendo analisada?", validate=cnpj_validation)])["a"]
    result = await conn.fetchrow("SELECT 1 FROM filial WHERE cnpj_raiz = $1 AND cnpj_ordem = $2;", equipe, inst_cient)
    if result == None:
        return "Filial não encontrada!"
    cnpj_empresa = filial[:10]
    cnpj_filial = filial[11:]

    return await conn.execute("INSERT INTO relatorio VALUES(DEFAULT, current_date, NULL, $1, $2, $3, $4, NULL, NULL, NULL)",
                                cnpj_empresa, cnpj_filial, inst_cient, equipe)
