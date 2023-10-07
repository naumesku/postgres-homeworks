"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2
from pathlib import Path
import csv

PATH_ORDERS = Path(__file__).parent.joinpath("north_data").joinpath("orders_data.csv")
PATH_EMPLOYEES = Path(__file__).parent.joinpath("north_data").joinpath("employees_data.csv")
PATH_CUSTOMERS_DATA = Path(__file__).parent.joinpath("north_data").joinpath("customers_data.csv")
#Пути к файлам

def filling_table(path, table):
    '''Наполняет таблицу данными из csv файла'''
    with psycopg2.connect(host="localhost", database="north", user="postgres", password="qqqzzz") as conn:
        with conn.cursor() as cur:
            with open(path, 'r') as csv_file:
                csv_data = csv.reader(csv_file)
                next(csv_data)
                for line in csv_data:
                    values = ("%s," * len(line))[:-1]
                    cur.execute(f"INSERT INTO {table} VALUES ({values})", line)
                    conn.commit()
    conn.close()

if __name__ == '__main__':
    filling_table(PATH_CUSTOMERS_DATA, "customers")
    filling_table(PATH_EMPLOYEES, "employees")
    filling_table(PATH_ORDERS, "orders")
