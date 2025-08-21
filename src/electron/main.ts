import {app, BrowserWindow, ipcMain} from 'electron';
import path from 'path';
import fs from 'fs';
import {ipcMainHandle, isDev} from './util.js';
import { createSolo, getIcon, getSoloInfo, getQuestion, getAnswer, clearQTable, createQTable, changeSName, changeSIcon, createTeam, changeVName, changeVIcon, getTeamInfo, startSteal, stealSuccess, updateQTable, getTimer} from './db.js';
import { getPreloadPath, getDatabasePath, getIconPath, getImagePath } from './pathResolver.js';
import Database from 'better-sqlite3';

const dbPath = getDatabasePath();

if (!fs.existsSync(dbPath)) {
    console.error(`Database file not found at: ${dbPath}`);
    throw new Error(`Database file not found at: ${dbPath}`);
};

const db = new Database(dbPath);

app.on('ready', () => {
    const mainWindow = new BrowserWindow({
        width: 800,
        height: 600,
        webPreferences: {
            preload: getPreloadPath(),
            contextIsolation: true,
            nodeIntegration: false,
        },
    });

    if (isDev()) {
        mainWindow.loadURL('http://localhost:5123');
    } else {
        mainWindow.loadFile(path.join(app.getAppPath(), '/dist-react/index.html'));
    }

    ipcMainHandle<'createSolo', [string, number]>("createSolo", async (_event, sName, iconId) => {
        return createSolo({sName, iconId});
    });

    ipcMainHandle<'changeSName',[number, string]>("changeSName", async (_event, sId: number, sName: string) => {
        return changeSName({sId, sName});
    });

    ipcMain.handle('change-s-icon', async (_event, sId: number, iconId: number) => {
        return changeSIcon(sId, iconId);
    });

    ipcMain.handle('get-icon', async (_event, iconId: number) => {
        return getIcon(iconId);
    });

    ipcMain.handle('get-icon-path', async (_event, iconId: number) => {
        return getIconPath(iconId);
    });

    ipcMain.handle('get-solo', async (_event, sId: number, iconId: number) => {
        return getSoloInfo(sId, iconId);
    });

    ipcMain.handle('create-team', async (_event, vName: string, iconId: number) => {
        return createTeam(vName, iconId);
    });

    ipcMain.handle('change-v-name', async (_event, vId: number, vName: string) => {
        return changeVName(vId, vName);
    });

    ipcMain.handle('change-v-icon', async (_event, vId: number, iconId: number) => {
        return changeVIcon(vId, iconId);
    });

    ipcMain.handle('get-team', async (_event, vId: number, iconId: number) => {
        return getTeamInfo(vId, iconId);
    });

    ipcMainHandle('createTable', async () => {
        return createQTable();
    });

    ipcMain.handle('get-question', async (_event, qId: number) => {
        return getQuestion(qId);
    });

    ipcMain.handle('start-steal', async (_event, vId: number, qId: number) => {
        return startSteal(vId, qId);
    });

    ipcMain.handle('steal-success', async (_event, vId: number, qId: number, attempted: boolean) => {
        return stealSuccess(vId, qId, attempted);
    });

    ipcMain.handle('get-answer', async (_event, qId: number) => {
        return getAnswer(qId);
    });

    ipcMain.handle('get-image-path', async (_event, aId: number) => {
        return getImagePath(aId);
    });

    ipcMain.handle('update-table', async (_event, qId: number, aId: number) => {
        return updateQTable(qId, aId);
    });

    ipcMain.handle('get-timer', async (_event, qId: number) => {
        return getTimer(qId);
    });

    ipcMainHandle('clear', () => {
        return clearQTable();
    });
});

app.on('before-quit', () => {
    if (db && db.open) {
        db.close();
    }
});