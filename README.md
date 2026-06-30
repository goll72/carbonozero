CarbonoZero
===========

CarbonoZero é um sistema fictício que permite monitorar
emissões de carbono por parte de empresas, permitindo
gerenciar análises de emissão, que são realizadas por
"instituições científicas", e aplicar regras de incentivo
fiscal ou penalização (multas) às empresas, de acordo
com os resultados obtidos.

## Uso

As dependências necessárias são as seguintes:

 - PostgreSQL 18
 - Python 3.12

Outras versões podem ser usadas, porém não há garantia de
compatibilidade.

### _Workflow_ padrão: nix

O _workflow_ recomendado consiste em usar um _nix devshell_
para instalar todas as dependências e configurar o banco
de dados automaticamente:

```sh
nix develop .
```

A seguir, algumas alternativas são mostradas. Porém, é importante
ressaltar que ambas as alternativas exigem que o Python e o
PostgreSQL sejam instalados e configurados manualmente.

As etapas do processo de configuração do PostgreSQL se encontram
no `shellHook` do `flake.nix`.

### Alternativa: uv

É possível fazer a instalação de dependências Python
manualmente, usando o `uv`:

```sh
uv sync
. .venv/bin/activate
```

### Alternativa: pip

O `pip` também pode ser usado, embora não seja recomendado:

```sh
python3 -m venv .venv
. .venv/bin/activate
pip install -e .
```

## Como rodar

Para inicializar a base de dados, rode o seguinte comando:

```sh
psql -f <(cat db/drop.sql db/schema.sql db/inserts.sql)
```

Tendo configurado o ambiente com a base de dados, a
aplicação pode ser executada com o seguinte comando:

```sh
python -m src.carbonozero
```
