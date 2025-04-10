-- 1) Триггерная функция для проверки времени ставки

CREATE OR REPLACE FUNCTION check_bet_timestamp()
RETURNS TRIGGER
AS $$
BEGIN
	IF (SELECT end_time FROM events WHERE id = NEW.event_id) <= NEW.bet_timestamp
		THEN RAISE EXCEPTION 'Ставка не может быть сделана после завершения события!';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Триггеры на вставку и обновление ставок

CREATE TRIGGER check_bet_insert
	BEFORE INSERT ON bets
	FOR EACH ROW
	EXECUTE FUNCTION check_bet_timestamp();
	
CREATE TRIGGER check_bet_update
	BEFORE UPDATE ON bets
	FOR EACH ROW
	EXECUTE FUNCTION check_bet_timestamp();

-- Примеры вставки корректных и некорректных данных

INSERT INTO bets(user_id, event_id, outcome_id, bet_timestamp, odd, amount)
VALUES ((SELECT id FROM users WHERE login = '@milanista'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Португалия')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Швейцария')),
 		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2024-11-03 18:00:00',
		2.0,
		750
	   );
	   
INSERT INTO bets(id, user_id, event_id, outcome_id, bet_timestamp, odd, amount)
VALUES (54321,
	    (SELECT id FROM users WHERE login = '@kapusta'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Португалия')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Швейцария')),
 		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2022-11-01 18:00:00',
		2.0,
		750
	   );
	  
-- Примеры изменений на корретные и некорректные данные

UPDATE bets
SET bet_timestamp = TIMESTAMP '2022-11-01 18:30:00'
WHERE id = 54321;

UPDATE bets
SET bet_timestamp = NOW()
WHERE id = 54321;

-- Удаление ставки-примера

DELETE FROM bets WHERE id = 54321;

	
-- 2) Триггерная функция для проверки коэффициентов исходов, чтобы они были выгодны БК

CREATE OR REPLACE FUNCTION check_event_outcome_odds()
RETURNS TRIGGER AS $$
DECLARE
    total_probability NUMERIC := 0;
BEGIN
    -- считаем суммарную вероятность для всех актуальных коэффициентов
    SELECT SUM(100.0 / odd)
    INTO total_probability
    FROM events_outcomes
    WHERE event_id = NEW.event_id;
    
    -- проверяем, что общая вероятность всех исходов больше 100%
    IF total_probability <= 100.0 THEN
        RAISE EXCEPTION 'Коэффициенты на событие невыгодны для букмекерской конторы!';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Триггеры на вставку и обновление
CREATE TRIGGER check_event_outcome_insert
    AFTER INSERT ON events_outcomes
    FOR EACH ROW
    EXECUTE FUNCTION check_event_outcome_odds();

CREATE TRIGGER check_event_outcome_update
    AFTER UPDATE ON events_outcomes
    FOR EACH ROW
    EXECUTE FUNCTION check_event_outcome_odds();

-- Примеры вставки корректных и некорректных данных

INSERT INTO events(tournament_id, first_participant_id, second_participant_id, start_time, end_time)
VALUES ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022),
	    (SELECT id FROM participants WHERE name = 'Испания'),
	    (SELECT id FROM participants WHERE name = 'Германия'),
	    TIMESTAMP '2022-11-27 22:00:00',
	    TIMESTAMP '2022-11-28 00:00:00'
	   );
	   
INSERT INTO events_outcomes(event_id, outcome_id, odd, occured)
VALUES ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Испания')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Германия'
										 							 	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		3.5,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Испания')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Германия'
										 							 	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))),
		(SELECT id FROM outcomes WHERE name = 'X'),
		3.5,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Испания')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Германия'
										 							 	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		3.5,
		FALSE);

-- Примеры изменений на корретные и некорректные данные

UPDATE events_outcomes
SET odd = 2.5
WHERE event_id = (SELECT id FROM events
		 		  WHERE tournament_id = (SELECT TIS.id 
  		 								 FROM tournaments_in_seasons AS TIS 
  		 								 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 								 WHERE TN.name = 'Roland Garros' AND EXTRACT(YEAR FROM TIS.end_date) = 2022)
	    								 	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Новак Джокович')
	  										AND second_participant_id = (SELECT id FROM participants WHERE name = 'Рафаэль Надаль')
				 );


















