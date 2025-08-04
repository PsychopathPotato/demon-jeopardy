const electron = require('electron');

electron.contextBridge.exposeInMainWorld('electron', {
    getQuestions: () => electron.ipcRenderer.invoke('get-questions'),
    // Add other APIs as needed
});
