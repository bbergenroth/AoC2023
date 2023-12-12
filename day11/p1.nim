import std/sequtils

var
  emptyx: set[int16]
  emptyy: set[int16]
  galaxies: seq[seq[int16]]
  x: int16 = 0
  y: int16 = 0

var width:int16 = int16: len(readLines("input.txt", 1)[0])
emptyx = {1 .. width - 1}

for line in lines "input.txt":
  x = 0
  var l = toSeq(line.items)
  if (all(l, proc (x: char):bool= (x == '.')) == true):
    emptyy.incl(y)
  for c in l:
    if c != '.':
      emptyx.excl(x)
      var g = newSeq[int16]()
      galaxies.add(g)
      galaxies[len(galaxies) - 1].add(@[x, y])
    x = x + 1
  y = y + 1

var total:int = 0
for index, item in galaxies:
  for ng in galaxies[index + 1 .. len(galaxies) - 1]:
    var sx = {min(galaxies[index][0], ng[0]) .. max(galaxies[index][0], ng[0])}
    var sy = {min(galaxies[index][1], ng[1]) .. max(galaxies[index][1], ng[1])}
    total = total + len(sx * emptyx) + len(sy * emptyy) + abs(galaxies[index][0] - ng[0]) + abs(galaxies[index][1] - ng[1])

echo total
