from flask import Flask, jsonify, request
import os
import psycopg2
from psycopg2.extras import RealDictCursor

app = Flask(__name__)

DB_URL = os.getenv('DB_URL', 'postgresql://appuser:password@postgres-service:5432/appdb')

def get_connection():
    return psycopg2.connect(DB_URL)

@app.route('/api/users', methods=['GET'])
def list_users():
    with get_connection() as conn:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute('SELECT id, name FROM users ORDER BY id')
            return jsonify(cur.fetchall())

@app.route('/api/users', methods=['POST'])
def add_user():
    data = request.get_json() or {}
    name = data.get('name', '').strip()
    if not name:
        return jsonify({'error': 'name is required'}), 400
    with get_connection() as conn:
        with conn.cursor() as cur:
            cur.execute('INSERT INTO users (name) VALUES (%s)', (name,))
            conn.commit()
    return jsonify({'name': name}), 201

@app.route('/api/health', methods=['GET'])
def health():
    return jsonify({'status': 'ok'})

def init_db():
    with get_connection() as conn:
        with conn.cursor() as cur:
            cur.execute(
                'CREATE TABLE IF NOT EXISTS users (id SERIAL PRIMARY KEY, name TEXT NOT NULL)'
            )
            conn.commit()

if __name__ == '__main__':
    init_db()
    app.run(host='0.0.0.0', port=8081)
