const fs = require('fs');

const file = fs.readFileSync('input.txt', 'utf8');
const lines = file.split("\n");

const layers = [];
for (line of lines) {
  const items = line.split(': ');
  const depth = parseInt(items[0], 10);
  const range = parseInt(items[1], 10);

  layers[depth] = {
    depth: depth,
    range: range,
    scanner: 0,
    movement: 1
  };
}

function positionAfter(depth, ps) {
  const layer = layers[depth];
  const rounds = Math.floor(ps / (layer.range - 1));
  const steps = ps % (layer.range - 1);

  return rounds % 2 == 0 ? steps : layer.range - steps - 1;
}

let delay = 1;
while (true) {
  for (i = 0; i < layers.length; i++) {
    if (layers[i] != null && positionAfter(i, i + delay) == 0) {
      break;
    }
  }
  if (i == layers.length) {
    break;
  }
  delay++;
}

console.log(delay);
