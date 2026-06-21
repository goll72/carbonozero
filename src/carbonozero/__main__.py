from rich.console import Console
from rich.panel import Panel
from rich.prompt import Prompt

import os
import sys

import asyncio
import asyncpg

from .common import text_bar, USER, DATABASE, conn_status
from .inst_cient import menu_inst_cient
from .org_adm import menu_org_adm


async def main():
    console = Console()

    # Para obtermos paginação com cores
    os.environ["MANPAGER"] = "less -r"

    conn = await asyncpg.connect(user=USER, database=DATABASE)

    while True:
        console.print(text_bar("Sistema de Gestão --- CarbonoZero", console.width, aside=conn_status(conn)))

        menu = Panel(
            "\n".join([
                "[bold]\\[1][/bold] Inst. Cient.",
                "[bold]\\[2][/bold] Org. Adm.",
                "",
                "[bold]\\[q][/bold] Sair"
            ]),
            title="Bem vindo ao CarbonoZero!"
        )

        console.print(menu)
        ret = Prompt.ask("> ", choices=["1", "2", "q"])

        match ret:
            case "q" | "Q":
                sys.exit()
            case "1":
                await menu_inst_cient(console, conn)
            case "2":
                await menu_org_adm(console, conn)


if __name__ == "__main__":
    asyncio.run(main())
