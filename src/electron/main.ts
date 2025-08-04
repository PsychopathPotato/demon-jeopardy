import {app, BrowserWindow, ipcMain} from 'electron';
import path from 'path';
import {isDev} from './util.js';
import { getQuestions} from './db.js';
import { getPreloadPath } from './pathResolver.js';

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

    ipcMain.handle('get-questions', () => {
        return getQuestions();
    });
});