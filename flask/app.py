from flask import Flask
import mysql.connector

database = mysql.connector.connect(
        host = "db",
        user = "root",
        passwd = "password"
        )
cursor = database.cursor();


app = Flask(__name__)

@app.route('/<query>')
def list_databases(query):
    query = query.replace('-', ' ')
    cursor.execute(query)
    result = str(cursor.fetchall()).replace(',), (', '<br>')
    result = result.replace('[(', '', 1)
    result = result[::-1].replace('])'[::-1], ''[::-1], -1)[::-1]
    result = result[:-3]
    return str(result)
