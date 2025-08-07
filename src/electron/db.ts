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

export function createSolo(sName: string, iconId: number) {
    try {
        const stmt = db.prepare(`INSERT INTO Solo (sName, iconId) VALUES (?, ?)`);
        stmt.run(sName, iconId);
    } catch (error) {
        console.log(error);
    }
    finally {
        db.close();
    }
};

export function getIcon(iconId: number) {
    try {
        const stmt = db.prepare(`SELECT iconName FROM Icon WHERE iconId = ?`);
        const icon = stmt.get(iconId) as { iconName: string } | undefined;
        return icon;
    } catch (error) {
        console.log(error);
    }
};

export function getSoloInfo(sId: number, iconId: number) {
    try {
        const stmt = db.prepare(`SELECT sName, iconName, sPoints 
            FROM Solo 
            WHERE sId = ?, iconId = ?
            JOIN Icon iconName ON Solo.iconId = Icon.iconId`);
        const solo = stmt.get(sId, iconId) as { sName: string; iconName: string; sPoints: number } | undefined;
        return solo;
    } catch (error) {
        console.log(error);
    } finally {
        db.close();
    }
};

export function createQTable() {
    try {
        const categories = db.prepare(`SELECT cId, cName FROM Category`).all() as { cId: number; cName: string }[];
        const getRandomQuestions = db.prepare(`
            SELECT q.qId, q.qText, q.cId, q.pId, p.pAmount
            FROM Question q
            JOIN Point p ON q.pId = p.pId
            WHERE q.cId = ? AND q.pId = ?
            ORDER BY RANDOM()
            LIMIT 1`);
            const result: { [key: string]: unknown[] } = {};
            for (const category of categories) {
                const questions = [];
                for (let pointId = 1; pointId <= 5; pointId++) {
                    const insertQTable = db.prepare(`INSERT INTO Q_Table (cId, qId) VALUES (?, ?)`);
                    const question = getRandomQuestions.get(category.cId, pointId) as { qId: number; qText: string; cId: number; pId: number; pAmount: number } | undefined;
                    if (question) {
                        questions.push(question);
                        insertQTable.run(category.cId, question.qId);
                    }
                }
                result[category.cName] = questions;
            }
            return result;
    } catch (error) {
        console.log(error);
    }
};

export function clearQTable () {
    try {
        const stmt = db.prepare(`DELETE FROM Q_Table`);
        stmt.run();
    } catch (error) {
        console.log(error);
    } finally {
        db.close();
    }
};

export function getQuestion(qId:number) {
    try {
        const stmt = db.prepare(`SELECT q.qText
            FROM Question q
            INNER JOIN Q_Table qt ON q.qId = qt.qId
            WHERE qt.qId = ?`);
        const question = stmt.get(qId) as { qText: string };
        return question?.qText;
    } catch (error) {
        console.log(error);
    }
};

export function getAnswer(qId: number) {
    try {
        const stmt = db.prepare(`SELECT a.aText
            FROM Answer a
            JOIN Q_Table qt ON a.qId = qt.qId
            WHERE a.qId = ?`);
        const img = stmt.get(qId) as { aText: string } | undefined;
        return img;
    } catch (error) {
        console.log(error);
    }
};