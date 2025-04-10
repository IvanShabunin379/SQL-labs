/* 13. Выбрать название чемпионата первого в списке, упорядоченного 
по названию в лексикографическом порядке. */

-- вариант с ORDER BY и LIMIT
SELECT name
FROM tournaments
ORDER BY name
LIMIT 1;

-- вариант с MIN
SELECT MIN(name) 
FROM tournaments;




-- Подправить 24




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

-- 41. Выбрать все данные о пользователях ни разу не делавших ставки.

SELECT U.*
FROM users U
WHERE NOT EXISTS (SELECT 1
				  FROM bets B
				  WHERE B.user_id = U.id);
				  
SELECT U.*
FROM users U LEFT JOIN bets B
	ON U.id = B.user_id
WHERE B.id IS NULL;


-- 44. Выбрать все данные пользователей, чья фамилия совпадает с названием команды.

SELECT U.*
FROM users U JOIN participants P
	ON U.last_name = P.name 
		AND P.participant_type IN ('club', 'national team');

SELECT U.*
FROM users U
WHERE U.last_name = ANY(SELECT P.name
						 FROM participants P
						 WHERE P.participant_type IN ('club', 'national team')
					   );


-- 47. Выбрать пользователей, сделавших ставки на всех чемпионатах.

-- оптимально (без CTE)
SELECT U.login
FROM users U
	JOIN bets B ON U.id = B.user_id
	JOIN events E ON B.event_id = E.id
	JOIN tournaments_in_seasons T ON E.tournament_id = T.id
GROUP BY U.login
HAVING COUNT(DISTINCT T.id) = (SELECT COUNT(id) 
						   	   FROM tournaments_in_seasons);

-- неоптимально (с CTE)
WITH tournaments_count_by_user AS (
	SELECT U.login AS login, 
		   COUNT(DISTINCT T.id) AS tournaments_count
	FROM users U
		JOIN bets B ON U.id = B.user_id
		JOIN events E ON B.event_id = E.id
		JOIN tournaments_in_seasons T ON E.tournament_id = T.id
	GROUP BY U.login
)
SELECT login
FROM tournaments_count_by_user
WHERE tournaments_count = (SELECT COUNT(T.id) 
						   FROM tournaments_in_seasons T);


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