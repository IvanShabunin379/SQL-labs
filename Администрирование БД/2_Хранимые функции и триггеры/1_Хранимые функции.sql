-- Хранимая функция для подсчёта количества пользователей, ставивших на определённый чемпионат

CREATE OR REPLACE FUNCTION num_users_who_bet(tournament_on_bet_id INTEGER)
RETURNS INTEGER
AS $$
BEGIN
	RETURN (
		SELECT COUNT(DISTINCT B.user_id)
		FROM bets B JOIN events E
			ON B.event_id = E.id
		WHERE E.tournament_id = tournament_on_bet_id);
END;
$$ LANGUAGE plpgsql;

-- Хранимая функция для формирования названия чемпионата

CREATE OR REPLACE FUNCTION tournament_in_season_name(
	name TEXT,
	start_date DATE,
	end_date DATE
) RETURNS TEXT
AS $$
BEGIN
	RETURN CONCAT(name,
			   	  ' ',
			   	  CASE 
			   	  WHEN EXTRACT(YEAR FROM start_date) = EXTRACT(YEAR FROM end_date)
			   	  	THEN EXTRACT(YEAR FROM start_date)::text
			   	  	ELSE EXTRACT(YEAR FROM start_date)::text || '/' || EXTRACT(YEAR FROM end_date)::text
			   	  END 	
			  	  );
END;
$$ LANGUAGE plpgsql;

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







