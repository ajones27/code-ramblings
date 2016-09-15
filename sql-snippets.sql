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
