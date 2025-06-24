const express = require('express');
const puppeteer = require('puppeteer');
const fs = require('fs');
const Wappalyzer = require('../src/drivers/npm'); // Adjust path if needed

const app = express();
const PORT = 3000;

app.get('/analyze', async (req, res) => {
  const url = req.query.url;
  if (!url) return res.status(400).json({ error: 'Missing URL' });

  const browser = await puppeteer.launch({ headless: 'new', args: ['--no-sandbox'] });
  const page = await browser.newPage();

  try {
    await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 30000 });

    const headers = await page.evaluate(() => {
      return JSON.parse(JSON.stringify(performance.getEntriesByType('navigation')[0].serverTiming || {}));
    });

    const html = await page.content();
    const jsVariables = await page.evaluate(() => Object.keys(window));

    const wappalyzer = new Wappalyzer();

    await wappalyzer.init();

    const site = await wappalyzer.open(url, {
      html,
      headers: page._client._connection._transport._ws ? {} : headers, // fallback if needed
      scripts: [], // optional: scrape with page.evaluate if needed
      js: jsVariables
    });

    const results = await site.analyze();

    await browser.close();

    res.json({
      url,
      technologies: results.technologies
    });
  } catch (err) {
    await browser.close();
    res.status(500).json({ error: err.message });
  }
});

app.listen(PORT, () => {
  console.log(`WebAppAnalyzer API running at http://localhost:${PORT}`);
});
