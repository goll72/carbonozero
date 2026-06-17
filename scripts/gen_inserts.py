#!/usr/bin/env python3

from faker import Faker
from argparse import ArgumentParser

import datetime


def main():
    fake = Faker(["pt_BR"])

    parser = ArgumentParser()
    parser.add_argument("-n", type=int, help="How many values to generate", default=1)
    parser.add_argument("-t", "--type", choices=["address", "comp_name", "cnpj", "split_cnpj", "random_date_pair_b_after_a"])

    args = parser.parse_args()

    now = datetime.date.today()

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
                a = fake.date_between_dates(datetime.date(1990, 1, 1), datetime.date(2015, 12, 31))
                b = fake.date_between_dates(datetime.date(2021, 1, 1), datetime.date(2024, 12, 31))

                print(f"'{a.isoformat()}', '{b.isoformat()}'")

if __name__ == "__main__":
    main()
