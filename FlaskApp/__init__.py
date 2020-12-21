from flask import Flask, render_template, session, redirect, request, url_for, json
from flaskext.mysql import MySQL

app = Flask(__name__)
app.secret_key = 'HOSPITAL'
mysql = MySQL()

app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'lmao123456789'
app.config['MYSQL_DATABASE_DB'] = 'HOSPITAL'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)

conn = mysql.connect()
cursor = conn.cursor()

from FlaskApp import routes
