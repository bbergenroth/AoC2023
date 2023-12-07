```
create table input
(
    r    int generated always as identity,
    hand text,
    bid  integer
);

\copy input (hand, bid) from input.txt with delimiter ' '
```
