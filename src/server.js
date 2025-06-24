const express = require('express');
const app = express();
const port = 3000;

// Simple route to check service status
app.get('/', (req, res) => {
  res.send('WebAppAnalyzer is running.');
});

// Placeholder analyze route
app.get('/analyze', async (req, res) => {
  const url = req.query.url;

  if (!url) {
    return res.status(400).json({ error: 'Missing ?url= query parameter' });
  }

  try {
    // TODO: Replace this block with actual detection logic from the repo
    // e.g. run puppeteer + tech detector here
    const mockResult = {
      url,
      technologies: [
        { name: "Express", version: "4.x", category: "Web Framework" },
        { name: "Node.js", version: "18.x", category: "Platform" }
      ]
    };

    res.json(mockResult);
  } catch (err) {
    res.status(500).json({ error: 'Analysis failed', details: err.message });
  }
});

app.listen(port, () => {
  console.log(`WebAppAnalyzer API running at http://localhost:${port}`);
});
