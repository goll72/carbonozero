#!/usr/bin/env python3

from faker import Faker
from argparse import ArgumentParser


def main():
    fake = Faker(["pt_BR"])

    parser = ArgumentParser()
    parser.add_argument("-n", type=int, help="How many values to generate", default=1)
    parser.add_argument("-t", "--type", choices=["address", "comp_name", "cnpj", "split_cnpj"])

    args = parser.parse_args()

    for i in range(args.n):
        match args.type:
            case "address":
                print(f"'{fake.street_name()}', {fake.random_number(digits=4)}, '{fake.cnpj()}'")
            case "comp_name":
                print(f"'{fake.random_company_noun_chain()}'")
            case "cnpj":
                print(f"'{fake.cnpj()}'")
            case "split_cnpj":
                cnpj = fake.cnpj()
                parts = cnpj.split("/")

                print(f"'{parts[0]}', '{parts[1]}'")


if __name__ == "__main__":
    main()
