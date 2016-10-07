-- select all records created last month
SELECT * 
  FROM table 
 WHERE created_at::date >= date_trunc('MONTH', current_date - INTERVAL '1 MONTH' )::DATE
   AND created_at::date <= (date_trunc('MONTH', current_date - INTERVAL '1 MONTH' ) + INTERVAL '1 MONTH - 1 day')::DATE;

-- list all the tables with a name that matches a pattern e.g. table_*, ignoring case
SELECT *
  FROM information_schema.tables 
 WHERE table_name ILIKE '%table%'
 
-- group by week
  SELECT date_trunc('week', created_at::TIMESTAMP)::DATE AS "week", 
         count(id) AS id_count
    FROM my_table 
   WHERE created_at is NOT NULL
GROUP BY week
ORDER BY week

-- cumulative sum
with sub_query AS (    
  SELECT to_char(t.created_at::DATE,'YYYY/MM') as month, 
	       sum(a.value::FLOAT) AS value
    FROM my_table t 
   WHERE t.condition = true
GROUP BY to_char(t.created_at::DATE,'YYYY/MM')
ORDER BY to_char(t.created_at::DATE,'YYYY/MM'))
	SELECT month,
         value,
         sum(value) over (order by month) as cumulative_value
    FROM sub_query

-- how to get around not using "distinct on (A, B, C)" as redshift doesn't support it
with query_for_distinct AS (
	SELECT  id_number,
		client_name,
		company_name,
		revenue,
		years_active,
		is_public
	FROM table_name
	WHERE is_public = false)
SELECT *
FROM (SELECT *, 
	     rank() OVER (PARTITION BY id_number, client_name, company_name  
      ORDER BY id_number, client_name, company_name, revenue) AS three_ranked_values
      FROM query_for_distinct 
      ORDER BY client_name, company_name, id_number desc, years_active
    ) AS ranked
WHERE ranked.three_ranked = 1
