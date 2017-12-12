const fs = require('fs');

const file = fs.readFileSync('input.txt', 'utf8');
const lines = file.split("\n");

const programs = [];
for (line of lines) {
  const items = line.split(' <-> ');
  const id = parseInt(items[0], 10);

  programs[id] = {
    id: id,
    pipes: items[1].split(', ').map(x => parseInt(x, 10)),
    visited: false
  };
}

const queue = [0];
while (queue.length) {
  const id = queue.shift();
  const program = programs[id];

  program.pipes.forEach(p => {
    if (!programs[p].visited) {
      queue.push(p);
    }
  });
  
  program.visited = true;
}

const count = programs.filter(p => p.visited).length;
console.log(count);
