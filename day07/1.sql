with hands as (select r, hand, bid from input)
select sum(result) from (
select row_number() over (order by s,a ) * bid as result, *
from (
    select *, string_to_array(hand, null) as a
    from (
        select *,
            (select hand from input i where i.r = x.r) as ohand,
            (select replace(replace(replace(replace(replace(hand, 'T', 'U'), 'J', 'W'), 'Q', 'X'), 'K', 'Y'), 'A', 'Z') from input i where i.r = x.r) as hand
        from (
            select distinct r, bid, s
            from (
                select r, bid, x, sum(c) over (partition by r) as s
                from (
                    select r, bid, x, count(*) over (partition by r, x) as c
                    from (
                        select r, bid, unnest(string_to_array(hand, null)) as x
                        from hands) a
                ) a
            ) a
        ) as x) x
    ) x order by s, a
) x;
