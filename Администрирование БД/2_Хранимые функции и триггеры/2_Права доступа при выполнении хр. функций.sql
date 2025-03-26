-- Создание ролей

-- роль младшего аналитика
CREATE ROLE junior_analyst WITH LOGIN PASSWORD 'junior_analyst';

GRANT SELECT
ON tournaments, tournaments_in_seasons, sports
TO junior_analyst;

-- роль старшего аналитика
CREATE ROLE senior_analyst LOGIN PASSWORD 'senior_analyst';

GRANT SELECT
ON tournaments, tournaments_in_seasons, sports
TO senior_analyst;

GRANT SELECT
ON bets, events
TO senior_analyst;

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
$$ LANGUAGE plpgsql
SECURITY INVOKER;


-- Попытка вызова данной хранимой функии младшим аналитиком

SET ROLE junior_analyst;

SELECT TS.id AS tournament_id,
	    tournament_in_season_name(TN.name, TS.start_date, TS.end_date) AS tournament_name,
		num_users_who_bet(TS.id)
FROM tournaments_in_seasons TS 
	JOIN tournaments TN ON TS.tournament_id = TN.id
	JOIN sports S ON TN.sport_id = S.id
WHERE S.name = 'футбол';

RESET ROLE;

-- Попытка вызова данной хранимой функии младшим аналитиком

SET ROLE senior_analyst;

SELECT TS.id AS tournament_id,
	    tournament_in_season_name(TN.name, TS.start_date, TS.end_date) AS tournament_name,
		num_users_who_bet(TS.id)
FROM tournaments_in_seasons TS 
	JOIN tournaments TN ON TS.tournament_id = TN.id
	JOIN sports S ON TN.sport_id = S.id
WHERE S.name = 'футбол';

RESET ROLE;


-- Удаление хранимой функции и ролей

DROP FUNCTION num_users_who_bet(INT);

REVOKE SELECT ON tournaments, tournaments_in_seasons, sports FROM junior_analyst;
REVOKE SELECT ON tournaments, tournaments_in_seasons, sports, bets, events FROM senior_analyst;

DROP ROLE junior_analyst;
DROP ROLE senior_analyst;










