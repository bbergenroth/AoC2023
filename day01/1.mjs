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
  let startingNumber = line.match(/\d/g)[0];
  let endingNumberArray = line.match(/\d/g);
  let endingNumber = endingNumberArray[endingNumberArray.length - 1];

  let line_total = "" + startingNumber + endingNumber;

  total = total + Number(line_total);
});

console.log(total);
