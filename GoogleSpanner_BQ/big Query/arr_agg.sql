BEGIN
  CREATE TEMPORARY TABLE temp_table AS
  SELECT 'John Smith' AS student, 5000 AS fees_paid, 'A' AS grade, 90 AS points UNION ALL
  SELECT 'Emily Johnson', 5500, 'B+', 85 UNION ALL
  SELECT 'Michael Williams', 6000, 'A-', 92 UNION ALL
  SELECT 'Sophia Brown', 4800, 'B', 88 UNION ALL
  SELECT 'Jacob Jones', 5200, 'A+', 95 UNION ALL
  SELECT 'Olivia Davis', 5300, 'B-', 82 UNION ALL
  SELECT 'William Miller', 5100, 'A', 91 UNION ALL
  SELECT 'Ava Wilson', 4900, 'B', 86 UNION ALL
  SELECT 'Ethan Taylor', 4700, 'B+', 87 UNION ALL
  SELECT 'Isabella Anderson', 5800, 'A-', 93 UNION ALL
  SELECT 'Liam Thomas', 5600, 'A-', 91 UNION ALL
  SELECT 'Emma Martinez', 5100, 'B+', 84 UNION ALL
  SELECT 'Noah Anderson', 5200, 'B-', 87 UNION ALL
  SELECT 'Sophia Johnson', 5300, 'A', 92 UNION ALL
  SELECT 'Mason Davis', 4900, 'A+', 95 UNION ALL
  SELECT 'Charlotte Wilson', 4800, 'B', 88 UNION ALL
  SELECT 'Elijah Thompson', 5400, 'A-', 90 UNION ALL
  SELECT 'Amelia Taylor', 5000, 'B+', 85 UNION ALL
  SELECT 'Benjamin Clark', 4700, 'B-', 82 UNION ALL
  SELECT 'Ben Blake', null, 'B-', null UNION ALL
  SELECT 'Ben Bern', 5700, null, null UNION ALL
  SELECT 'Ben Clark', null, null, null UNION ALL
  SELECT 'Ben Clark', 700, null, null UNION ALL
  SELECT 'Avery Rodriguez', 5200, 'A+', 93;
END;

SELECT
  grade,
  FORMAT('%T', ARRAY_AGG(fees_paid) OVER (PARTITION BY grade)) AS array_agg 
from temp_table;-- return total number of rows

select 
  FORMAT('%T', ARRAY_AGG(DISTINCT fees_paid IGNORE NULLS ORDER BY fees_paid)) AS array_agg
from temp_table;-- return total number of rows




