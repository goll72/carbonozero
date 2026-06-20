from rich.console import Console
from rich.prompt import Prompt
from rich.panel import Panel

from .common import text_bar, conn_status

import asyncpg


async def menu_inst_cient(console: Console, conn: asyncpg.Connection):
    while True:
        console.print(text_bar("CarbonoZero --- Inst. Cient.", console.width, aside=conn_status(conn)))

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
