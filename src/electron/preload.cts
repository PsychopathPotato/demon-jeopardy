const electron = require('electron');

electron.contextBridge.exposeInMainWorld('electron', {
    createSolo: (sName: string, iconId: number) => electron.ipcRenderer.invoke('create-solo', sName, iconId),
    getIcon:(iconId: number) => electron.ipcRenderer.invoke('get-icon', iconId),
    getIconPath: (iconId: number) => electron.ipcRenderer.invoke('get-icon-path', iconId),
    getSoloInfo: (sId: number, iconId: number) => electron.ipcRenderer.invoke('get-solo', sId, iconId),
    createQTable: () => electron.ipcRenderer.invoke('create-table'),
    getQuestion: (qId:number) => electron.ipcRenderer.invoke('get-question', qId),
    getAnswer: (qId: number) => electron.ipcRenderer.invoke('get-answer', qId),
    getImagePath: (qId: number) => electron.ipcRenderer.invoke('get-image-path', qId),
    clearQTable: () => electron.ipcRenderer.invoke('clear')
});
