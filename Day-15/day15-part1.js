let a = 116;
let b = 299;
let count = 0;

for (let i = 0; i < 4e7; i++) {
  a = a * 16807 % 0x7FFFFFFF;
  b = b * 48271 % 0x7FFFFFFF;
  count += !((a ^ b) & 0xFFFF);
}

console.log(count);
