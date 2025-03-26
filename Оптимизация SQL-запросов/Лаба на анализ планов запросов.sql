-- 27. Выбрать количество пользователей однофамильцев-тезок среди пользователей

EXPLAIN ANALYZE
SELECT COUNT(DISTINCT U1.id)
FROM users U1 JOIN users U2 
	ON U1.first_name = U2.first_name AND U1.last_name = U2.last_name
WHERE U1.id <> U2.id;

EXPLAIN ANALYZE
SELECT SUM(NC.namesakes_count)
FROM (SELECT first_name, last_name, COUNT(id) AS namesakes_count
	  FROM users
	  GROUP BY first_name, last_name
	  HAVING (COUNT(id) > 1)
	 ) AS NC;



-- 52. Выбрать пары пользователей, сделавших ставки на одинаковую общую сумму.

EXPLAIN ANALYZE
WITH total_bets_amount_by_user AS (
	SELECT U.id AS id,
		   U.login AS login,
		   SUM(B.amount) AS total_bets_amount
	FROM users U JOIN bets B
		ON U.id = B.user_id
	GROUP BY U.id, login
)
SELECT AM1.login,
	   AM2.login
FROM total_bets_amount_by_user AM1 JOIN total_bets_amount_by_user AM2
	ON AM1.id != AM2.id AND AM1.total_bets_amount = AM2.total_bets_amount
WHERE AM1.id < AM2.id;


EXPLAIN ANALYZE
SELECT U1.login AS login1,
       U2.login AS login2
FROM (
    SELECT U.id,
           U.login,
           SUM(B.amount) AS total_bets_amount
    FROM users U 
    JOIN bets B ON U.id = B.user_id
    GROUP BY U.id, U.login
) AS U1
JOIN (
    SELECT U.id,
           U.login,
           SUM(B.amount) AS total_bets_amount
    FROM users U 
    JOIN bets B ON U.id = B.user_id
    GROUP BY U.id, U.login
) AS U2
ON U1.total_bets_amount = U2.total_bets_amount
WHERE U1.id < U2.id;









