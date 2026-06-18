#!/usr/bin/env python3

from faker import Faker
from argparse import ArgumentParser
from datetime import date

import random
from math import floor

from common import ALLOWED_UF_VALUES, ALLOWED_UF_CDF, ALLOWED_NGO_VALUES, ALLOWED_NGO_CDF
from common import random_cep_for_uf


# Disclaimer: parts of this script are AI-generated.
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
