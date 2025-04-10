-- 1. Настройка расширения pg_stat_statements

SHOW shared_preload_libraries;

ALTER SYSTEM SET shared_preload_libraries = 'pg_stat_statements';

-- Перезагружаем pgAdmin

CREATE EXTENSION pg_stat_statements;

-- вставка
DO $$
DECLARE
    -- Максимальные значения
    max_bets INT := 100; -- Число строк
    max_bet_amount NUMERIC := 150000; -- Максимальная сумма ставки
    min_bet_amount NUMERIC := 50; -- Минимальная сумма ставки
    current_user_id INT;
    current_event_id INT;
    current_outcome_id INT;
    current_odd NUMERIC;
    bet_amount NUMERIC;
BEGIN
    -- Цикл генерации ставок
    FOR i IN 1..max_bets LOOP
        -- Случайные пользователи, события и исходы
        current_user_id := (SELECT id FROM users ORDER BY random() LIMIT 1);
        SELECT event_id, outcome_id, odd
        INTO current_event_id, current_outcome_id, current_odd
        FROM events_outcomes
        ORDER BY random()
        LIMIT 1;

        -- Генерация размера ставки с учетом распределения
        bet_amount := min_bet_amount + (max_bet_amount - min_bet_amount) * (1 - sqrt(random()));

        -- Вставка ставки
        INSERT INTO bets (user_id, event_id, outcome_id, odd, amount)
        VALUES (current_user_id, current_event_id, current_outcome_id, current_odd, bet_amount::INT);
    END LOOP;
END $$;

-- изменение 
UPDATE bets
SET odd = 1.0
WHERE user_id = 1001;

-- выбрать все данные о ставках, сумма которых в диапазоне от 600 до 1000.
SELECT *
FROM bets
WHERE amount BETWEEN 600 AND 1000;

-- выбрать максимальный и минимальный размер ставки.
SELECT MAX(amount) AS max_bet_amount,
	   MIN(amount) AS min_bet_amount
FROM bets;

-- выбрать средний размер ставок пользователя с id = 4. 
SELECT AVG(amount) 
FROM bets
WHERE id = 4;

-- выбрать общую сумму, на которую сделали ставки пользователи с четным id.
SELECT SUM(amount) 
FROM bets
WHERE user_id % 2 = 0;

-- выбрать название чемпионатов, на которые делал ставки Иванов Иван Иванович
SELECT DISTINCT TN.name 
FROM bets B 
	JOIN users U ON B.user_id = U.id
	JOIN events_outcomes EO ON B.event_id = EO.event_id AND B.outcome_id = EO.outcome_id
	JOIN events E ON EO.event_id = E.id
	JOIN tournaments_in_seasons TS ON E.tournament_id = TS.id
	JOIN tournaments TN ON TS.tournament_id = TN.id
WHERE U.last_name = 'Иванов'
	AND U.first_name = 'Иван'
	AND U.patronymic = 'Иванович';
	
/* Выбрать логины всех пользователей и если у пользователя есть ставки, то общую сумму ставок. 
Результат отсортировать по сумме в порядке убывания. */
SELECT U.login,
	   SUM(B.amount) AS total_bet_amount
FROM users U LEFT JOIN bets B
	ON U.id = B.user_id
GROUP by U.login
ORDER BY 2 DESC;

-- выбрать все данные пользователей, сделавших более трех ставок на один чемпионат. 

SELECT U.*
FROM users U
	JOIN bets B ON U.id = B.user_id
	JOIN events E ON B.event_id = E.id
GROUP BY U.id, E.tournament_id
HAVING COUNT(B.id) > 3;



SELECT query, calls, total_exec_time
FROM pg_stat_statements
ORDER BY calls DESC LIMIT 1;

SELECT query, calls, total_exec_time
FROM pg_stat_statements;











