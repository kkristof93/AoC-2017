const input = 'amgozmfv';

function knotHash(input) {
  let lengths = [];
  for (i = 0; i < input.length; i++) {
    lengths.push(input.charCodeAt(i));
  }
  lengths = lengths.concat([17, 31, 73, 47, 23]);

  const list = [...Array(256).keys()];
  let position = 0;
  let skipSize = 0;

  for (let i = 0; i < 64; i++) {
    for (length of lengths) {
      for (let j = 0; j < length / 2; j++) {
        const temp = list[(position + j) % 256];
        list[(position + j) % 256] = list[(position + length - j - 1) % 256];
        list[(position + length - j - 1) % 256] = temp;
      }
      position += length + skipSize;
      skipSize++;
    }
  }

  const dense = [];
  for (let i = 0; i < 16; i++) {
    let value = list[i * 16];
    for (let j = 1; j < 16; j++) {
      value ^= list[i * 16 + j];
    }
    dense.push(value);
  }

  return dense.map(x => {
    const bin = x.toString(2);
    return '00000000'.substring(0, 8 - bin.length) + bin;
  }).join('');
}

function dfs(grid, x, y, value) {
  grid[x][y] = value;
  if (x > 0 && grid[x - 1][y] == -1) {
    dfs(grid, x - 1, y, value);
  }
  if (y > 0 && grid[x][y - 1] == -1) {
    dfs(grid, x, y - 1, value);
  }
  if (x < 127 && grid[x + 1][y] == -1) {
    dfs(grid, x + 1, y, value); 
  }
  if (y < 127 && grid[x][y + 1] == -1) {
    dfs(grid, x, y + 1, value); 
  }
}

const grid = [];
for (let i = 0; i < 128; i++) {
  const hash = knotHash(`${input}-${i}`);
  grid[i] = [];

  for (let j = 0; j < 128; j++) {
    grid[i][j] = parseInt(hash.charAt(j), 10) * -1;
  }
}

let region = 1;
for (let i = 0; i < 128; i++) {
  for (let j = 0; j < 128; j++) {
    if (grid[i][j] == -1) {
      dfs(grid, i, j, region);
      region++;
    }
  }
}

console.log(region - 1);
