-- Создаем копию таблицы users.
CREATE TABLE users_copy (LIKE users INCLUDING ALL);

INSERT INTO users_copy
SELECT *
FROM users;

-- И вставляем в эту копию 1000 строк



-- 1. Создание материализованного представления

CREATE MATERIALIZED VIEW v_bet_amount_by_user
AS
SELECT U.login AS login,
	   SUM(B.amount) AS total_bet_amount
FROM users_copy U LEFT JOIN bets B
	ON U.id = B.user_id
GROUP by U.login;


-- 2. План запроса, по которому построено материализованное представление

EXPLAIN ANALYZE
SELECT U.login AS login,
	   SUM(B.amount) AS total_bet_amount
FROM users_copy U LEFT JOIN bets B
	ON U.id = B.user_id
GROUP by U.login;


-- 3. План запроса к материализованному представлению

EXPLAIN ANALYZE
SELECT * FROM v_bet_amount_by_user


-- 4. Демонстрация REFRESH

-- Вставка данных.
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1054, 'jharbackr', 'wG0)`Zh', 'Harback', 'Niel', 'Jedidiah', '427-696-4101', '1969/12/12');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1055, 'tnorewoodr', 'uA8`XC.Hf', 'Norewood', 'Cal', 'Tam', '891-878-5900', '2000/12/27');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1056, 'ишзщф', 'uA8`XC.Hf', 'Иванов', 'Иван', 'Иванович', '891-878-5169', '2000/12/27');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1057, 'dqqqq', 'bR6(71L', 'Иванов', 'Иван', 'Иванович', '789-270-0609', '1969/08/10');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1058, 'oooaz', 'eE0~gSN', 'Иванов', 'Иван', 'Иванович', '547-425-1658', '1937/06/13');		  
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1060, 'igantzrga', 'dU0{>Hr>I', 'Gantz', 'Bamby', 'Iorgos', '835-751-2999', '1953/01/26');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1061, 'tphippsrha', 'fD6/x(1EDd', 'Phipps', 'Franni', 'Trent', '744-237-6999', '1991/05/01');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1062, 'skleeriaa', 'jU0_$!ZASl', 'Klee', 'Helaina', 'Syman', '229-481-4999', '1972/12/02');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1063, 'swasielraa', 'iH7!##}sb', 'Wasiel', 'Alix', 'Stacee', '749-288-8999', '1988/04/01');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1064, 'tgaskillrka', 'rM2*V`5', 'Gaskill', 'Ravi', 'Tailor', '423-978-4999', '1997/03/01');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1065, 'sgrayhamrla', 'kD8{=<xa{', 'Grayham', 'Sileas', 'Shannan', '256-450-0999', '1948/06/16');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1066, 'sramalhorma', 'tJ2!8*aN', 'Ramalho', 'Berti', 'Sherlocke', '586-462-9999', '1974/05/24');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1067, 'rkubanrna', 'uU5<1z', 'Kuban', 'Rosy', 'Reagan', '694-717-4999', '1975/05/10');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1068, 'aindruchroa', 'bR6(71L', 'Indruch', 'Marty', 'Alfonse', '739-270-0999', '1969/08/10');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1069, 'tpeascodrpa', 'eE0~gSN', 'Peascod', 'Annie', 'Tomaso', '647-425-1999', '1937/06/13');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1070, 'rhyettr1a', 'jV1>|{QXp3', 'Hyett', 'Deeyn', 'Raffaello', '884-199-6999', '1999/09/16');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1071, 'nmacilwrickr2a', 'yJ1.vH', 'MacIlwrick', 'Lemmie', 'Nev', '369-656-9999', '1988/07/23');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1072, 'dnatonr3a', 'rN6|KpjMoGts', 'Naton', 'Bruce', 'Dev', '959-840-4999', '1992/03/09');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1073, 'lbrecknellr4a', 'eT5}5r', 'Brecknell', 'Tillie', 'Lauren', '165-423-7999', '1939/03/24');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1074, 'fpenninor5a', 'cG1$uM', 'Pennino', 'Bevvy', 'Franz', '925-592-5999', '1955/05/26');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1075, 'cfrobisherr6a', 'xV4|9TE81C1z', 'Frobisher', 'Bennie', 'Cross', '925-102-1999', '1973/03/11');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1076, 'eclemonr7a', 'aU6@$j!q#Kqh', 'Clemon', 'Derek', 'Edouard', '202-170-2999', '1962/11/23');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1077, 'chedger8a', 'dW9%qQ&2{*', 'Hedge', 'Gweneth', 'Casar', '573-810-2999', '1937/07/10');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1078, 'mbrattellr9a', 'yX7=`d"g0s', 'Brattell', 'Val', 'Micheil', '350-227-8999', '1986/01/21');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1079, 'alyvenraa', 'bH7''%.Bv\', 'Lyven', 'Ediva', 'Anselm', '706-284-4999', '1938/12/20');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1080, 'ezebedeerba', 'xO5=h~2,x', 'Zebedee', 'Lanny', 'Edmund', '130-136-4999', '1945/03/22');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1081, 'waubreyrca', 'vX6%fU\uV', 'Aubrey', 'Sansone', 'Wakefield', '571-122-0999', '1947/09/03');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1082, 'escamadinerda', 'lO2@ChD9+$L', 'Scamadine', 'Kayla', 'Elliott', '832-250-3999', '2004/06/11');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1083, 'ztutingrea', 'nC5#L9`>V@4q', 'Tuting', 'Janek', 'Zedekiah', '423-329-9999', '1980/01/17');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1084, 'croserfa', 'pL2@.zi', 'Rose', 'Athene', 'Curt', '523-391-6999', '1990/03/31');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1085, 'sbruinsqna', 'gQ2,MV}_`', 'Bruins', 'Sherrie', 'Sheridan', '804-290-6999', '1985/05/29');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1086, 'csambellsqoa', 'zS6$W9oOl', 'Sambells', 'Eberto', 'Corbet', '552-664-0999', '1962/06/30');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1087, 'gbartolomeoqpa', 'yW3@A3uDv8_', 'Bartolomeo', 'Orly', 'Gregorius', '419-887-3999', '1939/08/11');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1088, 'ccorkeqqa', 'kY8\V5\Y6*K', 'Corke', 'Coraline', 'Conroy', '506-232-6999', '1964/08/03');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1089, 'zkilcullenqra', 'kQ4)0j"lzvAr', 'Kilcullen', 'Valerie', 'Zach', '852-169-9999', '1968/08/11');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1090, 'jjeffcockqsa', 'oT9.ny{', 'Jeffcock', 'Clevie', 'Jarrod', '682-130-1999', '1937/05/07');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1091, 'sarnelyqta', 'hY6"h`0Y*%5', 'Arnely', 'Ainsley', 'Stavro', '652-152-3999', '1967/10/12');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1092, 'cgillinghamsqua', 'sI0`ry$oI', 'Gillinghams', 'Burg', 'Clive', '292-845-4999', '1997/07/22');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1093, 'swellsteadqva', 'qL1@(J$TPer=', 'Wellstead', 'Chris', 'Sig', '724-908-3999', '1971/06/02');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1094, 'rboyesqwa', 'iX1''PO', 'Boyes', 'Aileen', 'Reamonn', '408-716-2999', '2001/08/06');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1095, 'cwimpeneyqxa', 'hO6~qF6r\)', 'Wimpeney', 'Daphene', 'Christoper', '631-863-8999', '1938/06/21');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1096, 'evaughtonqya', 'uL1/R/j\', 'Vaughton', 'Rollie', 'Eugenius', '844-435-7999', '1936/01/08');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1097, 'sbricknallqza', 'wH2&gSLZ@332', 'Bricknall', 'Somerset', 'Stanwood', '128-635-0999', '1993/08/29');
insert into users_copy (id, login, password, last_name, first_name, patronymic, phone_number, date_of_birth) values (1098, 'rdrewr0a', 'yT1''P+L', 'Drew', 'Opaline', 'Rockwell', '595-642-1999', '2004/10/19');

-- План запроса к материализованному представлению до REFRESH.
EXPLAIN ANALYZE
SELECT * FROM v_bet_amount_by_user;

-- REFRESH данных материализованного представления.
REFRESH MATERIALIZED VIEW v_bet_amount_by_user;

-- План запроса к материализованному представлению до REFRESH.
EXPLAIN ANALYZE
SELECT * FROM v_bet_amount_by_user;


-- Удаление материализованного представления.
DROP MATERIALIZED VIEW v_bet_amount_by_user

