import { ipcMain } from "electron";

export function isDev(): boolean {
    return process.env.NODE_ENV === 'development';
}

export function ipcMainHandle<Key extends keyof EventPayloadMapping, Args extends unknown[]= []>(
    key: string, 
    handler: (event: Electron.IpcMainInvokeEvent, ...args: Args) => Promise<EventPayloadMapping[Key]> | EventPayloadMapping[Key]
) {
    ipcMain.handle(key, (event, ...args)=> handler(event, ...(args as Args)));
};