const { app, BrowserWindow } = require('electron');
const path = require('path');

function createWindow() {
  const win = new BrowserWindow({
    width: 1000,
    height: 800,
    webPreferences: {
      contextIsolation: false
    }
  });

  win.loadURL('http://localhost:3000');
}
const { getAllQuestions } = require('./db');

app.whenReady().then(() => {
  createWindow();

  const questions = getAllQuestions();
  console.log(questions); // You'll see this in your terminal
});

app.whenReady().then(createWindow);

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit();
});
