import pymysql

try:
    connection = pymysql.connect(
        host='localhost',
        user='your_username',
        password='your_password',
        database='week2',
        local_infile=1
    )

    with connection.cursor() as cursor:
        # filter only 5 rows
        query = """
        SELECT * FROM cab_trips
        LIMIT 5;
        """
        cursor.execute(query)
        result = cursor.fetchall()

        # show the result
        for row in result:
            print(row)

except pymysql.MySQLError as e:
    print(f"Error occurred: {e}")
finally:
    if connection:
        connection.close()  # close if it is opened

