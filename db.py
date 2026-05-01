import mysql.connector
from flask import g
import os

DB_CONFIG = {
    "host":     os.getenv("DB_HOST", "localhost"),
    "port":     int(os.getenv("DB_PORT", 3306)),
    "user":     os.getenv("DB_USER", "root"),
    "password": os.getenv("DB_PASSWORD", "yourpassword"),
    "database": os.getenv("DB_NAME", "saint_raphael_hospital"),
}

def get_db():
    if "db" not in g:
        g.db = mysql.connector.connect(**DB_CONFIG)
    return g.db

def close_db(e=None):
    db = g.pop("db", None)
    if db is not None and db.is_connected():
        db.close()
