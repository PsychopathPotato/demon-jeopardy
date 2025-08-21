type Solo = {
    sName: string;
    iconId: number;
}

type SName = {
    sId: number;
    sName: string;
}

type Category = {
    cId: number;
    cName: string;
};

type QuestionWithPoints = {
    qId: number;
    qText: string;
    cId: number;
    pId: number;
    pAmount: number;
};

type QTableResult = Record<string, QuestionWithPoints[]>;

type EventPayloadMapping = {
    createSolo: Promise<void>;
    changeSName: Promise<void>;
    createTable: QTableResult;
    clear: void;
};

interface Window {
    electron: {
        createSolo: (data: Solo) => void;
        changeSName: (date: SName) => void;
        createQTable: () => Promise<QTableResult>;
        clearTable: () => void;
    }
}
