from rich.console import Console
from rich.prompt import Prompt
from rich.panel import Panel

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
