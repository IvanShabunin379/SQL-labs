SELECT * FROM pg_stat_user_functions;

SHOW track_functions;

SET track_functions = 'all';

-- Запрос, использующий данную хранимую функцию
/* Выбрать все футбольные чемпионаты, на которые сделаны ставки и для каждого такого чемпионата, 
сколько пользователей делали ставки на этот чемпионат */

EXPLAIN ANALYZE
SELECT TS.id AS tournament_id,
	    tournament_in_season_name(TN.name, TS.start_date, TS.end_date) AS tournament_name,
		num_users_who_bet(TS.id)
FROM tournaments_in_seasons TS 
	JOIN tournaments TN ON TS.tournament_id = TN.id
	JOIN sports S ON TN.sport_id = S.id
WHERE S.name = 'футбол';

-- Альтернативный запрос

EXPLAIN ANALYZE
SELECT TS.id AS tournament_id,
	   tournament_in_season_name(TN.name, TS.start_date, TS.end_date) AS tournament_name,
	   COUNT(DISTINCT B.user_id) AS num_users_who_bet
FROM tournaments_in_seasons TS 
	JOIN tournaments TN ON TS.tournament_id = TN.id
	JOIN events E ON TS.id = E.tournament_id
	JOIN bets B ON E.id = B.event_id
	JOIN sports S ON TN.sport_id = S.id
WHERE S.name = 'футбол'
GROUP BY TS.id, tournament_name;

-- смотрим статистику
SELECT * FROM pg_stat_user_functions;

-- Примеры простых вызовов данных хранимых функций

SELECT tournament_in_season_name(TN.name, TS.start_date, TS.end_date) AS tournament_name
FROM tournaments_in_seasons TS JOIN tournaments TN 
	ON TS.tournament_id = TN.id;

SELECT num_users_who_bet(TS.id)
FROM tournaments_in_seasons TS
WHERE TS.id = 1;

-- смотрим статистику
SELECT * FROM pg_stat_user_functions;













