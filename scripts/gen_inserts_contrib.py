#!/usr/bin/env python3

import random
from argparse import ArgumentParser

from datetime import date, timedelta

from faker import Faker

from common import FILIAIS_VALIDAS, ACOES_VALIDAS


def main():
    parser = ArgumentParser()
    parser.add_argument("-n", type=int)

    fake = Faker("pt_BR")

    args = parser.parse_args()

    used_tuples = set()

    for i in range(args.n):
        while True:
            p = random.choice(FILIAIS_VALIDAS)
            q = random.choice(ACOES_VALIDAS)

            h = (p, q)

            if h not in used_tuples:
                used_tuples.add(h)
                break

        (c1, c2, _) = p
        (a1, a2, a3) = q

        d = date.fromisoformat(a2)
        u = d + timedelta(days=90)

        print(
            "INSERT INTO vinc_contrib_co2 VALUES",
            f"    ({i + 1}, '{c1}', '{c2}', '{a1}', '{a2}', '{a3}');"
            "", "",
            sep="\n"
        )

        k = min(7, max(1, round(random.gauss(2, 2))))

        print("INSERT INTO contrib_co2 VALUES")

        used_dates = set()

        for j in range(k):
            while True:
                dc = fake.date_between_dates(d, u)

                if dc not in used_dates:
                    break

            v = int(round(max(3500, random.gauss(5000, 5000)), -2))

            print(f"    ({i + 1}, '{dc}', {v}){';' if j == k - 1 else ','}")

            used_dates.add(dc)

        print()


if __name__ == "__main__":
    main()
