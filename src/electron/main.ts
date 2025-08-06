import {app, BrowserWindow, ipcMain} from 'electron';
import path from 'path';
import {isDev} from './util.js';
import { createSolo, getIcon, getSoloInfo, getQuestion, createQTable} from './db.js';
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

    ipcMain.handle('create-solo', async (event, sName: string, iconId: number) => {
        return createSolo(sName, iconId);
    });

    ipcMain.handle('get-icon', async (event, iconId: number) => {
        return getIcon(iconId);
    });

    ipcMain.handle('get-icon-path', async (event, iconId: number) => {
        return getIconPath(iconId);
    });

    ipcMain.handle('get-solo', async (event, sId: number, iconId: number) => {
        return getSoloInfo(sId, iconId);
    });

        ipcMain.handle('create-table', async () => {
        return createQTable();
    });

    ipcMain.handle('get-question', async (event, qId: number) => {
        return getQuestion(qId);
    });

    ipcMain.handle('get-answer', async (event, aId: number) => {
        return getImagePath(aId);
    });

    ipcMain.handle('get-image-path', async (event, qId: number) => {
        return getImagePath(qId);
    });

    ipcMain.handle('clear', async () => {
        return createQTable();
    });

});