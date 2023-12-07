with hands as (select r, hand, bid from input),
    jokers as (
        select r, x,hand, bid, c, max(c) over (partition by r,hand ) as m
        from (
            select r, hand,bid, x, count(case when x='J'then null else x end) over (partition by r, x) as c
            from (
                select r, hand,bid, unnest(string_to_array(hand, null)) as x
                from hands))),
    new_hand as (
        select *,
            case when x = 'J' then (select x from jokers a where a.r = j.r and a.c = j.m limit 1) else x end as n,
            case when x = 'J' then replace(hand, 'J', '1') else replace(replace(replace(replace(hand, 'T', 'W'), 'Q', 'X'), 'K', 'Y'), 'A', 'Z') end as worth
        from jokers j)
select sum(result) from (
    select *,row_number() over (order by s,replace(replace(replace(replace(min_worth, 'T', 'W'), 'Q', 'X'), 'K', 'Y'), 'A', 'Z')   ) *bid as result
    from (
        select distinct r, hand, bid, s, min_worth
        from (
            select *, sum(cnt) over (partition by r) as s
            from (
                select *, count(*) over (partition by r, n) as cnt, min(worth) over (partition by r) as min_worth
                from (
                    select * from new_hand)))));
