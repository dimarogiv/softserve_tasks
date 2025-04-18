from flask import Flask
import mysql.connector

database = mysql.connector.connect(
        host = "db",
        user = "root",
        passwd = "password"
        )
cursor = database.cursor();


app = Flask(__name__)

@app.route('/show_databases')
def list_databases():
    cursor.execute("show databases")
    result = cursor.fetchall()
    html = ""
    debug = ""
    for i in result:
        debug = str(type(i))
        #html = html + i + "<br>"
    return str(result)
