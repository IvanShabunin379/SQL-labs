-- 1. Создаём партиционированную копию таблицы bets.

CREATE TABLE bets_partitioned (
    id SERIAL NOT NULL,
    user_id INT NOT NULL,
    event_id INT NOT NULL,
    outcome_id INT NOT NULL,
    bet_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    odd NUMERIC(6,2) NOT NULL DEFAULT 1.00,
    amount INT NOT NULL,
    PRIMARY KEY (id, amount) 
) PARTITION BY RANGE (amount);


ALTER TABLE bets_partitioned
ADD CONSTRAINT bet_user_fk
	FOREIGN KEY (user_id)
	REFERENCES users(id),
ADD CONSTRAINT bet_event_outcome_fk
	FOREIGN KEY (event_id, outcome_id)
	REFERENCES events_outcomes(event_id, outcome_id),
ADD CONSTRAINT valid_odd
	CHECK (odd >= 1.00 AND odd <= 5000.00),
ADD CONSTRAINT valid_amount
	CHECK (amount::numeric >= 50.00 AND amount * odd <= 3000000.00);
	
	
-- 2. Задаём партиции 

CREATE TABLE bets_small
PARTITION OF bets_partitioned
FOR VALUES FROM (50) TO (5000);

CREATE TABLE bets_medium
PARTITION OF bets_partitioned
FOR VALUES FROM (5000) TO (25000);

CREATE TABLE bets_large
PARTITION OF bets_partitioned
FOR VALUES FROM (25000) TO (100000);

CREATE TABLE bets_huge
PARTITION OF bets_partitioned
FOR VALUES FROM (100000) TO (3000000);

	
-- 3. Вставка данных из обычной таблицы в партиционированную

INSERT INTO bets_partitioned (id, user_id, event_id, outcome_id, bet_timestamp, odd, amount)
SELECT id, user_id, event_id, outcome_id, bet_timestamp, odd, amount
FROM bets;


-- 4. Сравнение планов запросов по ключу секционирования к секционированной и несекционированной таблицам

EXPLAIN ANALYZE
SELECT * FROM bets WHERE amount >= 100000;

EXPLAIN ANALYZE
SELECT * FROM bets_partitioned WHERE amount >= 100000;

-- Добавляем индекс

CREATE INDEX ON bets(amount);
CREATE INDEX ON bets_partitioned(amount);


-- 5. Сравнение планов запросов не по ключу секционирования к секционированной и несекционированной таблицам

EXPLAIN ANALYZE
SELECT * FROM bets WHERE odd > 2.5;

EXPLAIN ANALYZE
SELECT * FROM bets_partitioned WHERE odd > 2.5;


-- 6. Операции с секционированными таблицами

-- Отключение секции

ALTER TABLE bets_partitioned DETACH PARTITION bets_small;

SELECT * FROM bets_partitioned WHERE amount < 5000;
SELECT * FROM bets_small WHERE amount < 5000;

-- Подключение секции

ALTER TABLE bets_partitioned ATTACH PARTITION bets_small FOR VALUES FROM (50) TO (5000);

SELECT * FROM bets_partitioned WHERE amount < 5000;





















