#!/usr/bin/env python3

import argparse
import csv
import random
from datetime import datetime, timedelta, date
from dateutil.relativedelta import relativedelta   

from faker import Faker

from common import EQUIPES_VALIDAS, ENTES_FEDERATIVOS_V, FILIAIS_VALIDAS

fake = Faker("pt_BR")

# Disclaimer: major parts of this script are AI-generated.

FILIAL_PROFILES = {}

# ============================================================
# Utilidades
# ============================================================


def sql_literal(value):
    if value is None:
        return "NULL"

    if isinstance(value, str):
        return "'" + value.replace("'", "''") + "'"

    if isinstance(value, datetime):

        return f"'{value.isoformat(timespec='seconds')}'"

    if isinstance(value, date):
        return f"'{value.isoformat()}'"

    return str(value)


def choose_team_for_filial(filial_uf):
    equipes_mesma_uf = [
        equipe
        for equipe in EQUIPES_VALIDAS
        if equipe[2] == filial_uf
    ]

    if equipes_mesma_uf:
        return random.choice(equipes_mesma_uf)

    return random.choice(EQUIPES_VALIDAS)


def create_filial_profile():
    tipo = random.choices(
        [
            "industrial",
            "servicos",
            "mista",
        ],
        weights=[50, 25, 25]
    )[0]

    concentrada = random.random() < 0.35

    return {
        "tipo": tipo,
        "concentrada": concentrada
    }


def load_codes(csv_file):
    """
    CSV delimitado por ';'

    Exemplo:
    codigo;nome
    01012100;Cavalos reprodutores
    """
    result = []

    with open(csv_file, encoding="utf-8") as f:
        reader = csv.reader(f, delimiter=";")

        next(reader, None)

        for row in reader:
            if not row:
                continue

            result.append(row[0].strip())

    return result


def random_date(start_year=2018, end_year=2026):
    start = datetime(start_year, 1, 1)
    end = datetime(end_year, 12, 31)

    delta = (end - start).days

    return (start + timedelta(days=random.randint(0, delta))).date()


def emission_value():
    """
    Distribuição dispersa com outliers.

    ~90% dos casos:
        log-normal moderada

    ~10% dos casos:
        log-normal pesada
    """

    if random.random() < 0.90:
        value = random.lognormvariate(1.2, 0.8)
    else:
        value = random.lognormvariate(4.0, 1.1)

    return round(value, 4)


def monetary_value():
    if random.random() < 0.95:
        value = random.lognormvariate(5.0, 0.7)
    else:
        value = random.lognormvariate(8.0, 1.0)

    return round(value, 2)


# ============================================================
# REG_LEG
# ============================================================

def generate_reg_leg(n, ncm_codes, nbs_codes):
    tipos = ["if", "multa"]

    for _ in range(n):
        tipo = random.choice(tipos)

        ent = random.choice(ENTES_FEDERATIVOS_V)

        nro = random.randint(1, 5000)
        ano = random.randint(2015, 2026)

        dt_vigencia = random_date(2015, 2026)

        if random.random() < 0.15:
            dt_revogacao = dt_vigencia + timedelta(
                days=random.randint(30, 2500)
            )
        else:
            dt_revogacao = None

        serv = None
        prod = None

        if random.random() < 0.5:
            serv = random.choice(nbs_codes)

        if random.random() < 0.5:
            prod = random.choice(ncm_codes)

        if tipo == "multa":
            lim_multa = monetary_value()
            base_calc_multa = round(random.uniform(0.01, 0.25), 4)

            meta_if = None
            aliq_if = None

        else:
            lim_multa = None
            base_calc_multa = None

            meta_if = round(emission_value(), 4)
            aliq_if = round(random.uniform(0.001, 0.08), 4)

        values = [
            ent,
            tipo,
            nro,
            ano,
            dt_vigencia.isoformat(),
            dt_revogacao.isoformat() if dt_revogacao else None,
            serv,
            prod,
            lim_multa,
            base_calc_multa,
            meta_if,
            aliq_if,
        ]

        print(
            "("
            + ", ".join(sql_literal(v) for v in values)
            + "),"
        )


def choose_prod_serv_counts(profile):
    tipo = profile["tipo"]

    if tipo == "industrial":
        n_prod = random.randint(8, 30)
        n_serv = random.randint(0, 4)

    elif tipo == "servicos":
        n_prod = random.randint(0, 3)
        n_serv = random.randint(10, 40)

    else:
        n_prod = random.randint(5, 15)
        n_serv = random.randint(5, 15)

    return n_prod, n_serv


def choose_dominant_code(codes):
    return random.choice(codes)


def generate_weights(n, concentrated=False):
    if n == 0:
        return []

    if concentrated and n > 1:
        alpha = [20.0]

        alpha.extend(
            [0.7] * (n - 1)
        )
    else:
        alpha = [1.5] * n

    weights = list(
        random_dirichlet(alpha)
    )

    return weights


def random_dirichlet(alpha):
    samples = [
        random.gammavariate(a, 1.0)
        for a in alpha
    ]

    total = sum(samples)

    return [x / total for x in samples]


def emit_relatorio_sql(data):
    r = data["relatorio"]

    print(
        "INSERT INTO relatorio VALUES",
        "    (" + ", ".join(sql_literal(x) for x in r) + ")",
        "ON CONFLICT DO NOTHING;",
        sep="\n"
    )

    print()

    prod = data["produtos"]
    serv = data["servicos"]

    if len(prod) > 0:
        print("INSERT INTO relatorio_prod VALUES")

    for index, row in enumerate(prod):
        print(
            "    (" + ", ".join(sql_literal(x) for x in row) + ")",
            end=""
        )

        print("\nON CONFLICT DO NOTHING;" if index == len(prod) - 1 else ",")

    if len(prod) > 0:
        print()

    if len(serv) > 0:
        print("INSERT INTO relatorio_serv VALUES")

    for index, row in enumerate(serv):
        print(
            "    (" + ", ".join(sql_literal(x) for x in row) + ")",
            end=""
        )

        print("\nON CONFLICT DO NOTHING;" if index == len(serv) - 1 else ",")

    if len(serv) > 0:
        print()


def generate_relatorio(
    report_id,
    ncm_codes,
    nbs_codes,
):
    filial = random.choice(FILIAIS_VALIDAS)

    cnpj_raiz = filial[0]
    cnpj_ordem = filial[1]
    filial_uf = filial[2]

    equipe = choose_team_for_filial(
        filial_uf
    )

    cnpj_inst = equipe[0]
    nome_equipe = equipe[1]

    profile = FILIAL_PROFILES[
        (cnpj_raiz, cnpj_ordem)
    ]

    dt_pedido = fake.date_between(
        start_date="-5y",
        end_date=date(2026, 4, 12)
    )

    if random.random() < 0.5:
        dt_pub = fake.date_between_dates(dt_pedido + timedelta(days=40), date(2026, 6, 15))
    else:
        dt_pub = None

    total_emission = emission_value()

    n_prod, n_serv = choose_prod_serv_counts(profile)

    prod_codes = random.sample(
        ncm_codes,
        min(n_prod, len(ncm_codes))
    )

    serv_codes = random.sample(
        nbs_codes,
        min(n_serv, len(nbs_codes))
    )

    if profile["tipo"] == "industrial":
        prod_total = (
            total_emission *
            random.uniform(0.70, 0.98)
        )

    elif profile["tipo"] == "servicos":
        prod_total = (
            total_emission *
            random.uniform(0.00, 0.20)
        )

    else:
        prod_total = (
            total_emission *
            random.uniform(0.30, 0.70)
        )

    serv_total = total_emission - prod_total

    prod_weights = generate_weights(
        len(prod_codes),
        profile["concentrada"]
    )

    serv_weights = generate_weights(
        len(serv_codes),
        profile["concentrada"]
    )

    # nm = next month
    dt_ped_nm = dt_pedido + relativedelta(months=1)
    dt_ped_nm = date(dt_ped_nm.year, dt_ped_nm.month, 1)

    return {
        "relatorio": (
            report_id,
            dt_pedido,
            dt_pub,
            cnpj_raiz,
            cnpj_ordem,
            cnpj_inst,
            nome_equipe,
            None,
            None,
            None
        ),

        "produtos": [
            (
                report_id,
                code,
                round(prod_total * w, 4),
                max(400, random.gauss(4000, 5000))
            )
            for code, w in zip(
                prod_codes,
                prod_weights
            )
        ],

        "servicos": [
            (
                report_id,
                code,
                datetime.fromisoformat(str(fake.date_time_between_dates(
                    dt_ped_nm,
                    dt_ped_nm + relativedelta(months=1) - timedelta(days=1)
                ))),
                round(serv_total * w, 4)
            )
            for code, w in zip(
                serv_codes,
                serv_weights
            )
        ]
    }



# ============================================================
# Main
# ============================================================

def main():
    parser = argparse.ArgumentParser()

    parser.add_argument(
        "--type",
        required=True,
        choices=[
            "reg_leg",
            "relatorio"
        ]
    )

    parser.add_argument(
        "--count",
        type=int,
        required=True
    )

    parser.add_argument(
        "--ncm-csv",
        help="CSV de produtos NCM"
    )

    parser.add_argument(
        "--nbs-csv",
        help="CSV de serviços NBS"
    )

    args = parser.parse_args()

    ncm_codes = []
    nbs_codes = []

    if args.ncm_csv:
        ncm_codes = load_codes(args.ncm_csv)

    if args.nbs_csv:
        nbs_codes = load_codes(args.nbs_csv)

    for filial in FILIAIS_VALIDAS:
        FILIAL_PROFILES[filial[:2]] = create_filial_profile()

    if args.type == "reg_leg":
        generate_reg_leg(
            args.count,
            ncm_codes,
            nbs_codes
        )
    elif args.type == "relatorio":
        for report_id in range(
            1,
            args.count + 1
        ):
            rel = generate_relatorio(
                report_id,
                ncm_codes,
                nbs_codes
            )

            emit_relatorio_sql(rel)


if __name__ == "__main__":
    main()
