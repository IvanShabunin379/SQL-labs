INSERT INTO bets (user_id, event_id, outcome_id, bet_timestamp, odd, amount)
SELECT
    (RANDOM() * (1052 - 50) + 50)::INT AS user_id,  -- Случайный user_id
    eo.event_id,  -- event_id из event_outcomes
    eo.outcome_id,  -- outcome_id из event_outcomes
    NOW() - (RANDOM() * INTERVAL '365 days') AS bet_timestamp,  -- Случайная дата ставки
    eo.odd,  -- Используем коэффициент из event_outcomes
    ROUND(RANDOM() * 1000 + 50)  -- Сумма ставки от 50 до 1050
FROM events_outcomes eo
JOIN generate_series(1, 1000) AS gs ON TRUE;  -- Генерация 1000 строк
