import queue

pipes = open('input.txt').read().splitlines()
path = set()
q = queue.Queue()

for i, x in enumerate(pipes):
    for j, y in enumerate(x):
        if y == "S":
            q.put((i, j))
            path.add((i, j))

while not q.empty():
    x, y = q.get()
    d = pipes[x][y]

    # north
    if (x, y - 1) not in path and d in "S-J7" and pipes[x][y - 1] in "-LF":
        path.add((x, y - 1))
        q.put((x, y - 1))

    # east
    if (x + 1, y) not in path and d in "S|7F" and pipes[x + 1][y] in "|JL":
        path.add((x + 1, y))
        q.put((x + 1, y))

    # south
    if (x, y + 1) not in path and d in "S-LF" and pipes[x][y + 1] in "-J7":
        path.add((x, y + 1))
        q.put((x, y + 1))

    # west
    if (x - 1, y) not in path and d in "S|LJ" and pipes[x - 1][y] in "|7F":
        path.add((x - 1, y))
        q.put((x - 1, y))

print(int(len(path)/2))

