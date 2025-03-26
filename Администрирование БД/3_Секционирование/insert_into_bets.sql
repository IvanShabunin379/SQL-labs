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
