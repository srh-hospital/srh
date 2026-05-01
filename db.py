import os
import mysql.connector
from flask import g

def get_db():
    if 'db' not in g:
        # Check if running on Railway, otherwise fall back to local XAMPP settings
        g.db = mysql.connector.connect(
            host=os.environ.get('DB_HOST', 'localhost'),
            user=os.environ.get('DB_USER', 'root'),
            password=os.environ.get('DB_PASSWORD', ''),
            database=os.environ.get('DB_NAME', 'rfid_db'),
            port=int(os.environ.get('DB_PORT', 3306))
        )
    return g.db