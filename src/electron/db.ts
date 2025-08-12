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

export function changeSName(sId: number, sName: string) {
    try {
        const stmt = db.prepare(`UPDATE Solo SET sName = ? WHERE sId = ?`);
        stmt.run(sName, sId);
    } catch (error) {
        console.log(error);
    }
    finally {
        db.close();
    }
};

export function changeSIcon(sId: number, iconId: number) {
    try {
        const stmt = db.prepare(`UPDATE Solo SET iconId = ? WHERE sId = ?`);
        stmt.run(sId, iconId);
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

export function createTeam(vName: string, iconId: number) {
    try {
        const stmt = db.prepare(`INSERT INTO Versus (vName, iconId) VALUES (?, ?)`);
        stmt.run(vName, iconId);
    } catch (error) {
        console.log(error);
    } finally {
        db.close();
    }
};

export function changeVName(vId: number, vName: string) {
    try {
        const stmt = db.prepare(`UPDATE Versus SET vName = ? WHERE vId = ?`);
        stmt.run(vName, vId);
    } catch (error) {
        console.log(error);
    } finally {
        db.close();
    }
};

export function changeVIcon(vId: number, iconId: number) {
    try {
        const stmt = db.prepare(`UPDATE Versus SET iconId = ? WHERE vId = ?`);
        stmt.run(iconId, vId);
    } catch (error) {
        console.log(error);
    } finally {
        db.close();
    }
};

export function getTeamInfo(vId: number, iconId: number) {
    try {
        const stmt = db.prepare(`SELECT vName, iconName, vPoints
            FROM Versus
            WHERE vId = ? AND Versus.iconId = ?
            JOIN Icon iconName ON Versus.iconId = Icon.iconId
            `);
        const teams = stmt.get(vId, iconId) as { vId: number; vName: string; iconName: string; vPoints: number }[];
        return teams;
    } catch (error) {
        console.log(error);
    } finally {
        db.close();
    }
};

export function startSteal(vId: number, qId: number) {
    try {
        const time = getTimer(qId) as { timeId: number };

        const insertSteal = db.prepare(`
            INSERT INTO Steal (vId, qId, timeId)
            VALUES (?, ?, ?)
        `);

        insertSteal.run(vId, qId, time.timeId);
    } catch (error) {
        console.error("Error inserting steal attempt:", error);
    }
};

export function stealSuccess(vId: number, qId: number, attempted: boolean) {
    try {

        const updateSteal = db.prepare(`
            UPDATE Steal
            SET attempted = 1
            WHERE vId = ? AND qId = ?
        `);

        updateSteal.run(vId, qId, attempted);
    } catch (error) {
        console.error("Error updating steal attempt:", error);
    }
};

export function createQTable(): QTableResult{
    try {
        const getCategories = db.prepare<[], Category>(`
            SELECT cId, cName FROM Category
        `);
        const categories = getCategories.all();

        const getRandomQuestions = db.prepare<[number, number], QuestionWithPoints>(`
            SELECT q.qId, q.qText, q.cId, q.pId, p.pAmount
            FROM Question q
            JOIN Point p ON q.pId = p.pId
            WHERE q.cId = ? AND q.pId = ?
            ORDER BY RANDOM()
            LIMIT 1
        `);

        const insertQTable = db.prepare<[number, number]>(`
            INSERT INTO Q_Table (cId, qId) VALUES (?, ?)
        `);

        const result: QTableResult = {};

        for (const category of categories) {
            const questions: QuestionWithPoints[] = [];

            for (let pointId = 1; pointId <= 5; pointId++) {
                const question = getRandomQuestions.get(category.cId, pointId);
                if (question) {
                    questions.push(question);
                    insertQTable.run(category.cId, question.qId);
                }
            }

            result[category.cName] = questions;
        }

        return result;
    } catch (error) {
        throw console.error(error);
    }
}

export function updateQTable(qId: number, cId: number) {
    try {
        const updateQTable = db.prepare(`
            UPDATE Q_Table 
            SET attempted = 1
            WHERE qId = ? & cId = ?`);
        updateQTable.run(cId, qId);
    } catch (error) {
        console.log(error);
    }
    finally {
        db.close();
    }
};

export function getTimer(qId: number) {
    try {
        const getTime = db.prepare(`
            SELECT pt.timeId
            FROM Question q
            JOIN Point pt ON q.pId = pt.pId
            WHERE q.qId = ?
        `);
        const timer = getTime.get(qId) as { timeId: number } | undefined;

        if (!timer) {
            throw new Error(`No timeId found for qId ${qId}`);
        }
        return timer
    } catch (error) {
        console.log(error);
    } finally {
        db.close();
    }
}

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

// setResults
// getResults
// clearResults
// setScoreboard
// getScoreboard
// updateScoreboard