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

// if you get an error running this 'node /src/models/setup.js', run the following scripts in the terminal:
// npm install --save-dev electron-rebuild
// npx electron-rebuild -f -w better-sqlite3
// npm rebuild