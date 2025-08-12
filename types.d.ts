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
    createTable: QTableResult;
    clear: void;
}

interface Window {
    electron: {
        createQTable: () => Promise<QTableResult>;
        clearTable: () => void;
    }
}
