WITH vol AS (
SELECT SUM(money) AS volume, user_id, type, currency_id
FROM balance
GROUP BY user_id, type, currency_id
),

last_cur AS (
WITH ranked_currency AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated DESC) AS rnk
  FROM currency
)
SELECT cr.id, cr.name, cr.rate_to_usd
FROM ranked_currency cr
JOIN (
  SELECT id, rnk AS max_rnk
  FROM ranked_currency
  WHERE rnk = 1
) max_dates ON cr.id = max_dates.id AND cr.rnk = max_dates.max_rnk
)

SELECT 
	COALESCE(us.name, 'not defined') AS name,
	COALESCE(us.lastname, 'not defined') AS lastname,
	vol.type, vol.volume,
	COALESCE(last_cur.name, 'not defined') AS currency_name,
	COALESCE(last_cur.rate_to_usd, 1) AS last_rate_to_usd,
	vol.volume * COALESCE(last_cur.rate_to_usd, 1) AS total_volume_in_usd
	FROM vol
	LEFT JOIN "user" as us ON vol.user_id = us.id 
	LEFT JOIN last_cur ON last_cur.id = vol.currency_id
	ORDER BY 1 DESC, 2, 3;
