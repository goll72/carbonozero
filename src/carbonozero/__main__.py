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
        exit(0)

    role_choice = int(role_choice)
    if role_choice != 0:
        console.print("Erro!! Cargo não foi implementado")
        exit(2)

    question = Text("Digite o CNPJ ou Município do usuário:", style="deep_sky_blue1", end="")
    org_admin_key = Prompt.ask(question, default=0, console=console)

    if str(role_choice) in EXIT_KEYS:
        exit(0)

    # TO-DO: CHECK THAT THE USER HAS SELECT A ORG_MUNI THAT'S IN THE DATABASE

    roles_table = Table(title="Operações")
    roles_table.add_column("Número", justify="center", style="cyan")
    roles_table.add_column("Desrição", justify="left", style="orange1")

    roles_table.add_row("Selecionar os próprios dados", "0")
    roles_table.add_row("Selecionar filiais e seus dados sob minha responsabilidade", "1")    
    roles_table.add_row("Selecionar leis que se aplicam em minha burocracia", "2")    
    roles_table.add_row("Selecionar instituições de pesquisa em uma região", "3")
    roles_table.add_row("Selecionar organizações socioambientais em uma região", "4")
    roles_table.add_row("Selecionar filiais que não receberam nehuma multa em um determinado ano", "5")

    while True:
        question = Text("Indique a operação desejada:", style="deep_sky_blue1", end="")
        role_choice = Prompt.ask(question, default=0, choices=["0", "1", "2", "3", "4", "q"], console=console)

        if str(role_choice) in EXIT_KEYS:
            exit(0)

        if role_choice == "0":
            console.print("Meus dados")
        elif role_choice == "1":
            console.print("Dados das filiais")
        elif role_choice == "2":
            console.print("Dados das leis")
        elif role_choice == "3":
            console.print("Dados das instituições de pesquisa")
        elif role_choice == "4":
            console.print("Dados das organizações socioambientais")
        elif role_choice == "5":
            question = Text("Digite a lista de anos que as filiais não receberam multa (ano, ano, ...):", style="deep_sky_blue2", end="")
            year_list = Prompt.ask(question, default=0, console=console)
        else:
            print("Algo de errado não está correto")

if __name__ == "__main__":
    main()
