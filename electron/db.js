const Database = require('better-sqlite3');
const path = require('path');

const db = new Database(path.join(__dirname, '../database/jeopardy.db'));

// Sample function to get all questions
function getAllQuestions() {
  const stmt = db.prepare('SELECT * FROM questions');
  return stmt.all();
}

module.exports = { getAllQuestions };