import Database from 'better-sqlite3';
import { getDatabasePath } from './pathResolver.js';
import fs from 'fs';

// Load expanse.db from the database/ directory
const dbPath = getDatabasePath();

// Verify the database file exists before trying to open it
if (!fs.existsSync(dbPath)) {
    console.error(`Database file not found at: ${dbPath}`);
    throw new Error(`Database file not found at: ${dbPath}`);
}

const db = new Database(dbPath);
db.pragma('journal_mode = WAL');

export function getQuestions() {
    try {
        const stmt = db.prepare('SELECT * FROM Question');
        const questions = stmt.all();
        return questions;
    } catch (error) {
        console.log(error);
    }
};