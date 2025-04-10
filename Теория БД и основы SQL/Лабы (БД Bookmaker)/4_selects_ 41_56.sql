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

-- 42. Выбрать все данные по событию с самым высоким коэффициентом.

SELECT E.* 
FROM events_outcomes EO JOIN events E
	ON EO.event_id = E.id
WHERE EO.odd = (SELECT MAX(odd)
				FROM events_outcomes);
				
-- 43. Выбрать все данные по событиям с самым высоким и самым низким коэффициентами.

SELECT E.* 
FROM events_outcomes EO JOIN events E
	ON EO.event_id = E.id
WHERE EO.odd IN ((SELECT MAX(odd) FROM events_outcomes),
				 (SELECT MIN(odd) FROM events_outcomes));
				 
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
					   
-- 45. Выбрать вид события, на котором больше всего ставок сделано

WITH bets_count_by_event_type AS (
	SELECT S.id AS sport_id, 
	   	   S.name AS sport_name,
		   T.participants_type AS participants_type, 
		   COUNT(B.id) AS bets_count
	FROM bets B
		JOIN events E ON B.event_id = E.id
		JOIN tournaments_in_seasons TS ON E.tournament_id = TS.id
		JOIN tournaments T ON TS.tournament_id = T.id
		JOIN sports S ON T.sport_id = S.id
	GROUP BY S.id, sport_name, participants_type
)
SELECT sport_name, participants_type, bets_count
FROM bets_count_by_event_type
WHERE bets_count = (SELECT MAX(bets_count) FROM bets_count_by_event_type);
-- или WHERE bets_count >= ALL(SELECT bets_count FROM event_types_counts)?;

/* 46. Выбрать название чемпионата, название команды и количество
пользователей, сделавших ставки на выигрыш этой команды. 
В результат включить команды участвовавшие во всех чемпионатах. */
-- взять один вид спорта (например, теннис)
-- так как теннис, то вместо команд спортсмены

WITH athletes_in_all_tournaments AS (
	SELECT P.id AS athlete_id,
		   P.name AS athlete_name
	FROM participations_in_tournaments PIT 
		JOIN participants P ON PIT.participant_id = P.id
		JOIN sports S ON P.sport_id = S.id
	WHERE S.name = 'теннис'
	GROUP BY P.id, athlete_name
	HAVING COUNT(PIT.tournament_in_season_id) = (SELECT COUNT(TS.id)
									   			 FROM tournaments_in_seasons TS 
									   			 JOIN tournaments T ON TS.tournament_id = T.id
									   			 JOIN sports S ON T.sport_id = S.id
									   			 WHERE S.name = 'теннис'
									   			)
)
SELECT (T.name || ' ' || CASE
						 	WHEN EXTRACT(YEAR FROM TS.start_date) 
								 = EXTRACT(YEAR FROM TS.end_date) 
							THEN EXTRACT(YEAR FROM TS.start_date)::text
							ELSE EXTRACT(YEAR FROM TS.start_date)::text || '/' || EXTRACT(YEAR FROM TS.end_date)::text
						  END) AS tournament,
	   AAT.athlete_name,
	   COUNT(DISTINCT B.user_id) AS users_count
FROM tournaments_in_seasons TS
	JOIN tournaments T ON TS.tournament_id = T.id
	JOIN events E ON TS.id = E.tournament_id
	JOIN athletes_in_all_tournaments AAT
		ON (E.first_participant_id = AAT.athlete_id OR E.second_participant_id = AAT.athlete_id)
	JOIN bets B ON E.id = B.event_id
	JOIN outcomes O ON B.outcome_id = O.id
WHERE (O.name = 'П1' AND E.first_participant_id = AAT.athlete_id
		OR O.name = 'П2' AND E.second_participant_id = AAT.athlete_id)
GROUP BY TS.id, tournament, AAT.athlete_id, AAT.athlete_name;

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

-- 48. Выбрать пользователей, сделавших ставки на все события какого-либо одного чемпионата.
-- Нужно ли задавать алиас для таблицы из подзапроса
SELECT U.login,
	   (TN.name || ' ' || CASE
						 	WHEN EXTRACT(YEAR FROM TS.start_date) 
								 = EXTRACT(YEAR FROM TS.end_date) 
							THEN EXTRACT(YEAR FROM TS.start_date)::text
							ELSE EXTRACT(YEAR FROM TS.start_date)::text || '/' || EXTRACT(YEAR FROM TS.end_date)::text
						  END) AS tournament
FROM users U
	JOIN bets B ON U.id = B.user_id
	JOIN events E ON B.event_id = E.id
	JOIN tournaments_in_seasons TS ON E.tournament_id = TS.id
	JOIN tournaments TN ON TS.tournament_id = TN.id
GROUP BY U.login, TS.id, tournament
HAVING COUNT(DISTINCT E.id) = (SELECT COUNT(DISTINCT id)
							   FROM events 
							   WHERE tournament_id = TS.id);

-- 49. Выбрать логин пользователя, сделавшего ставку на максимальную сумму.

SELECT U.login, B.amount
FROM users U JOIN bets B ON U.id = B.user_id
WHERE B.amount = (SELECT MAX(amount)
				  FROM bets);

-- 50. Выбрать логины пользователей, которые делали ставки на события только двух чемпионатов.

SELECT U.login, COUNT(DISTINCT T.id)
FROM users U
	JOIN bets B ON U.id = B.user_id
	JOIN events E ON B.event_id = E.id
	JOIN tournaments_in_seasons T ON E.tournament_id = T.id
GROUP BY U.login
HAVING COUNT(DISTINCT T.id) = 2;

-- 51. Выбрать id и название чемпионата, на события которого не сделали ни одной ставки.

SELECT TS.id AS id,
	   (TN.name || ' ' || CASE
						 	WHEN EXTRACT(YEAR FROM TS.start_date) 
								 = EXTRACT(YEAR FROM TS.end_date) 
							THEN EXTRACT(YEAR FROM TS.start_date)::text
							ELSE EXTRACT(YEAR FROM TS.start_date)::text || '/' || EXTRACT(YEAR FROM TS.end_date)::text
						  END) AS name
FROM tournaments TN JOIN tournaments_in_seasons TS 
	ON TN.id = TS.tournament_id
WHERE NOT EXISTS (SELECT 1
			  	  FROM bets B JOIN events E
			  	  	ON B.event_id = E.id
			  	  WHERE E.tournament_id = TS.id);
	
-- 52. Выбрать пары пользователей, сделавших ставки на одинаковую общую сумму.

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

------------------------ переделать с CTE
SELECT U1.login AS user1,
	   U2.login AS user2
FROM users U1 
	JOIN users U2 ON U1.id != U2.id
	JOIN bets B1 ON U1.id = B1.user_id
	JOIN bets B2 ON U2.id = B2.user_id
WHERE U1.id < U2.id
GROUP BY user1, user2
HAVING SUM(B1.amount) = SUM(B2.amount);

-- 53. Выбрать равны ли суммы проигрыша и выигрыша.

SELECT (SUM(CASE WHEN EO.occured = TRUE THEN B.amount * (B.odd - 1.0) END) 
	   = SUM(CASE WHEN EO.occured = FALSE THEN B.amount END)
	   ) AS winning_and_losing_amounts_are_equal
FROM bets B JOIN events_outcomes EO
	ON (B.event_id = EO.event_id AND B.outcome_id = EO.outcome_id);

-- 54. Выбрать название команды, чье имя появляется в БД чаще других.
-- команды, фигурирующей в наибольшем количестве ставок

WITH bets_count_by_team AS (
	SELECT P.name AS team,
		   COUNT(B.id) AS bets_count
	FROM bets B 
		JOIN events E ON B.event_id = E.id
		JOIN participants P ON (E.first_participant_id = P.id OR E.second_participant_id = P.id)
	WHERE P.participant_type IN ('club', 'national team')
	GROUP BY P.id, P.name
) 
SELECT team
FROM bets_count_by_team
WHERE bets_count = (SELECT MAX(bets_count) 
					FROM bets_count_by_team);


/* 55.Вывести названия всех команд, встречающихся в БД.
Результат отсортировать в лексикографическом порядке. */

-- Вместо этого:
/* 55. Выбрать все года, которые имеются в БД. 
Результат отсортировать в лексикографическом порядке. */

SELECT EXTRACT(YEAR FROM bet_timestamp) AS year
FROM bets
UNION
SELECT EXTRACT(YEAR FROM start_time)
FROM events
UNION 
SELECT EXTRACT(YEAR FROM end_time)
FROM events
UNION
SELECT EXTRACT(YEAR FROM odd_start_time) 
FROM odds_history
UNION 
SELECT EXTRACT(YEAR FROM odd_end_time) 
FROM odds_history
UNION 
SELECT EXTRACT(YEAR FROM start_date)
FROM tournaments_in_seasons
UNION 
SELECT EXTRACT(YEAR FROM end_date)
FROM tournaments_in_seasons
ORDER BY year;

/* 56. Вывести сообщение "Есть событие, на которое не сделаны ставки", если есть 
событие без ставок, и наоборот, вывести сообщение "На все события сделаны ставки", 
если таких событий нет. */

SELECT CASE 
	   WHEN EXISTS (SELECT 1
				    FROM events E
				    WHERE NOT EXISTS (SELECT 1
									  FROM bets B
									  WHERE B.event_id = E.id))
	   THEN 'Есть событие, на которое не сделаны ставки'
	   ELSE 'На все события сделаны ставки'
	   END AS message;










