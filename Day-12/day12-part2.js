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

function bfs(startId) {
  const queue = [startId];

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
}

let count = 0;
while (!programs.every(p => p.visited)) {
  const start = programs.find(p => !p.visited);
  bfs(start.id);
  count++;
}

console.log(count);
