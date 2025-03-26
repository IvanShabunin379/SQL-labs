-- Создание ролей

-- роль младшего аналитика
CREATE ROLE junior_analyst WITH LOGIN PASSWORD 'junior_analyst';

GRANT SELECT(login, last_name, first_name, patronymic, phone_number, date_of_birth)
ON users
TO junior_analyst;

-- роль старшего аналитика
CREATE ROLE senior_analyst LOGIN PASSWORD 'senior_analyst';

GRANT SELECT(login, last_name, first_name, patronymic, phone_number, date_of_birth)
ON users
TO senior_analyst;

GRANT UPDATE(login, last_name, first_name, patronymic, phone_number, date_of_birth)
ON users
TO senior_analyst;

-- роль менеджера
CREATE ROLE manager WITH LOGIN PASSWORD 'manager';

GRANT SELECT(login, last_name, first_name, patronymic, phone_number, date_of_birth)
ON users
TO manager;

GRANT UPDATE(login, last_name, first_name, patronymic, phone_number, date_of_birth)
ON users
TO manager;

GRANT INSERT
ON users
TO manager
WITH GRANT OPTION;

GRANT USAGE, SELECT
ON SEQUENCE users_id_seq
TO manager
WITH GRANT OPTION;


-- Демонстрация

\du
SELECT session_user, current_user;

INSERT INTO users(login, password, last_name, first_name, patronymic, phone_number, date_of_birth)
VALUES ('@alphabet', 'abc123', 'Алфавитов', 'Алфавит', 'Алфавитович', '+78001234098', '2000-07-31');

-- младший аналитик
SET ROLE junior_analyst;

SELECT login, last_name, first_name, patronymic, phone_number, date_of_birth
FROM users
WHERE login = '@alphabet';

UPDATE users
SET first_name = 'Арчибальд', 
    patronymic = 'Арчибальдович'
WHERE last_name = 'Алфавитов';

RESET ROLE;

-- старший аналитик
SET ROLE senior_analyst;

SELECT login, last_name, first_name, patronymic, phone_number, date_of_birth
FROM users
WHERE login = '@alphabet';

UPDATE users
SET first_name = 'Арчибальд',
	patronymic = 'Арчибальдович'
WHERE last_name = 'Алфавитов';

INSERT INTO users(login, password, last_name, first_name, patronymic, phone_number, date_of_birth)
VALUES ('@fdsa', 'fdsa123', 'Федосеев', 'Фёдор', 'Варфоломеевич', '+79024051728', '1977-11-01');

RESET ROLE;

-- менеджер
SET ROLE manager;

INSERT INTO users(login, password, last_name, first_name, patronymic, phone_number, date_of_birth)
VALUES ('@fdsa', 'fdsa123', 'Федосеев', 'Фёдор', 'Варфоломеевич', '+79024051728', '1977-11-01');

RESET ROLE;


-- Создание групповой роли для доверенных пользователей

SET ROLE senior_analyst;

SELECT password FROM users WHERE last_name = 'Алфавитов';

RESET ROLE;


CREATE ROLE trusted_user WITH LOGIN;
GRANT SELECT(password) ON users TO trusted_user;

GRANT trusted_user TO manager;
GRANT trusted_user TO senior_analyst;


-- Использование WITH GRANT OPTIONS

-- менеджер выдает старшему аналитику привилегию INSERT с GRANT OPTION
SET ROLE manager;

GRANT INSERT
ON users
TO senior_analyst
WITH GRANT OPTION;

GRANT USAGE, SELECT
ON SEQUENCE users_id_seq
TO senior_analyst WITH GRANT OPTION;

RESET ROLE;


-- старший аналитик вставляет данные и выдает младшему аналитику привилегию INSERT с GRANT OPTION
SET ROLE senior_analyst;

INSERT INTO users(login, password, last_name, first_name, patronymic, phone_number, date_of_birth)
VALUES ('@senior', 'sssssss', 'Аналитиков', 'Аналитик', 'Аналитикович', '+77777777777', '1977-07-07');

GRANT INSERT
ON users
TO junior_analyst
WITH GRANT OPTION;

GRANT USAGE, SELECT
ON SEQUENCE users_id_seq
TO junior_analyst
WITH GRANT OPTION;

RESET ROLE;


-- младший аналитик вставляет данные
SET ROLE junior_analyst;

INSERT INTO users(login, password, last_name, first_name, patronymic, phone_number, date_of_birth)
VALUES ('@junior', 'jjjjjjj', 'Юзеров', 'Юзер', 'Юзерович', '+78888888888', '1988-08-08');

RESET ROLE;


-- отнимаем привилегии на вставку у аналитиков
SELECT * FROM users;

REVOKE GRANT OPTION FOR INSERT
ON users
FROM manager
CASCADE;

REVOKE GRANT OPTION FOR USAGE, SELECT
ON SEQUENCE users_id_seq
FROM manager CASCADE;

REVOKE INSERT
ON users
FROM senior_analyst
CASCADE;

REVOKE USAGE, SELECT
ON SEQUENCE users_id_seq
FROM senior_analyst
CASCADE;

DELETE 
FROM users
WHERE login IN ('@alphabet', '@fdsa', '@senior', '@junior');


-- снова пытаемся за менеджера выдать привилегии и за аналитиков вставить данные




-- Демонстрация многоверсионности

GRANT UPDATE, SELECT
ON events_outcomes
TO manager;

GRANT SELECT
ON events_outcomes
TO senior_analyst;


-- изменение коэффициента исхода события менеджером
BEGIN;

SELECT *, xmin, xmax FROM events_outcomes WHERE event_id = 1 AND outcome_id = 1;

UPDATE events_outcomes SET odd = 5.0 WHERE event_id = 1 AND outcome_id = 1;

COMMIT;


-- просмотр информации о данном исходе старшим аналитиком

BEGIN;

SELECT *, xmin, xmax FROM events_outcomes WHERE event_id = 1 AND outcome_id = 1;

COMMIT;



-- Удаление всех ролей

REVOKE ALL PRIVILEGES ON TABLE users FROM junior_analyst;
REVOKE ALL PRIVILEGES ON TABLE users FROM senior_analyst;
REVOKE ALL PRIVILEGES ON TABLE events_outcomes FROM senior_analyst;
REVOKE ALL PRIVILEGES ON TABLE users FROM manager;
REVOKE ALL PRIVILEGES ON SEQUENCE users_id_seq FROM manager;
REVOKE ALL PRIVILEGES ON TABLE events_outcomes FROM manager;
REVOKE ALL PRIVILEGES ON TABLE users FROM trusted_user;

DROP ROLE junior_analyst;
DROP ROLE senior_analyst;
DROP ROLE manager;
DROP ROLE trusted_user;











































