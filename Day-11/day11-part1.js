const fs = require('fs');

const file = fs.readFileSync('input.txt', 'utf8');
const directions = file.split(',');
const steps = {
  x: 0,
  y: 0,
  z: 0
};

function distance(point) {
  return (Math.abs(point.x) + Math.abs(point.y) + Math.abs(point.z)) / 2;
}

directions.forEach(d => {
  switch(d) {
    case 'n':
      steps.y++;
      steps.z--;
      break;
    case 'ne':
      steps.x++;
      steps.z--;
      break;
    case 'se':
      steps.x++;
      steps.y--;
      break;
    case 's':
      steps.y--;
      steps.z++;
      break;
    case 'sw':
      steps.x--;
      steps.z++;
      break;
    case 'nw':
      steps.y++;
      steps.x--;
      break;
  }
});

console.log(distance(steps));
