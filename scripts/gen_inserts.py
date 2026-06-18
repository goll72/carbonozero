#!/usr/bin/env python3

from faker import Faker
from argparse import ArgumentParser
from datetime import date

import random
from math import floor


ALLOWED_UF_VALUES = ["SP", "MG", "RJ", "PR", "DF", "AM", "SC", "RS", "BA", "ES", "PE"]
ALLOWED_UF_CDF = [0.3, 0.55, 0.65, 0.75, 0.8, 0.85, 0.9, 0.93, 0.95, 0.97, 1.0]

# AI-generated!
UF_CEP_RANGES = {
    "SP": [(1_000_000, 19_999_999)],
    "RJ": [(20_000_000, 28_999_999)],
    "ES": [(29_000_000, 29_999_999)],
    "MG": [(30_000_000, 39_999_999)],
    "BA": [(40_000_000, 48_999_999)],
    "SE": [(49_000_000, 49_999_999)],
    "PE": [(50_000_000, 56_999_999)],
    "AL": [(57_000_000, 57_999_999)],
    "PB": [(58_000_000, 58_999_999)],
    "RN": [(59_000_000, 59_999_999)],
    "CE": [(60_000_000, 63_999_999)],
    "PI": [(64_000_000, 64_999_999)],
    "MA": [(65_000_000, 65_999_999)],
    "PA": [(66_000_000, 68_899_999)],
    "AP": [(68_900_000, 68_999_999)],
    "AM": [(69_000_000, 69_899_999)],
    "RR": [(69_300_000, 69_399_999)],
    "AC": [(69_900_000, 69_999_999)],
    "DF": [
        (70_000_000, 72_799_999),
        (73_000_000, 73_699_999),
    ],
    "GO": [
        (72_800_000, 72_999_999),
        (73_700_000, 76_799_999),
    ],
    "RO": [(76_800_000, 76_999_999)],
    "TO": [(77_000_000, 77_999_999)],
    "MT": [(78_000_000, 78_899_999)],
    "MS": [(79_000_000, 79_999_999)],
    "PR": [(80_000_000, 87_999_999)],
    "SC": [(88_000_000, 89_999_999)],
    "RS": [(90_000_000, 99_999_999)],
}

UF_CEP_MAP = {
    uf: (
        lambda ranges=ranges: random.randint(*random.choice(ranges))
    )
    for uf, ranges in UF_CEP_RANGES.items()
}


def random_cep_for_uf(uf: str) -> str:
    cep = UF_CEP_MAP[uf.upper()]()
    return f"{cep:08d}"


ALLOWED_NGO_VALUES = [
    ('35.179.804/0001-84', 'Pandas Sorridentes'),
    ('74.029.536/0001-76', 'WWF Brasil'),
    ('52.061.387/0001-90', 'EnxofreZero'),
    ('37.186.429/0001-25', 'Recicla+'),
    ('68.532.497/0001-22', 'Inova'),
    ('20.594.183/0001-28', 'Anti-Shell'),
    ('63.754.089/0001-00', 'Nature Collective'),
    ('07.219.354/0001-70', 'Associação Cultura Sustentável'),
    ('64.253.970/0001-81', 'Metrosus'),
    ('14.679.502/0001-03', 'Acolhe Agora'),
]

ALLOWED_NGO_CDF = [
    0.05,
    0.35,
    0.47,
    0.57,
    0.63,
    0.73,
    0.78,
    0.81,
    0.90,
    1.0
]

def main():
    fake = Faker(["pt_BR"])

    parser = ArgumentParser()
    parser.add_argument("-n", type=int, help="How many values to generate", default=1)
    parser.add_argument("-t", "--type", choices=[
        "address", "comp_name", "cnpj", "split_cnpj", "random_date_pair_b_after_a", "address+uf+cep", "acao_co2", "name"
    ])

    args = parser.parse_args()

    for i in range(args.n):
        match args.type:
            case "address":
                print(f"'{fake.street_name()}', {fake.random_number(digits=4)}, '{fake.cnpj()}'")
            case "comp_name":
                print(f"'{fake.company()}'")
            case "cnpj":
                print(f"'{fake.cnpj()}'")
            case "split_cnpj":
                cnpj = fake.cnpj()
                parts = cnpj.split("/")

                print(f"'{parts[0]}', '{parts[1]}'")
            case "random_date_pair_b_after_a":
                a = fake.date_between_dates(date(1990, 1, 1), date(2015, 12, 31))
                b = fake.date_between_dates(date(2021, 1, 1), date(2024, 12, 31))

                print(f"'{a.isoformat()}', '{b.isoformat()}'")
            case "address+uf+cep":
                s = fake.street_name()
                n = fake.random_number(digits=4)
                u, = random.choices(ALLOWED_UF_VALUES, cum_weights=ALLOWED_UF_CDF, k=1)

                c = random_cep_for_uf(u)

                print(f"'{s}', {n}, '{c[:5]}-{c[5:]}', '{u}'")
            case "acao_co2":
                c = random.choices(ALLOWED_NGO_VALUES, cum_weights=ALLOWED_NGO_CDF, k=1)[0][0]
                d = fake.date_between_dates(date(2020, 1, 1), date(2026, 6, 1))

                n = ""

                r = max(0.0005, random.gauss(0.001, 0.005))
                v = 10_000 * (max(50_000, random.gauss(100_000, 200_000)) // 10_000)

                # p1 + p2 + p3 = 100
                def gen_rnd_triple(seed=None):
                    while True:
                        k1 = random.random()
                        u = random.random()
                        k2 = abs(k1 - u)

                        p1 = floor(100 * k1)
                        p2 = floor(100 * k2)
                        p3 = 100 - p1 - p2

                        if seed is not None and abs(seed[0] - p1) + abs(seed[1] - p2) + abs(seed[2] - p3) > 50:
                            continue

                        if p3 > 0:
                            break

                        p2 = 100 - p1
                        p3 = 0

                        if seed is None or seed[2] == 0:
                            break

                    l = [p1, p2, p3]
                    random.shuffle([p1, p2, p3])
                    return l

                p = gen_rnd_triple()
                q = gen_rnd_triple(p)

                print(f"'{c}', '{d.isoformat()}', '{n}', {r:.3}, {v}, {p[0]}, {q[0]}, {p[1]}, {q[1]}, {p[2]}, {q[2]}")
            case "name":
                print(f"'{fake.name()}'")

if __name__ == "__main__":
    main()
