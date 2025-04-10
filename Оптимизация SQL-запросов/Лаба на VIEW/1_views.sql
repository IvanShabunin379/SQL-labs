-- 1. Создание видов

-- Простой вид: Выбрать все данные о пользователях, у которых отчество неизвестно.
CREATE VIEW v_users_without_patronymic
AS
SELECT *
FROM users
WHERE (patronymic IS NULL) OR (patronymic = '');

/* Комплексный вид: Выбрать логины всех пользователей и если у пользователя есть ставки, то общую сумму ставок. 
Результат отсортировать по сумме в порядке убывания. */
CREATE VIEW v_bet_amount_by_user
AS
SELECT U.login AS login,
	   SUM(B.amount) AS total_bet_amount
FROM users U LEFT JOIN bets B
	ON U.id = B.user_id
GROUP by U.login;


-- 2. Модификация данных через виды

-- Вставка тестовой строки в таблицу users.
INSERT INTO users(login, password, last_name, first_name, patronymic, phone_number, date_of_birth)
VALUES ('aaa', 'qwerty', 'Anthony', 'Button', null, 88005553535, '2000-02-20');

-- Попытка удаления строки.

DELETE FROM v_bet_amount_by_user 
WHERE login = 'aaa';

DELETE FROM v_users_without_patronymic 
WHERE login = 'aaa';

-- Попытка изменения строки.

UPDATE v_bet_amount_by_user 
SET password = 'ytrewq'
WHERE login = 'aaa';

UPDATE v_users_without_patronymic
SET password = 'ytrewq'
WHERE login = 'aaa';

-- Попытка вставки строки.

INSERT INTO v_bet_amount_by_user(login)
VALUES ('bbb');

INSERT INTO v_users_without_patronymic(login, password, last_name, first_name, patronymic, phone_number, date_of_birth)
VALUES ('bbb', '123456', 'Bradley', 'Cole', null, 88008008080, '2000-02-20');


-- 3. Планы запросов к представлениям

EXPLAIN ANALYZE
SELECT last_name, first_name
FROM v_users_without_patronymic;

EXPLAIN ANALYZE
SELECT login
FROM v_bet_amount_by_user
WHERE total_bet_amount > 5000;


-- Удаление тестовых строк.
DELETE FROM users WHERE login = 'aaa' OR login = 'bbb';a

-- Удаление представлений.
DROP VIEW v_users_without_patronymic;
DROP VIEW v_bet_amount_by_user;





















