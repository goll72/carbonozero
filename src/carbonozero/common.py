import os
import re

from rich.console import Console

import rich
import grapheme
import inquirer

from datetime import datetime

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


def cnpj_validate(answers: dict, current: str) -> bool:
    if not re.match(r"^[0-9A-Z]{2}\.[0-9A-Z]{3}\.[0-9A-Z]{3}/[0-9A-Z]{4}-[0-9]{2}$", current):
        raise inquirer.errors.ValidationError("", reason="CNPJ inválido")

    return True


def dt_validate(prev_answers: dict, current: str) -> bool:
    try:
        datetime.strptime(current, "%d/%m/%Y")
    except ValueError:
        raise inquirer.errors.ValidationError("", reason="Data inválida! Use o formato dia/mês/ano")

    return True


def ncm_pref_validate(prev_answers: dict, current: str) -> bool:
    # 0101.21.00
     if not re.match(r"^(\d{1,4}|\d{4}(\.\d{0,2})?|\d{4}\.\d{2}(\.\d{0,2})?|\d{4}\.\d{2}\.\d{0,2})", current):
         raise inquirer.errors.ValidationError("", reason="Código inválido! Use o formato xxxx.xx.xx")

     return True


def nbs_pref_validate(prev_answers: dict, current: str) -> bool:
    # 1.0101.30.00
    if not re.match(r"^(\d(\.\d{0,4})?|\d\.\d{4}(\.\d{0,2})?|\d\.\d{4}\.\d{2}(\.\d{0,2})?)", current):
        raise inquirer.errors.ValidationError("", reason="Código inválido! Use o formato x.xxxx.xx.xx")

    return True

 
def fix_ncm_nbs(x: str) -> str:
    return re.sub(r"^\s*-+\s*([dD]e)?\s*", "", x)


async def prompt_for_mun(console: Console, conn: asyncpg.Connection, *, uf_list: list[str]):
    while True:
        answer = inquirer.prompt([
            inquirer.Text("mun", "Município"),
            inquirer.List("uf", "Escolha a UF", choices=uf_list, carousel=True)
        ])

        mun_cod = await conn.fetchval("""
            SELECT cod_ibge FROM org_adm_mun WHERE nome_mun = $1 AND sigla_uf = $2
        """, answer["mun"], answer["uf"])

        if mun_cod is not None:
            return mun_cod

        console.print("[red]Município não encontrado[/red]")
        console.print()
