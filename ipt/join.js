const fs = require('fs');
const path = require('path');
const csvParser = require('csv-parser');
const fastcsv = require('fast-csv');

const photosPath = 'sample_photos_output.csv';
const samplesPath = 'Samples_output.csv';
const eventsPath = 'Events_output.csv';
const outputPath = 'occurrence_output.csv';

// Load CSV into memory
function loadCSV(filePath) {
  return new Promise((resolve, reject) => {
    const rows = [];
    fs.createReadStream(filePath)
      .pipe(csvParser())
      .on('data', row => rows.push(row))
      .on('end', () => resolve(rows))
      .on('error', reject);
  });
}

async function joinAndWriteCSV() {
  const samples = await loadCSV(samplesPath);
  const events = await loadCSV(eventsPath);
  const photos = await loadCSV(photosPath);

  // Create a lookup for events by eventID
  const eventsById = {};
  for (const event of events) {
    eventsById[event.eventID] = event;
  }

  // Join event fields to each sample
  const output = samples.map(sample => {
    const event = eventsById[sample.eventID] || {};
    return { ...sample, ...event };
  });

  // Write to CSV
  const ws = fs.createWriteStream(outputPath);
  fastcsv
    .write(output, { headers: true })
    .pipe(ws)
    .on('finish', () => {
      console.log(`✅ File written to ${outputPath}`);
    });
}

joinAndWriteCSV().catch(err => {
  console.error('❌ Error:', err);
});

