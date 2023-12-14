def f(p, n, i = 0):
    r = 0
    if p == "":
        if n == []:
            return r + 1 
        else:
            return 0

    if p[0] in ("#", "?"):
        r += f(p[1:], n, i + 1)

    if p[0] in (".", "?", "X") and (len(n) > 0 and n[0] == i or i == 0):
        r += f(p[1:], n[1:] if i else n)

    return r

total = 0

for s in open('input.txt'):
    if len(s) == 1:
        break
    
    p, c = s.split(' ')
    n = [int(n.strip()) for n in c.split(',')]
    total = total + f(p+'X', n, 0)

print(total)
