insert into currency values (100, 'EUR', 0.85, '2022-01-01 13:29'); 
insert into currency values (100, 'EUR', 0.79, '2022-01-08 13:29');

WITH last_curr AS (SELECT balance.user_id, balance.updated, currency.id, currency.rate_to_usd AS past_rate, 
balance.updated - currency.updated as delta 
FROM balance LEFT JOIN currency ON balance.currency_id = currency.id
WHERE currency.updated <= balance.updated),

min_curr AS (SELECT  *, MIN(delta) OVER (PARTITION BY user_id, updated, id) FROM last_curr),

past_near_curr AS (SELECT user_id, updated, id, past_rate FROM min_curr WHERE delta = min),

next_curr AS (SELECT balance.user_id, balance.updated, currency.id, currency.rate_to_usd AS fut_rate, 
currency.updated - balance.updated as delta 
FROM balance LEFT JOIN currency ON balance.currency_id = currency.id
WHERE currency.updated >= balance.updated),

min_next_curr AS (SELECT  *, MIN(delta) OVER (PARTITION BY user_id, updated, id) FROM next_curr),

future_near_curr AS (SELECT user_id, updated, id, fut_rate FROM min_next_curr WHERE delta = min),

summary AS (SELECT balance.*, pc.past_rate, fc.fut_rate FROM balance
LEFT JOIN past_near_curr as pc ON balance.user_id = pc.user_id AND balance.currency_id = pc.id AND balance.updated = pc.updated
LEFT JOIN future_near_curr as fc ON balance.user_id = fc.user_id AND balance.currency_id = fc.id AND balance.updated = fc.updated
WHERE pc.id IS NOT NULL OR fc.id IS NOT NULL)

SELECT COALESCE(us.name, 'not defined') as name,
COALESCE(us.lastname, 'not defined') as lastname,
curr.name as currency_name, 
COALESCE(past_rate, fut_rate) *  summary.money AS currency_in_usd
FROM summary
LEFT JOIN "user" us ON summary.user_id = us.id
LEFT JOIN (SELECT distinct id, name FROM currency) curr ON curr.id = summary.currency_id
ORDER BY 1 DESC, 2, 3;
