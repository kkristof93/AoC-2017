let a = 116;
let b = 299;
let count = 0;

for (let i = 0; i < 5e6; i++) {
  do {
    a = a * 16807 % 0x7FFFFFFF;
  } while (a % 4 != 0);

  do {
    b = b * 48271 % 0x7FFFFFFF;
  } while (b % 8 != 0);
  
  count += !((a ^ b) & 0xFFFF);
}

console.log(count);
