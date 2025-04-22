/* 1. Выбрать все данные обо всех пользователях. 
Результат отсортировать по фамилии в лексикографическом порядке. */

SELECT *
FROM users
ORDER BY last_name;

/* 2. Выбрать все имена пользователей без повторений. 
Результат отсортировать в порядке обратном лексикографическому. */

SELECT DISTINCT first_name
FROM users
ORDER BY first_name DESC;

/* 3. Выбрать фамилию пользователя в одном столбце, имя отчество
пользователя во втором, логин. 
Результат отсортировать по фамилии в лексикографическом порядке, 
по имени и отчеству в порядке обратном
лексикографическому. */

SELECT last_name,
	   (first_name || ' ' || COALESCE(patronymic, '')) AS first_name_and_patronymic,
	   login
FROM users
ORDER BY last_name,
		 first_name_and_patronymic DESC;

-- 4. Выбрать названия чемпионатов c id 2, 4, 5, 8, 11.

SELECT name
FROM tournaments
WHERE id IN (2, 4, 5, 8, 11);

/* 5. Выбрать фамилию и инициалы пользователей с двойной фамилией 
или фамилией из четырех букв. 
Результат отсортировать по длине фамилии. */

SELECT CONCAT(last_name, ' ', 
			   LEFT(first_name, 1), '. ',
			   COALESCE(LEFT(patronymic, 1) || '.', '')
			  ) AS name
FROM users
WHERE TRIM(last_name) LIKE '%-%'
	OR TRIM(last_name) LIKE '____'
ORDER BY LENGTH(last_name);

-- 6. Выбрать все данные о пользователях, у которых отчество неизвестно.

SELECT *
FROM users
WHERE (patronymic IS NULL) OR (patronymic = '');

/* 7. Выбрать id пользователей, у которых пароль состоит из менее, чем 8 символов 
и в пароле нет символов ?, / , -, _. */

SELECT id
FROM users
WHERE password NOT LIKE '________%'
	AND password NOT LIKE '%?%'
	AND password NOT LIKE '%/%'
	AND password NOT LIKE '%-%'
	AND password NOT LIKE '%#_%' ESCAPE '#';
	

-- 8. Выбрать все данные о ставках, сумма которых в диапазоне от 600 до 1000.

SELECT *
FROM bets
WHERE amount BETWEEN 600 AND 1000;

/* 9. Выбрать все данные о чемпионатах с id не равным 2, 4, 5, 8, 11. 
Результат отсортировать следующим образом: сначала чемпионаты с названием,
начинающимся на П, затем на К, после на Ч и В, и все остальные. */

SELECT *
FROM tournaments
WHERE id NOT IN (2, 4, 5, 8, 11)
ORDER BY CASE
		 WHEN TRIM(name) ILIKE 'П%'
		 THEN 1
		 WHEN TRIM(name) ILIKE 'К%'
		 THEN 2
		 WHEN TRIM(name) ILIKE 'Ч%' 
		 	OR TRIM(name) ILIKE 'В%'
		 THEN 3
		 ELSE 4
		 END;

/* 10. Выбрать id, логин, а в третьем столбце указать сообщение 'пароль следует изменить', 
если длина пароля менее 8 символов и состоит только из букв или только из цифр. 
Результат отсортировать следующим образом: в первую очередь данные о пользователях с плохим паролем, 
а затем с хорошим паролем и по фамилии в порядке обратном лексикографическому,
по имени и отчеству в лексикографическом порядке. */

SELECT id, 
	   login, 
	   CASE
	   WHEN password NOT LIKE '________%'
	   	AND (password SIMILAR TO '[a-zA-Zа-яА-яЁё]*'
			 OR password SIMILAR TO '[0-9]*')
	   THEN 'пароль следует изменить'
	   ELSE ''
	   END AS bad_password_msg
FROM users
ORDER BY bad_password_msg DESC, 
		 last_name DESC,
		 first_name || COALESCE(patronymic, '');

-- 11. Выбрать максимальный и минимальный размер ставки.

SELECT MAX(amount) AS max_bet_amount,
	   MIN(amount) AS min_bet_amount
FROM bets;

-- 12. Выбрать средний размер ставок пользователя с id = 4.
	 
SELECT AVG(amount) 
FROM bets
WHERE id = 4;

/* 13. Выбрать название чемпионата первого в списке, упорядоченного 
по названию в лексикографическом порядке. */

SELECT name
FROM tournaments
ORDER BY name
LIMIT 1;

SELECT MIN(name) 
FROM tournaments;

-- 14. Выбрать общую сумму, на которую сделали ставки пользователи с четным id.

SELECT SUM(amount) 
FROM bets
WHERE user_id % 2 = 0;

-- 15. Выбрать общее количество пользователей с логином содержащим символ @, но не содержащим '. 

SELECT COUNT(*)
FROM users
WHERE TRIM(login) LIKE '%@%'
	AND TRIM(login) NOT LIKE '%''%';
	
-- 16. Выбрать название чемпионатов, на которые делал ставки Иванов Иван Иванович

SELECT DISTINCT N.name 
FROM bets B 
	JOIN users U ON B.user_id = U.id
	JOIN events_outcomes EO ON B.event_id = EO.event_id AND B.outcome_id = EO.outcome_id
	JOIN events E ON EO.event_id = E.id
	JOIN tournaments_in_seasons TS ON E.tournament_id = TS.id
	JOIN tournaments TN ON TS.tournament_id = TN.id
WHERE U.last_name = 'Иванов'
	AND U.first_name = 'Иван'
	AND U.patronymic = 'Иванович';
	
/* 17. Выбрать ФИО пользователя, название чемпионата,
название вида события, данные самого события, исход и сумму ставки. 
Результат отсортировать по ФИО в лексикографическом порядке и сумме ставки в убывающем порядке. */

SELECT (U.last_name || ' ' || U.first_name || ' ' || COALESCE(patronymic, '')) AS user_full_name,
		CONCAT(TN.name,
			   ' ',
			   CASE 
			   WHEN EXTRACT(YEAR FROM TS.start_date) = EXTRACT(YEAR FROM TS.end_date)
			   THEN EXTRACT(YEAR FROM TS.start_date)::text
			   ELSE EXTRACT(YEAR FROM TS.start_date)::text || '/' || EXTRACT(YEAR FROM TS.end_date)::text
			   END			
			  ) AS tournament_name,
		TN.participants_type AS tourn_participants_type,
		PT1.name AS event_first_participant, 
		PT2.name AS event_second_participant,
		E.start_time AS event_start_time,
		E.end_time AS event_end_time,
		O.name AS outcome_name,
		B.amount AS bet_amount
FROM users U 
	JOIN bets B ON U.id = B.user_id
	JOIN events_outcomes EO ON (B.event_id = EO.event_id AND B.outcome_id = EO.outcome_id)
	JOIN outcomes O ON EO.outcome_id = O.id
	JOIN events E ON EO.event_id = E.id
	JOIN tournaments_in_seasons AS TS ON E.tournament_id = TS.id
	JOIN tournaments TN ON TS.tournament_id = TN.id 
	JOIN participants PT1 ON E.first_participant_id = PT1.id
	JOIN participants PT2 ON E.second_participant_id = PT2.id
ORDER BY user_full_name, bet_amount DESC;

/* 18. Выбрать ФИО всех пользователей, и если у пользователя есть ставки, 
то сумму ставки, исход, название чемпионата, названия команд. */

SELECT (U.last_name || ' ' || U.first_name || ' ' || COALESCE(patronymic, '')) AS user_full_name,
		B.amount AS bet_amount,
		O.name AS outcome_name,
		CONCAT(TN.name,
			   ' ',
			   CASE 
			   WHEN EXTRACT(YEAR FROM TS.start_date) = EXTRACT(YEAR FROM TS.end_date)
			   THEN EXTRACT(YEAR FROM TS.start_date)::text
			   ELSE EXTRACT(YEAR FROM TS.start_date)::text || '/' || EXTRACT(YEAR FROM TS.end_date)::text
			   END			
			  ) AS tournament_name,
		PT1.name AS event_first_participant, 
		PT2.name AS event_second_participant
FROM users U 
	LEFT JOIN bets B ON U.id = B.user_id
	LEFT JOIN events_outcomes EO ON (B.event_id = EO.event_id AND B.outcome_id = EO.outcome_id)
	LEFT JOIN outcomes O ON EO.outcome_id = O.id
	LEFT JOIN events E ON EO.event_id = E.id
	LEFT JOIN tournaments_in_seasons AS TS ON E.tournament_id = TS.id
	LEFT JOIN tournaments TN ON TS.tournament_id = TN.id 
	LEFT JOIN participants PT1 ON E.first_participant_id = PT1.id
	LEFT JOIN participants PT2 ON E.second_participant_id = PT2.id;

/* 19. Выбрать логины всех пользователей и если у пользователя есть ставки, то общую сумму ставок. 
Результат отсортировать по сумме в порядке убывания. */

SELECT U.login,
	   SUM(B.amount) AS total_bet_amount
FROM users U LEFT JOIN bets B
	ON U.id = B.user_id
GROUP by U.login
ORDER BY 2 DESC;

/* 20. Выбрать id, логины, фамилию и инициалы пользователей, делавших ставки 
на события какого-то конкретного чемпионата (значение подставьте сами). */

SELECT DISTINCT U.id, 
				U.login,
				CONCAT(U.last_name, ' ', 
			  		   LEFT(U.first_name, 1), '. ',
			  		   COALESCE(LEFT(patronymic, 1) || '.', '') 
			 		  ) AS name
FROM users U 
	JOIN bets B ON U.id = B.user_id
	JOIN events_outcomes EO ON (B.event_id = EO.event_id AND B.outcome_id = EO.outcome_id)
	JOIN events E ON EO.event_id = E.id
	JOIN tournaments_in_seasons TS ON E.tournament_id = TS.id
	JOIN tournaments TN ON TS.tournament_id = TN.id
WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TS.end_date) = 2022;

/* 21. Выбрать названия всех чемпионатов, и если есть ставки на события чемпионата, 
то количество людей, сделавших ставки. 
В результат включить только тех, для кого указаны фамилия, имя, отчество. */

SELECT (TN.name || ' ' || CASE
						 	WHEN EXTRACT(YEAR FROM TS.start_date) 
								 = EXTRACT(YEAR FROM TS.end_date) 
							THEN EXTRACT(YEAR FROM TS.start_date)::text
							ELSE EXTRACT(YEAR FROM TS.start_date)::text || '/' || EXTRACT(YEAR FROM TS.end_date)::text
						  END) AS tournament_name,
	    COUNT(DISTINCT U.id)
FROM tournaments_in_seasons TS
	JOIN tournaments TN ON TS.tournament_id = TN.id
	LEFT JOIN events E ON TS.id = E.tournament_id
	LEFT JOIN bets B ON E.id = B.event_id
	LEFT JOIN users U ON B.user_id = U.id AND U.patronymic IS NOT NULL AND U.patronymic <> ''
GROUP BY TS.id, tournament_name;

-- 22. Для каждого пользователя вывести названия всех чемпионатов.

SELECT U.login AS user_login, TN.name AS tournament_name
	FROM tournaments TN CROSS JOIN users U;
	
/* 23. Для каждого пользователя вывести названия всех чемпионатов, и если пользователь делал ставки
на события чемпионата, то общую сумму ставок этого пользователя. */

SELECT U.login AS user_login,
	   (TN.name || ' ' || CASE
						 	WHEN EXTRACT(YEAR FROM TS.start_date) 
								 = EXTRACT(YEAR FROM TS.end_date) 
							THEN EXTRACT(YEAR FROM TS.start_date)::text
							ELSE EXTRACT(YEAR FROM TS.start_date)::text || '/' || EXTRACT(YEAR FROM TS.end_date)::text
						  END) AS tournament_name,
		SUM(B.amount) AS total_bet_amount
FROM users U 
	CROSS JOIN tournaments_in_seasons TS 
	LEFT JOIN tournaments TN ON TS.tournament_id = TN.id
	LEFT JOIN events E ON TS.id = E.tournament_id
	LEFT JOIN bets B ON (E.id = B.event_id AND U.id = B.user_id)
GROUP BY user_login, TS.id, tournament_name;

-- 24. Выбрать пользователей, которые в результате выигрыша получили сумму равную удвоенной ставки.

SELECT DISTINCT U.login
FROM users U 
	JOIN bets B ON U.id = B.user_id
	JOIN events_outcomes EO ON (B.event_id = EO.event_id AND B.outcome_id = EO.outcome_id)
WHERE EO.occured = true AND EO.odd = 2.0;

-- 25. Выбрать пары пользователей с разными логинами, но одинаковыми паролями.

SELECT U1.login AS first_user_login,
	   U1.password AS first_user_password,
	   U2.login AS second_user_login,
	   U2.password AS second_user_password
FROM users U1 JOIN users U2
	ON U1.login <> U2.login AND U1.password = U2.password 
WHERE U1.id < U2.id;
	
-- 26. Выбрать пары пользователей, которые делали ставки на одни и те же чемпионаты.
-- Имеется в виду, что хотя бы какие то чемпионаты должны совпадать.

SELECT DISTINCT
	   U1.login AS first_user_login,
	   U2.login AS second_user_login
FROM bets B1
	JOIN bets B2 ON B1.user_id <> B2.user_id
	JOIN users U1 ON B1.user_id = U1.id
	JOIN users U2 ON B2.user_id = U2.id
	JOIN events E1 ON B1.event_id = E1.id
	JOIN events E2 ON B2.event_id = E2.id
WHERE E1.tournament_id = E2.tournament_id
	AND B1.user_id < B2.user_id;

-- 27. Выбрать количество пользователей однофамильцев-тезок среди пользователей

SELECT COUNT(DISTINCT U1.id) 
FROM users U1 JOIN users U2 
	ON U1.id <> U2.id
WHERE U1.first_name = U2.first_name
	AND U1.last_name = U2.last_name;
	
-- 28. Выбрать id и сумму трех самых больших ставок.

SELECT id, amount
FROM bets 
ORDER BY amount DESC
LIMIT 3;

-- 29.Выбрать пары пользователей, которые сделали одинаковые ставки на одни и те же события и исход.
-- Имеется в виду, что хотя бы какие то одинаковые ставки.

SELECT U1.login AS first_user_login,
	   U2.login AS second_user_login,
	   B1.event_id AS first_user_event_id,
	   O1.name AS first_user_outcome,
	   B2.event_id AS second_user_event_id,
	   O2.name AS second_user_outcome
FROM bets B1
	JOIN bets B2 ON (B1.event_id = B2.event_id AND B1.outcome_id = B2.outcome_id)
	JOIN users U1 ON B1.user_id = U1.id
	JOIN users U2 ON B2.user_id = U2.id
	JOIN outcomes O1 ON B1.outcome_id = O1.id
	JOIN outcomes O2 ON B2.outcome_id = O2.id
WHERE B1.user_id < B2.user_id;

-- 30. Выбрать название чемпионата и количество пользователей, делавших ставки.

SELECT (TN.name || ' ' || CASE
						 	WHEN EXTRACT(YEAR FROM TS.start_date) 
								 = EXTRACT(YEAR FROM TS.end_date) 
							THEN EXTRACT(YEAR FROM TS.start_date)::text
							ELSE EXTRACT(YEAR FROM TS.start_date)::text || '/' || EXTRACT(YEAR FROM TS.end_date)::text
						  END) AS tournament,
	   COUNT(DISTINCT U.id) AS users_count
FROM tournaments_in_seasons TS 
	JOIN tournaments TN ON TS.tournament_id = TN.id 
	LEFT JOIN events E ON TS.id = E.tournament_id
	LEFT JOIN bets B ON E.id = B.event_id
	LEFT JOIN users U ON B.user_id = U.id
GROUP BY tournament;

/* 31.Выбрать id события, названия команд, название чемпионата, 
название вида события, исход и общую сумму ставок.
Результат отсортировать по названию чемпионата в лексикографическом порядке. */

SELECT E.id AS event_id,
	   PT1.name AS first_participant,
	   PT2.name AS second_participant,
	   (TN.name || ' ' || CASE
						 	WHEN EXTRACT(YEAR FROM TS.start_date) 
								 = EXTRACT(YEAR FROM TS.end_date) 
							THEN EXTRACT(YEAR FROM TS.start_date)::text
							ELSE EXTRACT(YEAR FROM TS.start_date)::text || '/' || EXTRACT(YEAR FROM TS.end_date)::text
						  END) AS tournament,
	   TN.participants_type,
	   O.name AS outcome,
	   SUM(B.amount) AS total_bet_amount
FROM events E
	JOIN participants PT1 ON E.first_participant_id = PT1.id
	JOIN participants PT2 ON E.second_participant_id = PT2.id
	JOIN tournaments_in_seasons TS ON E.tournament_id = TS.id
	JOIN tournaments TN ON TS.tournament_id = TN.id 
	JOIN events_outcomes EO ON (E.id = EO.event_id AND EO.occured = TRUE)
	JOIN outcomes O ON EO.outcome_id = O.id
	LEFT JOIN bets B ON E.id = B.event_id
GROUP BY E.id, first_participant, second_participant, tournament, TN.participants_type, outcome
ORDER BY tournament;

/* 32. Выбрать название чемпионата, название события и среднюю сумму 
ставок на выигрыш конкретной команды (значение подставьте сами) */

SELECT DISTINCT
	   (TN.name || ' ' || CASE
						 	WHEN EXTRACT(YEAR FROM TS.start_date) 
								 = EXTRACT(YEAR FROM TS.end_date) 
							THEN EXTRACT(YEAR FROM TS.start_date)::text
							ELSE EXTRACT(YEAR FROM TS.start_date)::text || '/' || EXTRACT(YEAR FROM TS.end_date)::text
						  END) AS tournament,
	   E.start_time AS event_start_time,
	   PT1.name AS first_participant,
	   PT2.name AS second_participant,
	   AVG(CASE 
		   WHEN PT1.name = 'Россия' AND O.name = 'П1'
		   	OR PT2.name = 'Россия' AND O.name = 'П2' 
		   THEN B.amount END) AS avg_amount_of_bet_on_Russia
FROM events E
	JOIN tournaments_in_seasons TS ON E.tournament_id = TS.id
	JOIN tournaments TN ON TS.tournament_id = TN.id 
	JOIN participants PT1 ON E.first_participant_id = PT1.id
	JOIN participants PT2 ON E.second_participant_id = PT2.id
	LEFT JOIN bets B ON E.id = B.event_id
	LEFT JOIN outcomes O ON B.outcome_id = O.id
WHERE PT1.name = 'Россия' 
	OR PT2.name = 'Россия' 
GROUP BY TS.id, tournament, event_start_time, first_participant, second_participant; 
	
/* 33. Выбрать название чемпионата, название команды и количество 
пользователей, сделавших ставки на выигрыш этой команды. 
В результат включить команды с названием, состоящим из двух слов. 
Результат отсортировать по количеству в убывающем порядке. */

SELECT (TN.name || ' ' || CASE
						 	WHEN EXTRACT(YEAR FROM TS.start_date) 
								 = EXTRACT(YEAR FROM TS.end_date) 
							THEN EXTRACT(YEAR FROM TS.start_date)::text
							ELSE EXTRACT(YEAR FROM TS.start_date)::text || '/' || EXTRACT(YEAR FROM TS.end_date)::text
						  END) AS tournament,
	   P.name AS participant,
	   COUNT(DISTINCT B.user_id) AS users_count
FROM tournaments TN 
	JOIN tournaments_in_seasons TS ON TN.id = TS.tournament_id
								   	AND TN.participants_type IN ('club', 'national team')
	JOIN participations_in_tournaments PT ON TS.id = PT.tournament_in_season_id
	JOIN participants P ON PT.participant_id = P.id
	LEFT JOIN events E ON P.id = E.first_participant_id 
				  	OR P.id = E.second_participant_id
	LEFT JOIN bets B ON E.id = B.event_id
	LEFT JOIN outcomes O ON B.outcome_id = O.id
WHERE P.name LIKE '% %' AND P.name NOT LIKE '% % %'
	AND (O.name = 'П1' AND E.first_participant_id = P.id
		 OR O.name = 'П2' AND E.second_participant_id = P.id)
GROUP BY TS.id, tournament, participant
ORDER BY users_count DESC;
	   
	   
-- 34. Выбрать ФИО пользователей, делавших ставки только на два чемпионата.

SELECT (U.last_name || ' ' || U.first_name || ' ' || COALESCE(patronymic, '')) AS user_full_name
FROM users U
	JOIN bets B ON U.id = B.user_id
	JOIN events E ON B.event_id = E.id
GROUP BY U.id, user_full_name
HAVING COUNT(DISTINCT E.tournament_id) = 2;

-- 35. Выбрать все данные пользователей, сделавших более трех ставок на один чемпионат. 

SELECT U.*
FROM users U
	JOIN bets B ON U.id = B.user_id
	JOIN events E ON B.event_id = E.id
GROUP BY U.id, E.tournament_id
HAVING COUNT(B.id) > 3

/* 36. Выбрать название вида события, id события, названия команд, количество
пользователей, поставивших на проигрыш, и количество пользователей, поставивших на выигрыш. 
В результат включить только события конкретного чемпионата (значение подставьте сами), и события, 
на которые ставки сделали более трех пользователей */

SELECT TN.participants_type AS event_participants_type,
	   E.id AS event_id,
	   P1.name AS first_participant, 
	   P2.name AS second_participant,
	   COUNT(DISTINCT (CASE WHEN O.name = 'П1' THEN B.user_id END)) AS users_count_on_first,
	   COUNT(DISTINCT (CASE WHEN O.name = 'П2' THEN B.user_id END)) AS users_count_on_second
FROM events E
	LEFT JOIN tournaments_in_seasons TS ON E.tournament_id = TS.id
	LEFT JOIN tournaments TN ON TS.tournament_id = TN.id
	LEFT JOIN participants P1 ON E.first_participant_id = P1.id
	LEFT JOIN participants P2 ON E.second_participant_id = P2.id
	LEFT JOIN bets B ON E.id = B.event_id 
	LEFT JOIN outcomes O ON B.outcome_id = O.id
GROUP BY E.id, event_participants_type, first_participant, second_participant
HAVING COUNT(DISTINCT B.user_id) > 3;

-- 37. Выбрать логины пользователей с четным id, которые делали ставки на события только двух чемпионатов.

SELECT U.id, U.login 
FROM users U
	JOIN bets B ON U.id = B.user_id 
	JOIN events E ON B.event_id = E.id
WHERE U.id % 2 = 0
GROUP BY U.id, U.login
HAVING COUNT(DISTINCT E.tournament_id) = 2;

/* 38. Выбрать id события в первом столбце, во втором столбце - количество
ставок с суммой выше какого-то конкретного значения (значение подставьте сами), 
в третьем столбце - количество ставок с суммой меньше, указанного вами значения. */

SELECT E.id AS event_id,
	   COUNT(CASE WHEN B.amount > 1000 THEN 1 END) AS bet_amount_more_1000_count,
	   COUNT(CASE WHEN B.amount < 1000 THEN 1 END) AS bet_amount_less_1000_count
FROM events E LEFT JOIN bets B ON E.id = B.event_id
GROUP BY E.id;
	   
/* 39. Выбрать пары пользователей с одинаковой фамилией и делавших ставки на одно 
и то же событие, но на противоположный результат с одинаковой суммой ставки. */	   
	   
SELECT U1.login AS first_user_login,
	   U1.last_name AS first_user_last_name,
	   U1.first_name AS first_user_first_name,
	   U1.patronymic AS first_user_patronymic,
	   U2.login AS second_user_login,
	   U2.last_name AS second_user_last_name,
	   U2.first_name AS second_user_first_name,
	   U2.patronymic AS first_user_patronymic,
	   B1.event_id AS first_user_event_id, 
	   B2.event_id AS second_user_event_id,
	   O1.name AS first_user_bet_outcome, 
	   O2.name AS second_user_bet_outcome, 
	   B1.amount AS first_user_bet_amount, 
	   B2.amount AS second_user_bet_amount
FROM users U1
	JOIN users U2 ON U1.last_name = U2.last_name
	JOIN bets B1 ON U1.id = B1.user_id
	JOIN outcomes O1 ON B1.outcome_id = O1.id
	JOIN bets B2 ON U2.id = B2.user_id
	JOIN outcomes O2 ON B2.outcome_id = O2.id
WHERE U1.id < U2.id
	AND B1.event_id = B2.event_id
	AND (O1.name = 'П1' AND O2.name = 'П2'
		 	OR O1.name = 'П2' AND O2.name = 'П1')
	AND B1.amount = B2.amount;
	   
-- 40. Выбрать для каждого пользователя итоговую сумму выигрыша и сумму им потерянную. 

SELECT U.login AS user_login,
	   SUM(CASE WHEN EO.occured = TRUE THEN B.amount * (B.odd - 1.0) END) AS total_amount_of_winnings,
	   SUM(CASE WHEN EO.occured = FALSE THEN B.amount END) AS total_amount_lost
FROM users U
	LEFT JOIN bets B ON U.id = B.user_id
	JOIN events_outcomes EO ON  (B.event_id = EO.event_id AND B.outcome_id = EO.outcome_id)
GROUP BY U.id, user_login;
	   
-- 41. Выбрать все данные о пользователях ни разу не делавших ставки.

-- 42. Выбрать все данные по событию с самым высоким коэффициентом.
	   
-- 43. Выбрать все данные по событиям с самым высоким и самым низким коэффициентами.	

-- 44. Выбрать все данные пользователей, чья фамилия совпадает с названием команды.

SELECT U.*
FROM users U JOIN participants P
	ON P.participant_type IN ('club', 'national team') 
		AND U.last_name = P.name;

-- 45. Выбрать вид события, на котором больше всего ставок сделано.













 