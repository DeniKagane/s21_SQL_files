CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop int DEFAULT 10)
RETURNS TABLE (fibonacci integer)
AS
$$
WITH RECURSIVE fib AS (
  SELECT 0 as iter, 0 as a, 1 as b, 1 as c
  
  UNION ALL
  
  SELECT fib.iter+1, fib.b as a, fib.c as b, fib.b+fib.c as c
  FROM fib WHERE a < pstop
)
SELECT a as fibonacci FROM fib WHERE a < pstop;
$$
LANGUAGE sql;

select * from fnc_fibonacci(100);
select * from fnc_fibonacci();

