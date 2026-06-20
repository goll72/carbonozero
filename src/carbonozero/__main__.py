from rich.console import Console
from rich.panel import Panel
from rich.prompt import Prompt


import os
import sys

import asyncio
import asyncpg

from .common import text_bar
from .inst_cient import menu_inst_cient
from .org_adm import menu_org_adm


async def main():
    console = Console()

    user = os.environ.get("CZUSER", os.environ.get("PGUSER", "carbonozero"))
    database = os.environ.get("CZDATABASE", os.environ.get("PGDATABASE", "carbonozero"))
    
    conn = await asyncpg.connect(user=user, database=database)

    while True:
        console.print(text_bar("Sistema de Gestão --- CarbonoZero", console.width, aside=f"conectado: [{user}@{database}]"))

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

        console.print()


if __name__ == "__main__":
    asyncio.run(main())
