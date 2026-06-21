import os
import re

import rich
import grapheme

import asyncpg

from rich.text import Text
from rich.align import Align
from rich.console import Group


USER = os.environ.get("CZUSER", os.environ.get("PGUSER", "carbonozero"))
DATABASE = os.environ.get("CZDATABASE", os.environ.get("PGDATABASE", "carbonozero"))


def text_bar(
    text: str | rich.console.RenderableType,
    width: int,
    *,
    aside: str | rich.console.RenderableType = "",
):
    _len = grapheme.length(text)
    _len_aside = grapheme.length(aside)

    return Group(
        Text(),
        Align.center(
            Text(
                " " + text + " " * (width - _len - _len_aside - 2) + aside + " ",
                style="on grey15"
            )
        )
    )


def conn_status(conn: asyncpg.Connection) -> str:
    if conn.is_closed():
        return "desconectado: [-]"

    return f"conectado: [{USER}@{DATABASE}]"

def cnpj_validation(cnpj: str) -> bool:
    if not re.match(r"^[0-9A-Z]{2}\.[0-9A-Z]{3}\.[0-9A-Z]{3}/[0-9A-Z]{4}-[0-9]{2}$", cnpj):
        raise inquirer.errors.ValidationError("", reason="CNPJ inválido")
