import Database from 'better-sqlite3';
import { getDatabasePath } from './pathResolver.js';
import { BrowserWindow } from 'electron';
import fs from 'fs';

// Load expanse.db from the database/ directory
const dbPath = getDatabasePath();

// Verify the database file exists before trying to open it
if (!fs.existsSync(dbPath)) {
    console.error(`Database file not found at: ${dbPath}`);
    throw new Error(`Database file not found at: ${dbPath}`);
}

const db = new Database(dbPath);

export function getQuestions(mainWindow: BrowserWindow) {
    return new Promise((resolve, reject) => {
        try {
            const stmt = db.prepare('SELECT * FROM questions');
            const questions = stmt.all();
            resolve(mainWindow.webContents.send('questions', questions));
        } catch (error) {
            reject(error);
        }
    });
}