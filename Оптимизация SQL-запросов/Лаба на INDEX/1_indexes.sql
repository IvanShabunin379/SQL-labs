-- 1. Найти количество Ивановых Иванов Ивановичей.
-- 2. Найти 10 (или другую константу) самых пожилых/молодых пользователей.

-- 1. Создание двух копий таблицы user: первая - без созданных мной индексов, вторая - с индексами на ФИО и дату рождения.

CREATE TABLE users_copy (LIKE users INCLUDING ALL);

INSERT INTO users_copy
SELECT *
FROM users;


CREATE TABLE users_copy_with_indexes (LIKE users INCLUDING ALL);

INSERT INTO users_copy_with_indexes
SELECT *
FROM users;	  

CREATE INDEX idx_user_full_name
	ON users_copy_with_indexes(last_name, first_name, patronymic);

CREATE INDEX idx_user_dob
	ON users_copy_with_indexes(date_of_birth);


-- 2. Проверка, используется ли индекс на малых данных.

-- 2.1. Найти количество Ивановых Иванов Ивановичей.

EXPLAIN ANALYZE
SELECT COUNT(*)
FROM users_copy
WHERE last_name = 'Иванов' AND first_name = 'Иван' AND patronymic = 'Иванович';

EXPLAIN ANALYZE
SELECT COUNT(*)
FROM users_copy_with_indexes
WHERE last_name = 'Иванов' AND first_name = 'Иван' AND patronymic = 'Иванович';

-- 2.2. Найти 10 (или другую константу) самых пожилых пользователей.

EXPLAIN ANALYZE
SELECT *
FROM users_copy
ORDER BY date_of_birth
LIMIT 5;

EXPLAIN ANALYZE
SELECT *
FROM users_copy_with_indexes
ORDER BY date_of_birth
LIMIT 5;


EXPLAIN ANALYZE 
SELECT COUNT(*)
FROM users_copy_with_indexes
WHERE EXTRACT(YEAR FROM AGE(date_of_birth)) <= 35;










