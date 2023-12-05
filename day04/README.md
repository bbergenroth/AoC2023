part 1:
```
awk '{split($0, a, "|"); split(a[1], b, ":"); split(a[2], c, " "); split(b[2], d, " "); cnt = 0; \
    for (i in c) for (j in d) { if (c[i] == d[j]) {cnt = cnt + 1;}}; total = 0; \
    if (cnt == 0) total = 0; else total = total + (2^(cnt - 1)); answer = answer + total; \
    print answer}' input.txt | tail -n 1
```
