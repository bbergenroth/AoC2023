import { open } from "node:fs/promises";

const readFile = async (fileName) => {
  let file = await open(fileName);
  let lines = [];

  for await (const line of file.readLines()) {
    lines.push(line);
  }

  return lines;
};

let lines = await readFile(process.argv[2]);

let total = 0;

lines.forEach((line) => {
  let re = /1|2|3|4|5|6|7|8|9|one|two|three|four|five|six|seven|eight|nine/g;
  let m,
    res = [];

  while ((m = re.exec(line))) {
    res.push(m[0]);
    re.lastIndex = m.index + 1;
  }

  let result = res.map(function (x) {
    return x
      .replace("one", "1")
      .replace("two", "2")
      .replace("three", "3")
      .replace("four", "4")
      .replace("five", "5")
      .replace("six", "6")
      .replace("seven", "7")
      .replace("eight", "8")
      .replace("nine", "9");
  });

  let startingNumber = result[0];
  let endingNumber = result[result.length - 1];
  let line_total = "" + startingNumber + endingNumber;
  total = total + Number(line_total);
});

console.log(total);
