import React, { useState } from "react";
import './App.css';

const questions = [
  { category: "Science", question: "What is H2O?", answer: "Water", points: 100 },
  { category: "History", question: "Who was the first U.S. president?", answer: "George Washington", points: 100 }
];

function App() {
  const [score, setScore] = useState(0);
  const [used, setUsed] = useState([]);

  const handleClick = (q) => {
    const userAnswer = prompt(q.question);
    if (userAnswer?.toLowerCase() === q.answer.toLowerCase()) {
      setScore(score + q.points);
      alert("Correct!");
    } else {
      alert(`Wrong! Correct answer: ${q.answer}`);
    }
    setUsed([...used, q.question]);
  };

  return (
    <div style={{ textAlign: "center" }}>
      <h1>Jeopardy Game</h1>
      <h2>Score: {score}</h2>
      {questions.map((q, i) => (
        <button
          key={i}
          onClick={() => handleClick(q)}
          disabled={used.includes(q.question)}
          style={{ margin: "10px", padding: "20px" }}
        >
          {q.category} - {q.points} pts
        </button>
      ))}
    </div>
  );
}

export default App;