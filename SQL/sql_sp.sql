-- Filtering in chartio when the filter can be empty
-- {COUNTRY.IN('user_register_country')}

-- See what queries are running
SELECT *
FROM stv_recents
WHERE status = ‘Running’;

-- kill query given a pid from the above query
kill 0945
            
-- mode
select price as mode
from purchases
group by 1
order by count(1) desc
limit 1;

-- median
select median(price) over () as median
from purchases
limit 1;

-- Split a string e.g. to select all with minor version > 21 from major.minor.patch type strings like 0.21.0
split_part(split_part(s.version,'-',1),'.',2) >= 21

-- % of total
SELECT
revenues_dollars_net,
  ratio_to_report(revenues_dollars_net)
  OVER () AS "% OF total revenues"
FROM t_user
WHERE revenues_dollars_net IS NOT NULL
ORDER BY revenues_dollars_net DESC
LIMIT 1000;


-- % revenue coming from each category of payer
SELECT DISTINCT
current_payer_category,
  ratio_to_report(sum(revenues_dollars_net))
  OVER ()
FROM t_user
WHERE revenues_dollars_net IS NOT NULL
group by 1;


-- % price point contribution to total
SELECT
amount_gross,
  cume_dist()
  OVER(
    ORDER BY amount_gross ASC)
FROM t_transaction
GROUP BY 1
ORDER BY amount_gross ASC;

-- median and other averages in same query
SELECT 
	  DISTINCT data_point,
    MIN(value) OVER (PARTITION BY data_point) AS min_value,
    MAX(value) OVER (PARTITION BY data_point) AS max_value,
    AVG(value) OVER (PARTITION BY data_point) AS avg_value,
    PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY value)
        OVER (PARTITION BY data_point) AS median_value
    FROM table_name;
