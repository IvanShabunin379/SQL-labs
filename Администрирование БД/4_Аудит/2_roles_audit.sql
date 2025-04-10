-- Роль старшего аналитика

CREATE ROLE senior_analyst LOGIN PASSWORD 'senior_analyst';

GRANT SELECT
ON tournaments, tournaments_in_seasons, sports
TO senior_analyst;

GRANT SELECT, INSERT
ON bets, events, events_outcomes, users
TO senior_analyst;

GRANT USAGE, SELECT
ON SEQUENCE bets_id_seq
TO senior_analyst;

-- Настройка аудита роли

ALTER ROLE senior_analyst
SET log_min_duration_statement = 100; 

-- Запросы, которые попадут в журнал

SET ROLE senior_analyst;

SELECT * FROM bets WHERE odd > 2.5;

DO $$
DECLARE
    -- Максимальные значения
    max_bets INT := 100000; -- Число строк
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


RESET ROLE;

