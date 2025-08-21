import path from 'path';
import { app } from 'electron';
import { isDev } from './util.js'
import { getIcon, getAnswer } from './db.js';

export function getPreloadPath() {
    return path.join(
        app.getAppPath(),
        isDev() ? '.' : '..',
        '/dist-electron/preload.cjs'
    );
};

export function getDatabasePath() {
    return isDev()
    ? path.join(app.getAppPath(), 'src', 'models', 'expanse.db')
    : path.join(process.resourcesPath, 'expanse.db');
};

export function getImagePath(qId: number) {
    const img = getAnswer(qId) as { aText: string } | undefined;
    const fileName = img?.aText.replace(/ /g, '_');
    return path.join(isDev()
        ? path.join(app.getAppPath(), 'src', 'ui', 'assets', 'images')
        : path.join(process.resourcesPath, 'images')
    , `${fileName}.png`);
};

export function getIconPath(iconId: number){
    const icon = getIcon(iconId) as { iconName: string } | undefined;
    const fileName = icon?.iconName.replace(/ /g, '_');
    return path.join(isDev()
        ? path.join(app.getAppPath(), 'src', 'ui', 'assets', 'icons')
        : path.join(process.resourcesPath, 'icons')
    , `${fileName}.png`);
};