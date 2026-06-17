from rich.align import Align
from rich.prompt import Prompt
from rich.console import Console, Group
from rich.table import Table
from rich.panel import Panel
from rich.text import Text

EXIT_KEYS = "qQ"

def main():
    console = Console()
    console.clear()

    panel_title = Text("Bem vindo ao sistema CarbonoZero!")
    warning = Text("Aperte <q> para sair.")

    roles_table = Table(title="Cargos")
    roles_table.add_column("Nome", justify="center", style="orange1")
    roles_table.add_column("Número", justify="left", style="cyan")

    roles_table.add_row("Orgão Administrativo", "0")
    roles_table.add_row("Empresa (não implementatado)", "1")    
    roles_table.add_row("Filial (não implementatado)", "2")    
    roles_table.add_row("Instituição de pesquisa (não implementatado)", "3")
    roles_table.add_row("Organização Socioambiental (não implementatado)", "4")

    console.print(Panel(Align(roles_table, align="center"),
                        title=panel_title,
                        title_align="left",
                        subtitle=warning,
                        subtitle_align="right"))

    question = Text("Selecione o cargo que o senhor quer acessar:", style="deep_sky_blue1", end="")
    role_choice = Prompt.ask(question, default=0, choices=["0", "1", "2", "3", "4", "q"], console=console)

    if str(role_choice) in EXIT_KEYS:
        return

    role_choice = int(role_choice)

if __name__ == "__main__":
    main()
