// database/setup.js
import fs from 'fs';
import path from 'path';
import Database from 'better-sqlite3';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const dbPath = join(__dirname, 'expanse.db');
const initSqlPath = path.join(__dirname, 'init.sql');
const initSql = fs.readFileSync(initSqlPath, 'utf8');

if (fs.existsSync(dbPath)) {
  fs.unlinkSync(dbPath); // Delete existing DB
}

const db = new Database(dbPath);
db.exec(initSql);

console.log('✅ Database created successfully from init.sql');

// The following SQL script is left in here until values for the questions have been added
// INSERT INTO Image (iId, iPath) VALUES ();
// INSERT INTO Answer (aId, qId, iId, aText) VALUES();
// INSERT INTO Icon (icoId, icoPath) VALUES();