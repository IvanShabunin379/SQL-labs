-- 1. Создаем роли и наделяем их необходимыми привилегиями

-- создание ролей
CREATE ROLE first_manager WITH LOGIN PASSWORD 'first';
CREATE ROLE second_manager WITH LOGIN PASSWORD 'second';

-- назначение прав для роли first_manager
GRANT SELECT, UPDATE ON events_outcomes, events TO first_manager;

-- назначение прав для роли second_manager
GRANT SELECT, UPDATE ON events_outcomes, events TO second_manager;

-- ограничение прав для безопасности
-- роли не могут удалять или изменять структуру таблицы
REVOKE DELETE, INSERT, TRUNCATE, REFERENCES ON events_outcomes FROM first_manager;
REVOKE DELETE, INSERT, TRUNCATE, REFERENCES ON events_outcomes FROM second_manager;



-- 2. Выполнение действий, вызывающих блокировку

-- второй менеджер
BEGIN;

UPDATE events_outcomes
SET odd = 1.05
WHERE event_id = 32 AND outcome_id = 3;

UPDATE events_outcomes
SET odd = 10
WHERE event_id = 32 AND outcome_id = 1;

-- первый менеджер
BEGIN;

UPDATE events_outcomes
SET occured = false AND odd = 1.0
WHERE event_id = 32 AND outcome_id = 1;

UPDATE events_outcomes
SET occured = true AND odd = 1.0
WHERE event_id = 32 AND outcome_id = 3;



-- 3. Завершение блокирующего сеанса вручную

-- посмотрим информацию об обслуживающих процессах
SELECT pid, query, state, wait_event, wait_event_type, pg_blocking_pids(pid)
FROM pg_stat_activity
WHERE backend_type = 'client backend';

-- узнаем номер заблокированного процесса при помощи функции pg_blocking_pids
SELECT pid AS blocked_pid
FROM pg_stat_activity
WHERE backend_type = 'client backend'
AND cardinality(pg_blocking_pids(pid)) > 0;

-- прерываем блокирующий сеанс
SELECT pg_terminate_backend(b.pid)
FROM unnest(pg_blocking_pids(10924)) AS b(pid);

-- проверяем состояние обслуживающих процессов
SELECT pid, query, state, wait_event, wait_event_type
FROM pg_stat_activity
WHERE backend_type = 'client backend';



-- 4. Пример взаимной блокировки

-- первый менеджер
BEGIN;

UPDATE events
SET start_time = start_time + INTERVAL '2 hours',
	end_time = end_time + INTERVAL '2 hours'
WHERE id = 1;

-- второй менеджер
BEGIN;

UPDATE events
SET start_time = start_time + INTERVAL '1 day',
	end_time = end_time + INTERVAL '1 day'
WHERE id = 2;

UPDATE events
SET start_time = start_time + INTERVAL '1 day',
	end_time = end_time + INTERVAL '1 day'
WHERE id = 1;

-- первый менеджер
UPDATE events
SET start_time = start_time + INTERVAL '2 hours',
	end_time = end_time + INTERVAL '2 hours'
WHERE id = 2;



-- Отзыв прав у ролей и их удаление

REVOKE ALL PRIVILEGES ON events_outcomes, events FROM first_manager;
REVOKE ALL PRIVILEGES ON events_outcomes, events FROM second_manager;

DROP ROLE IF EXISTS first_manager;
DROP ROLE IF EXISTS second_manager;











