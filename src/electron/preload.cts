const electron = require('electron');

electron.contextBridge.exposeInMainWorld('api', {
    getQuestions: () => electron.ipcRenderer.invoke('get-questions'),
    // Add other APIs as needed
});
