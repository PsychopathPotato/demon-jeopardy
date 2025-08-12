import { IpcRendererEvent } from "electron";

const electron = require('electron');


function ipcInvoke<Key extends keyof EventPayloadMapping>(
    key: Key
): Promise<EventPayloadMapping[Key]> {
    return electron.ipcRenderer.invoke(key);
};

function ipcOn<Key extends keyof EventPayloadMapping>(
    key: Key,
    callback: (payload: EventPayloadMapping[Key]) => void
) {
    electron.ipcRenderer.on(key, (_: IpcRendererEvent, payload: EventPayloadMapping[Key]) => callback(payload))
};

electron.contextBridge.exposeInMainWorld('electron', {
    createSolo: (sName: string, iconId: number) => electron.ipcRenderer.invoke('create-solo', sName, iconId),
    changeSName: (sId: number, sName: string) => electron.ipcRenderer.invoke('change-s-name', sId, sName),
    changeSIcon: (sId: number, iconId: number) => electron.ipcRenderer.invoke('change-s-icon', sId, iconId),
    getIcon:(iconId: number) => electron.ipcRenderer.invoke('get-icon', iconId),
    getIconPath: (iconId: number) => electron.ipcRenderer.invoke('get-icon-path', iconId),
    getSoloInfo: (sId: number, iconId: number) => electron.ipcRenderer.invoke('get-solo', sId, iconId),
    createTeam: (vName: string, iconId: number) => electron.ipcRenderer.invoke('create-team', vName, iconId),
    changeVName: (vId: number, vName: string) => electron.ipcRenderer.invoke('change-v-name', vId, vName),
    changeVIcon: (vId: number, iconId: number) => electron.ipcRenderer.invoke('change-v-icon', vId, iconId),
    getTeamInfo: (vId: number, iconId: number) => electron.ipcRenderer.invoke('get-team', vId, iconId),
    createQTable: () => ipcInvoke('createTable'),
    getQuestion: (qId:number) => electron.ipcRenderer.invoke('get-question', qId),
    startSteal: (vId: number, qId: number) => electron.ipcRenderer.invoke('start-steal', vId, qId),
    stealSuccess: (vId: number, qId: number, attempted: boolean) => electron.ipcRenderer.invoke('steal-success', vId, qId, attempted),
    getAnswer: (qId: number) => electron.ipcRenderer.invoke('get-answer', qId),
    getImagePath: (qId: number) => electron.ipcRenderer.invoke('get-image-path', qId),
    updateQTable: (qId: number, aId: number) => electron.ipcRenderer.invoke('update-table', qId, aId),
    getTimer: (qId: number) => electron.ipcRenderer.invoke('get-timer', qId),
    clearQTable: () => ipcInvoke('clear')
} 
// satisfies Window['electron']
);