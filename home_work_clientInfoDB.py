import psycopg2
from psycopg2 import OperationalError
from psycopg2.sql import SQL, Identifier

# Функция, создающая структуру БД (таблицы).
def set_up_a_structure(conn):
    with conn.cursor() as cur:
        # затерли все что могло быть, для удобства
        cur.execute("""
            DROP TABLE IF EXISTS numbers;
            DROP TABLE IF EXISTS customers;
        """)
        conn.commit()
        # таблица с клиентами
        cur.execute("""
            CREATE TABLE IF NOT EXISTS customers(
                id SERIAL PRIMARY KEY,
                first_name VARCHAR(30) NOT NULL,
                last_name VARCHAR(30) NOT NULL,
                email VARCHAR(30) UNIQUE NOT NULL
            );
        """)
        # таблица с номерами телефонов
        cur.execute("""
            CREATE TABLE IF NOT EXISTS numbers(
                number VARCHAR(30) UNIQUE NOT NULL,
                customer_id INTEGER NOT NULL
            );
        """)
    conn.commit()

# Функция, позволяющая добавить нового клиента.
def add_customer(conn, first_name, last_name, email, numbers = None):
    with conn.cursor() as cur:
        # добавляем клиента в таблицу клиентов
        cur.execute("""
            INSERT INTO customers(first_name, last_name, email) VALUES(%s, %s, %s) RETURNING *;
        """, (first_name, last_name, email,))
        # и номера в таблицу с номерами
        customer_info = cur.fetchone()
        print(customer_info)
        if numbers != None:
            for number in numbers:
                cur.execute("""
                    INSERT INTO numbers(number, customer_id) VALUES(%s, %s) RETURNING *;
                """, (number, customer_info[0],))
                print(cur.fetchone())
    conn.commit()

# Функция, позволяющая добавить телефон для существующего клиента.
def add_numder(conn, number, customer_id):
    with conn.cursor() as cur:
        cur.execute("""
            INSERT INTO numbers(number, customer_id) VALUES(%s, %s) RETURNING *;
        """, (number, customer_id,))
        print(cur.fetchone())
    conn.commit()

# Функция, позволяющая изменить данные о клиенте.
def change_customer(conn, customer_id, first_name=None, last_name=None, email=None, numbers=None):
    with conn.cursor() as cur:
        arg_list = {'first_name': first_name, "last_name": last_name, 'email': email}
        for key, arg in arg_list.items():
            if arg:
                cur.execute(SQL("UPDATE customers SET {}=%s WHERE id=%s;").format(Identifier(key)), (arg, customer_id))
        # так как номера хранятся в другой таблице, то и работать с ними приходится отдельно
        if numbers != None:
            cur.execute("""
                DELETE FROM numbers WHERE customer_id = %s;
            """, (customer_id,))
            for number in numbers:
                cur.execute("""
                    INSERT INTO numbers(number, customer_id) VALUES(%s, %s);
                """, (number, customer_id,))
    conn.commit()

#Функция, позволяющая удалить телефон для существующего клиента.
def del_numder(conn, number):
    with conn.cursor() as cur:
        # Так как номера уникальны, то и id клиента нам знать не надо
        cur.execute("""
            DELETE FROM numbers WHERE number = %s;
        """, (number,))
    conn.commit()

# Функция, позволяющая удалить существующего клиента.
def del_customer(conn, customer_id):
    with conn.cursor() as cur:
        # сначала удаляем все номера
        cur.execute("""
            DELETE FROM numbers WHERE customer_id = %s;
        """, (customer_id,))
        # а потом клиента
        cur.execute("""
            DELETE FROM customers WHERE id = %s;
        """, (customer_id,))
    conn.commit()

# Функция, позволяющая найти клиента по его данным: имени, фамилии, email или телефону.
def find_customer(conn, first_name=None, last_name=None, email=None, number=None):
    with conn.cursor() as cur:
        # если указан номер, то находим id клиента
        if number != None:
            cur.execute("""
                SELECT customer_id FROM numbers
                    WHERE number = %s;
            """, (number,))
            id = cur.fetchone()
            arg_list = {'id': id, 'first_name': first_name, 'last_name': last_name, 'email': email}
        else:
            arg_list = {'first_name': first_name, 'last_name': last_name, 'email': email}

        for key, arg in arg_list.items():
            if arg:
                cur.execute(SQL("""
                    SELECT id, first_name, last_name, email, n.number FROM customers c
                    RIGHT JOIN numbers n on c.id = n.customer_id
                    WHERE {}=%s;
                """).format(Identifier(key)), (arg,))
                print(cur.fetchall())

# Подключились
try:
    conn = psycopg2.connect(database='clientInfoDB', user='postgres', password='postgres')
    print("Connection to PostgreSQL DB successful")
except OperationalError as e:
    print(f"The error '{e}' occurred")

# создали структуру
set_up_a_structure(conn)

add_customer(conn, 'Vova', 'Aboba', 'vovaaboba75@mail.ru', ('+7 987 726 62 73', '+7 821 293 02 30',))
add_customer(conn, 'Misha', 'Shisha', 'mishashisha73@mail.ru', ('+8 921 93 30',))
add_customer(conn, 'Vova', 'Shisha', 'vovashisha73@mail.ru', ('+8 123 44 30',))

add_numder(conn, '+1 234 567 89 10', 1)
add_numder(conn, '+1 234 312 82 10', 2)
add_numder(conn, '+1 225 567 54 32', 2)

change_customer(conn, 1, first_name='Grisha', last_name='Shisha', numbers=('+7 922 726 62 73', '+7 821 293 44 30',))

find_customer(conn, last_name='Shisha')

del_numder(conn, '+1 225 567 54 32')

del_customer(conn, 2)
find_customer(conn, last_name='Shisha')

find_customer(conn, number='+8 123 44 30')

conn.close()
