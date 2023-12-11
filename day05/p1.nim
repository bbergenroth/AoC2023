import std/strutils
import std/sequtils
var
  line_number: int = 0
  maps: seq[seq[string]]
  map_number: int = -1
  seeds: seq[string]
  to_add: bool

for line in lines "input.txt":
  var l = line.split(',')  
  if line_number == 0:
    seeds = l[0].split(":")[1].strip().split(' ')
    line_number = line_number + 1
    continue

  if l[0] != "":
    if contains(l[0], ":"):
      map_number = map_number + 1
      var row = newSeq[string]()
      maps.add(row)
    else:
      maps[map_number].add(l[0])
  line_number = line_number + 1

for m in maps:
  var plant: seq[string]
  for seed in seeds:
    to_add = true
    var s = parseInt(seed)
    
    for mm in m:
      var dest = parseInt(mm.split(' ')[0])
      var src = parseInt(mm.split(' ')[1])
      var len = parseInt(mm.split(' ')[2])
      if (src <= s) and (s < (src + len)):
        to_add = false
        plant.add($(s-src+dest))
        break

    if to_add:
      plant.add($s)

  seeds = plant

var pp = parseInt(minmax(seeds)[1])
var m = 0
for p in seeds:
  if parseInt(p) <= pp:
    m = parseInt(p)
    pp = m
echo pp
  
  

