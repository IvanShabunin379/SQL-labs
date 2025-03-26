BEGIN;

-- 1. Создание таблицы - журнала аудита

CREATE TABLE audit_events (
	id SERIAL PRIMARY KEY,
	operation_type TEXT,         
    operation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,   
    role_name TEXT,               
    old_data JSONB,              
    new_data JSONB 
);

-- 2. Создание триггерной функции и триггера для записи в журнал аудита

CREATE OR REPLACE FUNCTION log_event_end_time_change()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO audit_events(operation_type, role_name, old_data, new_data)
	VALUES (
    	'UPD',
    	CURRENT_USER,
    	to_jsonb(OLD),  
    	to_jsonb(NEW)   
	);

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER audit_event_end_time
AFTER UPDATE OF end_time ON events
FOR EACH ROW
WHEN (OLD.end_time IS DISTINCT FROM NEW.end_time)
EXECUTE FUNCTION log_event_end_time_change();

-- 3.1. Действия, подлежащие аудиту

UPDATE events
SET end_time = CURRENT_TIMESTAMP
WHERE id BETWEEN 1 AND 10;

-- роль менеджера
CREATE ROLE manager WITH LOGIN PASSWORD 'manager';

GRANT SELECT
ON events
TO manager;

GRANT UPDATE(start_time, end_time)
ON events
TO manager;

GRANT INSERT
ON audit_events
TO manager;

GRANT USAGE, SELECT
ON SEQUENCE audit_events_id_seq
TO manager;

SET ROLE manager;

UPDATE events
SET end_time = CURRENT_TIMESTAMP
WHERE EXTRACT(YEAR FROM end_time) = 2023;

RESET ROLE

-- 3.2. Действия, не подлежащие аудиту

INSERT INTO events(id, tournament_id, first_participant_id, second_participant_id, start_time, end_time)
VALUES (100,
		(SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022),
	    (SELECT id FROM participants WHERE name = 'Испания'),
	    (SELECT id FROM participants WHERE name = 'Германия'),
	    TIMESTAMP '2022-11-27 21:00:00',
	    TIMESTAMP '2022-11-28 00:00:00'
	   );
	   
-- роль менеджера
SET ROLE manager;

UPDATE events
SET start_time = TIMESTAMP '2022-11-27 22:00:00'
WHERE id = 100;

RESET ROLE;

-- 4. Просмотр содержимого журнала аудита

SELECT * FROM audit_events;



ROLLBACK








