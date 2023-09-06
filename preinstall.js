const fs = require('fs');
const execSync = require('child_process').execSync;

const packageJson = JSON.parse(fs.readFileSync('./package.json', 'utf8'));

// Join package names with their respective version ranges
const dependencies = Object.entries(packageJson.dependencies)
  .map(([name, version]) => `${name}@${version}`)
  .join(' ');

// Use execSync to install the dependencies at the top level
execSync(`npm install --no-save ${dependencies}`, { stdio: 'inherit' });
