const { app, BrowserWindow } = require('electron');
const path = require('path');

let mainWindow;

function createWindow() {
  mainWindow = new BrowserWindow({
    width: 1000,
    height: 800,
    webPreferences: {
      nodeIntegration: true,
      contextIsolation: false
    }
  });

  const isDev = !app.isPackaged;

  if (isDev) {
    // Load from React dev server
    mainWindow.loadURL('http://localhost:3000');
  } else {
    // Load the React build output
    mainWindow.loadFile(path.join(__dirname, '../frontend/build/index.html'));
  }
}

app.whenReady().then(createWindow);
