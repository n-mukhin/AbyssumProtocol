const express = require('express');
const Sentiment = require('sentiment');
const sentiment = new Sentiment();

const app = express();

app.get('/analyze', (req, res) => {
  const text = req.query.text || '';
  const result = sentiment.analyze(text);
  
  let mood = 'neutral';
  if (result.score > 0) mood = 'positive';
  else if (result.score < 0) mood = 'negative';
  
  res.json({
    text: text,
    score: result.score,
    comparative: result.comparative,
    mood: mood
  });
});

app.listen(3000, () => {
  console.log('ToneCheck service is running on port 3000');
});
