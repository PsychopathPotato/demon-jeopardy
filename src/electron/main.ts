import {app, BrowserWindow, ipcMain} from 'electron';
import path from 'path';
import {isDev} from './util.js';
import { createSolo, getIcon, getSoloInfo, getQuestion, getAnswer, clearQTable, createQTable, changeSName, changeSIcon, createTeam, changeVName, changeVIcon, getTeamInfo, startSteal, stealSuccess, updateQTable, getTimer} from './db.js';
import { getPreloadPath, getIconPath, getImagePath } from './pathResolver.js';

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

    ipcMain.handle('create-solo', async (_event, sName: string, iconId: number) => {
        return createSolo(sName, iconId);
    });

    ipcMain.handle('change-s-name', async (_event, sId: number, sName: string) => {
        return changeSName(sId, sName);
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

    ipcMain.handle('create-table', async () => {
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

    ipcMain.handle('clear', async () => {
        return clearQTable();
    });
});