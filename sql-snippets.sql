-- select all records created last month
SELECT * 
  FROM table 
 WHERE created_at::date >= date_trunc('MONTH', current_date - INTERVAL '1 MONTH' )::DATE
   AND created_at::date <= (date_trunc('MONTH', current_date - INTERVAL '1 MONTH' ) + INTERVAL '1 MONTH - 1 day')::DATE;

-- list all the tables with a name that matches a pattern e.g. table_*, ignoring case
SELECT *
  FROM information_schema.tables 
 WHERE table_name ILIKE '%table%'
