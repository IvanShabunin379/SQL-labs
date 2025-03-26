--Вставка данных в таблицу "users"

INSERT INTO users(login, password, last_name, first_name, patronymic, phone_number, date_of_birth)
VALUES ('@kapusta', 'carrot123', 'Капуста', 'Степан', 'Степанович', '+79001234567', '2000-07-31'),
	   ('@pup', 'qwerty123', 'Пупкин', 'Василий', 'Васильевич', '+790000000000', '1960-01-01'),
	   ('@ivan', 'iii321', 'Иванов', 'Иван', 'Иванович', '+79011011234', '1985-06-03');

INSERT INTO users(login, password, last_name, first_name, phone_number, date_of_birth)
VALUES ('@milanista', 'ac1234', 'Tonali', 'Sandro', '+39612345678', '2000-05-08'),
	   ('@fullback', 'nw123!?', 'Trippier', 'Kieran', '+44612345678', '1990-09-19');

INSERT INTO users(login, password, last_name, first_name, patronymic, phone_number, date_of_birth)
VALUES ('@vano', 'ivip1900?/', 'Иванов-Вано', 'Иван', 'Петрович', '+79011014321', '1987-03-26'),
	   ('@lyapis', 'gavrila0/?', 'Ляпис-Трубецкой', 'Никифор', 'Никифорович', '+79001230101', '1955-11-09'),
	   ('@papin', 'dumpling?0', 'Папин-Сибиряк', 'Наркис', 'Дмитриевич', '+79001234545', '1952-11-06'),
 	   ('@plez', 'batebor4', 'Плец', 'Пётр', 'Андреевич', '+375170123456', '1989-02-20'),
       ('@stepa''', 'iii321', 'Иванов', 'Иван', 'Степанович', '+79011011244', '2000-06-03'),
       ('@kuzmich''', 'iii321', 'Иванов', 'Иван', 'Кузьмич', '+79011011243', '1990-06-03'),
	   ('@pplez''', 'team:?', 'Плец', 'Павел', 'Андреевич', '+375171233457', '1989-02-20'),
	   ('@spartak', 'team:?', 'Спартак', 'Николай', 'Петрович', '+79021230000', '1952-02-26'),
	   ('@chelsea', '/100team?', 'Челси', 'Роман', 'Аркадьевич', '+79107770000', '1966-10-24');


-- Вставка данных в таблицу "sports"

INSERT INTO sports(name, sport_type)
VALUES ('футбол', 'team'),
	   ('хоккей', 'team'),
	   ('теннис', 'individual'),
	   ('шахматы', 'individual');


-- Вставка данных в таблицу countries

INSERT INTO countries(name)
VALUES ('Россия'),
    ('Украина'),
	   ('США'),
	   ('Аргентина'),
	   ('Франция'),
	   ('Бразилия'),
	   ('Англия'),
	   ('Бельгия'),
	   ('Хорватия'),
	   ('Нидерланды'),
	   ('Италия'),
	   ('Испания'),
	   ('Португалия'),
	   ('Марокко'),
	   ('Швейцария'),
	   ('Германия'),
	   ('Япония'),
	   ('Египет'),
	   ('Саудовская Аравия'),
	   ('Сербия'),
	   ('Греция'),
	   ('Норвегия'),
	   ('Камерун'),
	   ('Канада'),
	   ('Финландия'),
	   ('Швеция'),
	   ('Чехия'),
	   ('Дания');


-- Вставка данных в таблицу "tournaments"

INSERT INTO tournaments(name, sport_id, participant_type)
VALUES ('Чемпионат Мира', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'national team'),
 	   ('Чемпионат Европы',
		(SELECT id FROM sports WHERE name = 'футбол'),
	    'national team'),
	   ('Лига Чемпионов',
		(SELECT id FROM sports WHERE name = 'футбол'),
	    'club'),
		
	   ('Кубок Мира',
		(SELECT id FROM sports WHERE name = 'хоккей'),
	    'national team'),
	   ('КХЛ',
		(SELECT id FROM sports WHERE name = 'хоккей'),
	    'club'),
		
	   ('Кубок Мира',
		(SELECT id FROM sports WHERE name = 'шахматы'),
	    'athlete'),
		
	   ('Australian Open',
		(SELECT id FROM sports WHERE name = 'теннис'),
	    'athlete'),
	   ('US Open',
		(SELECT id FROM sports WHERE name = 'теннис'),
	    'athlete'),
	   ('Wimbledon',
		(SELECT id FROM sports WHERE name = 'теннис'),
	    'athlete'),
	   ('Roland Garros',
		(SELECT id FROM sports WHERE name = 'теннис'),
	    'athlete');

INSERT INTO tournaments(name, sport_id, participant_type, country_id)
VALUES ('Российская премьер-лига',
	    (SELECT id FROM sports WHERE name = 'футбол'),
		'club',
		(SELECT id FROM countries WHERE name = 'Россия')),
	   ('Примера',
	    (SELECT id FROM sports WHERE name = 'футбол'),
		'club',
		(SELECT id FROM countries WHERE name = 'Испания'));
		

-- Вставка данных в таблицу "tournaments_in_seasons"

INSERT INTO tournaments_in_seasons(tournament_id, start_date, end_date)
VALUES ((SELECT id FROM tournaments WHERE name = 'Чемпионат Мира'
		 								AND sport_id = (SELECT id FROM sports WHERE name = 'футбол')),
	    '2022-11-20',
	    '2022-12-17'),
	   ((SELECT id FROM tournaments WHERE name = 'Чемпионат Мира'
		 								AND sport_id = (SELECT id FROM sports WHERE name = 'футбол')),
	    '2018-06-14',
	    '2018-07-15'),
	   ((SELECT id FROM tournaments WHERE name = 'Чемпионат Европы'
		 								AND sport_id = (SELECT id FROM sports WHERE name = 'футбол')),
	    '2021-06-11',
	    '2021-07-11'),
 	   
	   ((SELECT id FROM tournaments WHERE name = 'Лига Чемпионов'),
	    '2018-09-18',
	    '2019-06-01'),
		
		((SELECT id FROM tournaments WHERE name = 'Российская премьер-лига'),
	    '2023-07-21',
	    '2024-05-25'),
	   ((SELECT id FROM tournaments WHERE name = 'Примера'),
	    '2023-08-11',
	    '2024-05-26'),
		
	   ((SELECT id FROM tournaments WHERE name = 'Кубок Мира'
										AND sport_id = (SELECT id FROM sports WHERE name = 'хоккей')),
	    '2016-09-17',
	    '2016-09-29'),
	   ((SELECT id FROM tournaments WHERE name = 'КХЛ'),
	    '2023-09-01',
	    '2024-04-29'),
		
	   ((SELECT id FROM tournaments WHERE name = 'Кубок Мира'
										AND sport_id = (SELECT id FROM sports WHERE name = 'шахматы')),
	    '2023-07-29',
	    '2023-08-25'),
		
	   ((SELECT id FROM tournaments WHERE name = 'Australian Open'),
	    '2023-01-08',
	    '2023-01-29'),
	   ((SELECT id FROM tournaments WHERE name = 'US Open'),
	    '2021-08-24',
	    '2021-09-13'),
	   ((SELECT id FROM tournaments WHERE name = 'US Open'),
	    '2023-08-22',
	    '2023-09-10'),
	   ((SELECT id FROM tournaments WHERE name = 'Roland Garros'),
	    '2022-05-16',
	    '2022-06-05'),
	   ((SELECT id FROM tournaments WHERE name = 'Roland Garros'),
	    '2023-05-22',
	    '2023-06-11'),
	   ((SELECT id FROM tournaments WHERE name = 'Wimbledon'),
	    '2023-06-26',
	    '2023-07-16');
		
		
-- Вставка данных в таблицы "participants" и "participations_in_tournaments"

INSERT INTO participants(name, sport_id, participant_type, country_id)
VALUES ('Россия', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Россия')),
	   ('Саудовская Аравия', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Саудовская Аравия')),
	   ('Египет', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Египет')),
	   ('Португалия', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Португалия')),
	   ('Испания', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Испания')),
	   ('Франция', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Франция')),
	   ('Аргентина', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Аргентина')),
	   ('Хорватия', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Хорватия')),
	   ('Бразилия', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Бразилия')),
	   ('Швеция', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Швеция')),
	   ('Бельгия', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Бельгия')),
	   ('Англия', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Англия')),
	   ('Япония', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Япония')),
	   ('Нидерланды', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Нидерланды')),
	   ('Марокко', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Марокко')),
	   ('Камерун', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Камерун')),
	   ('Италия', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Италия')),
	   ('Дания', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Дания')),
	   ('Украина', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Украина')),
	   ('Германия', 
 		(SELECT id FROM sports WHERE name = 'футбол'),
 		'national team', 
 		(SELECT id FROM countries WHERE name = 'Германия')),
	   ('Швейцария', 
 		(SELECT id FROM sports WHERE name = 'футбол'),
 		'national team', 
 		(SELECT id FROM countries WHERE name = 'Швейцария'));		
 
INSERT INTO participations_in_tournaments(participant_id, tournament_in_season_id)
VALUES ((SELECT id FROM participants WHERE name = 'Россия'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Россия'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Саудовская Аравия'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Саудовская Аравия'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
		),
	   ((SELECT id FROM participants WHERE name = 'Египет'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Португалия'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Португалия'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Португалия'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
		),
	   ((SELECT id FROM participants WHERE name = 'Испания'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Испания'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Испания'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
		),
	   ((SELECT id FROM participants WHERE name = 'Франция'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Франция'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Франция'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
		),
	   ((SELECT id FROM participants WHERE name = 'Аргентина'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Аргентина'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
		),
	   ((SELECT id FROM participants WHERE name = 'Хорватия'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Хорватия'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Хорватия'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
		),
	   ((SELECT id FROM participants WHERE name = 'Бразилия'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Бразилия'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
		),
	   ((SELECT id FROM participants WHERE name = 'Швеция'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Швеция'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Бельгия'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Бельгия'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Бельгия'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
		),
	   ((SELECT id FROM participants WHERE name = 'Англия'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Англия'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Англия'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
		),
	   ((SELECT id FROM participants WHERE name = 'Япония'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Япония'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
		),
	   ((SELECT id FROM participants WHERE name = 'Марокко'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Марокко'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
		),
	   ((SELECT id FROM participants WHERE name = 'Нидерланды'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Нидерланды'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
		),
	   ((SELECT id FROM participants WHERE name = 'Камерун'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
		),
	   ((SELECT id FROM participants WHERE name = 'Италия'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Дания'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Украина'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Германия'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Швейцария'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	   );


INSERT INTO participants(name, sport_id, participant_type, country_id)
VALUES ('Реал Мадрид', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Испания')),
	   ('Барселона', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Испания')),
	   ('Атлетико Мадрид', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Испания')),
	   ('Ливерпуль', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Англия')),
	   ('Манчестер Сити', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Англия')),
	   ('Манчестер Юнайтед', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Англия')),
	   ('Тоттенхэм Хотспур', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Англия')),
	   ('Челси', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Англия')),
	   ('Арсенал', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Англия')),
	   ('Ньюкасл', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Англия')),
	   ('Ювентус', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Италия')),
	   ('Бавария', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Германия')),
	   ('ПСЖ', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Франция')),
	   ('Аякс', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Нидерланды')),
	   ('Факел', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Россия')),
	   ('Краснодар', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Россия')),
	   ('Зенит', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Россия')),
	   ('ЦСКА', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Россия')),
	   ('Динамо Москва', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Россия')),
	   ('Спартак', 
	    (SELECT id FROM sports WHERE name = 'футбол'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Россия'));
			   
INSERT INTO participations_in_tournaments(participant_id, tournament_in_season_id)
VALUES ((SELECT id FROM participants WHERE name = 'Реал Мадрид'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Примера' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Реал Мадрид'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Барселона'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Примера' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Барселона'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Атлетико Мадрид'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Примера' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Атлетико Мадрид'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	   ),	   
	   ((SELECT id FROM participants WHERE name = 'Ливерпуль'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Манчестер Сити'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	   ),	  	   
	   ((SELECT id FROM participants WHERE name = 'Манчестер Юнайтед'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	   ),   
	   ((SELECT id FROM participants WHERE name = 'Тоттенхэм Хотспур'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	   ),	    
	   ((SELECT id FROM participants WHERE name = 'Ювентус'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Бавария'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	   ),
	   ((SELECT id FROM participants WHERE name = 'ПСЖ'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Аякс'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Краснодар'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Российская премьер-лига' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Зенит'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Российская премьер-лига' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	   ),
	   ((SELECT id FROM participants WHERE name = 'ЦСКА'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Российская премьер-лига' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Динамо Москва'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Российская премьер-лига' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Спартак'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Российская премьер-лига' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Факел'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Российская премьер-лига' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	   );


INSERT INTO participants(name, sport_id, participant_type, country_id)	   
VALUES ('Россия', 
	    (SELECT id FROM sports WHERE name = 'хоккей'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Россия')),
	   ('Канада', 
	    (SELECT id FROM sports WHERE name = 'хоккей'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Канада')),
	   ('Финляндия', 
	    (SELECT id FROM sports WHERE name = 'хоккей'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Финляндия')),
	   ('Швеция', 
	    (SELECT id FROM sports WHERE name = 'хоккей'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Швеция')),
	   ('Чехия', 
	    (SELECT id FROM sports WHERE name = 'хоккей'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'Чехия')),
	   ('США', 
	    (SELECT id FROM sports WHERE name = 'хоккей'),
	    'national team', 
	    (SELECT id FROM countries WHERE name = 'США'));   
			   
INSERT INTO participations_in_tournaments(participant_id, tournament_in_season_id)
VALUES ((SELECT id FROM participants WHERE name = 'Россия'
	   									AND sport_id = (SELECT id FROM sports WHERE name = 'хоккей')),
		(SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))
	   ),
	   ((SELECT id FROM participants WHERE name = 'Канада'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))
	   ),	
	   ((SELECT id FROM participants WHERE name = 'Финляндия'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))
	   ),
	   ((SELECT id FROM participants WHERE name = 'Швеция'
	   									AND sport_id = (SELECT id FROM sports WHERE name = 'хоккей')),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))
	   ),
	   ((SELECT id FROM participants WHERE name = 'Чехия'
		 								AND sport_id = (SELECT id FROM sports WHERE name = 'хоккей')),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))
	   ),
	   ((SELECT id FROM participants WHERE name = 'США'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))
	   );
	   
		
INSERT INTO participants(name, sport_id, participant_type, country_id)
VALUES ('ЦСКА', 
	    (SELECT id FROM sports WHERE name = 'хоккей'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Россия')), 
	    ('Динамо Москва', 
	    (SELECT id FROM sports WHERE name = 'хоккей'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Россия')),
	    ('Ак Барс', 
	    (SELECT id FROM sports WHERE name = 'хоккей'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Россия')),
	    ('Авангард', 
	    (SELECT id FROM sports WHERE name = 'хоккей'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Россия')),
	    ('СКА', 
	    (SELECT id FROM sports WHERE name = 'хоккей'),
	    'club', 
	    (SELECT id FROM countries WHERE name = 'Россия'));
		
INSERT INTO participations_in_tournaments(participant_id, tournament_in_season_id)
VALUES ((SELECT id FROM participants WHERE name = 'ЦСКА'
	   									AND sport_id = (SELECT id FROM sports WHERE name = 'хоккей')),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'КХЛ' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
 	   ),
	   ((SELECT id FROM participants WHERE name = 'Динамо Москва'
	   									AND sport_id = (SELECT id FROM sports WHERE name = 'хоккей')),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'КХЛ' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
 	   ),
	   ((SELECT id FROM participants WHERE name = 'Ак Барс'),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'КХЛ' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
 	   ),
	   ((SELECT id FROM participants WHERE name = 'Авангард'),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'КХЛ' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
 	   ),
	   ((SELECT id FROM participants WHERE name = 'СКА'),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'КХЛ' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
 	   );
	   
		
INSERT INTO participants(name, sport_id, participant_type, country_id)
VALUES ('Магнус Карлсен', 
	    (SELECT id FROM sports WHERE name = 'шахматы'),
	    'athlete', 
	    (SELECT id FROM countries WHERE name = 'Норвегия')),
	   ('Ян Непомнящий', 
	    (SELECT id FROM sports WHERE name = 'шахматы'),
	    'athlete', 
	    (SELECT id FROM countries WHERE name = 'Россия')),
	   ('Алиреза Фируджа', 
	    (SELECT id FROM sports WHERE name = 'шахматы'),
	    'athlete', 
	    (SELECT id FROM countries WHERE name = 'Франция')),
	   ('Хикару Накамура', 
	    (SELECT id FROM sports WHERE name = 'шахматы'),
	    'athlete', 
	    (SELECT id FROM countries WHERE name = 'США')),
	   ('Василий Иванчук', 
	    (SELECT id FROM sports WHERE name = 'шахматы'),
	    'athlete', 
	    (SELECT id FROM countries WHERE name = 'Украина'));
		
INSERT INTO participations_in_tournaments(participant_id, tournament_in_season_id)
VALUES ((SELECT id FROM participants WHERE name = 'Магнус Карлсен'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'шахматы'))
	   ),
	   ((SELECT id FROM participants WHERE name = 'Василий Иванчук'),
	    (SELECT TIS.id 
		 FROM tournaments_in_seasons AS TIS 
		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
	   	 WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'шахматы'))
	   );
	   
		
INSERT INTO participants(name, sport_id, participant_type, country_id)
VALUES ('Новак Джокович', 
	    (SELECT id FROM sports WHERE name = 'теннис'),
	    'athlete', 
	    (SELECT id FROM countries WHERE name = 'Сербия')),
	   ('Рафаэль Надаль', 
	    (SELECT id FROM sports WHERE name = 'теннис'),
	    'athlete', 
	    (SELECT id FROM countries WHERE name = 'Испания')),
	   ('Карлос Алькарас', 
	    (SELECT id FROM sports WHERE name = 'теннис'),
	    'athlete', 
	    (SELECT id FROM countries WHERE name = 'Испания')),
	   ('Даниил Медведев', 
	    (SELECT id FROM sports WHERE name = 'теннис'),
	    'athlete', 
	    (SELECT id FROM countries WHERE name = 'Россия')),
	   ('Андрей Рублёв', 
	    (SELECT id FROM sports WHERE name = 'теннис'),
	    'athlete', 
	    (SELECT id FROM countries WHERE name = 'Россия')),
	   ('Стефанос Циципас', 
	    (SELECT id FROM sports WHERE name = 'теннис'),
	    'athlete', 
	    (SELECT id FROM countries WHERE name = 'Греция'));		
		
INSERT INTO participations_in_tournaments(participant_id, tournament_in_season_id)
VALUES ((SELECT id FROM participants WHERE name = 'Новак Джокович'),
	   (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Australian Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
 	   ),
	   ((SELECT id FROM participants WHERE name = 'Стефанос Циципас'),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Australian Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
 	   ),
	   ((SELECT id FROM participants WHERE name = 'Андрей Рублёв'),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Australian Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
 	   ),	
	   ((SELECT id FROM participants WHERE name = 'Даниил Медведев'),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'US Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2021)
 	   ),
	   ((SELECT id FROM participants WHERE name = 'Новак Джокович'),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'US Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2021)
 	   ),
	   ((SELECT id FROM participants WHERE name = 'Новак Джокович'),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'US Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
 	   ),
	   ((SELECT id FROM participants WHERE name = 'Даниил Медведев'),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'US Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
 	   ),
	   ((SELECT id FROM participants WHERE name = 'Карлос Алькарас'),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'US Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
 	   ),
	  ((SELECT id FROM participants WHERE name = 'Андрей Рублёв'),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'US Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
 	   ),
	  ((SELECT id FROM participants WHERE name = 'Карлос Алькарас'),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Wimbledon' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
 	   ),
	   ((SELECT id FROM participants WHERE name = 'Новак Джокович'),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Wimbledon' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
 	   ),
	   ((SELECT id FROM participants WHERE name = 'Даниил Медведев'),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Wimbledon' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
 	   ),
	   ((SELECT id FROM participants WHERE name = 'Андрей Рублёв'),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Wimbledon' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
 	   ),
	   ((SELECT id FROM participants WHERE name = 'Рафаэль Надаль'),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Roland Garros' AND EXTRACT(YEAR FROM TIS.end_date) = 2022)
 	   ),	
	   ((SELECT id FROM participants WHERE name = 'Новак Джокович'),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Roland Garros' AND EXTRACT(YEAR FROM TIS.end_date) = 2022)
	   ),
	   ((SELECT id FROM participants WHERE name = 'Новак Джокович'),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Roland Garros' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
 	   ),	
	   ((SELECT id FROM participants WHERE name = 'Карлос Алькарас'),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Roland Garros' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
 	   ),	
	   ((SELECT id FROM participants WHERE name = 'Стефанос Циципас'),
	    (SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Roland Garros' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
 	   );
		


-- Вставка данных в таблицу "events"
		
INSERT INTO events(tournament_id, first_participant_id, second_participant_id, start_time, end_time)
VALUES ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022),
	    (SELECT id FROM participants WHERE name = 'Германия'),
	    (SELECT id FROM participants WHERE name = 'Япония'),
	    TIMESTAMP '2022-11-23 16:00:00',
	    TIMESTAMP '2022-11-23 18:00:00'
	   ),
	   ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022),
	    (SELECT id FROM participants WHERE name = 'Япония'),
	    (SELECT id FROM participants WHERE name = 'Испания'),
	    TIMESTAMP '2022-12-01 22:00:00',
	    TIMESTAMP '2022-12-01 23:50:00'
	   ),
	   ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022),
	    (SELECT id FROM participants WHERE name = 'Португалия'),
	    (SELECT id FROM participants WHERE name = 'Швейцария'),
	    TIMESTAMP '2022-12-06 22:00:00',
	    TIMESTAMP '2022-12-06 23:50:00'
	   ),
	   ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022),
	    (SELECT id FROM participants WHERE name = 'Марокко'),
	    (SELECT id FROM participants WHERE name = 'Португалия'),
	    TIMESTAMP '2022-12-10 18:00:00',
	    TIMESTAMP '2022-12-10 20:00:00'
	   ),
	   ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022),
	    (SELECT id FROM participants WHERE name = 'Аргентина'),
	    (SELECT id FROM participants WHERE name = 'Хорватия'),
	    TIMESTAMP '2022-12-13 22:00:00',
	    TIMESTAMP '2022-12-13 23:50:00'
	   ),
	   ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022),
	    (SELECT id FROM participants WHERE name = 'Франция'),
	    (SELECT id FROM participants WHERE name = 'Марокко'),
	    TIMESTAMP '2022-12-14 22:00:00',
	    TIMESTAMP '2022-12-14 23:50:00'
	   ),
	   ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022),
	    (SELECT id FROM participants WHERE name = 'Хорватия'),
	    (SELECT id FROM participants WHERE name = 'Марокко'),
	    TIMESTAMP '2022-12-17 18:00:00',
	    TIMESTAMP '2022-12-17 20:00:00'
	   );

INSERT INTO events(tournament_id, first_participant_id, second_participant_id, start_time, end_time)
VALUES ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018),
	    (SELECT id FROM participants WHERE name = 'Россия'
	   									AND sport_id = (SELECT id FROM sports WHERE name = 'футбол')),
	    (SELECT id FROM participants WHERE name = 'Саудовская Аравия'),
	    TIMESTAMP '2018-06-14 18:00:00',
	    TIMESTAMP '2018-06-14 20:00:00'
	   ),
	   ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018),
	    (SELECT id FROM participants WHERE name = 'Россия'
	   									AND sport_id = (SELECT id FROM sports WHERE name = 'футбол')),
	    (SELECT id FROM participants WHERE name = 'Египет'),
	    TIMESTAMP '2018-06-19 21:00:00',
	    TIMESTAMP '2018-06-19 23:00:00'
	   ),
	   ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018),
	    (SELECT id FROM participants WHERE name = 'Саудовская Аравия'),
	    (SELECT id FROM participants WHERE name = 'Египет'),
	    TIMESTAMP '2018-06-25 17:00:00',
	    TIMESTAMP '2018-06-25 19:00:00'
	   ),
	   ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018),
	    (SELECT id FROM participants WHERE name = 'Бельгия'),
	    (SELECT id FROM participants WHERE name = 'Япония'),
	    TIMESTAMP '2018-07-02 21:00:00',
	    TIMESTAMP '2018-07-02 23:00:00'
	   ),
	   ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018),
	    (SELECT id FROM participants WHERE name = 'Бразилия'),
	    (SELECT id FROM participants WHERE name = 'Бельгия'),
	    TIMESTAMP '2018-07-06 21:00:00',
	    TIMESTAMP '2018-07-06 23:00:00'
	   ),
	   ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 		 WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018),
	    (SELECT id FROM participants WHERE name = 'Франция'),
	    (SELECT id FROM participants WHERE name = 'Хорватия'),
	    TIMESTAMP '2018-07-15 18:00:00',
	    TIMESTAMP '2018-07-15 20:00:00'
	   );
		
INSERT INTO events(tournament_id, first_participant_id, second_participant_id, start_time, end_time)		
VALUES ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 		 WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021),
	    (SELECT id FROM participants WHERE name = 'Бельгия'),
	    (SELECT id FROM participants WHERE name = 'Россия'
	   									AND sport_id = (SELECT id FROM sports WHERE name = 'футбол')),
	    TIMESTAMP '2021-06-12 22:00:00',
	    TIMESTAMP '2021-06-13 00:00:00'
	   ),
	   ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 		 WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021),
	    (SELECT id FROM participants WHERE name = 'Швеция'
	   									AND sport_id = (SELECT id FROM sports WHERE name = 'футбол')),
	    (SELECT id FROM participants WHERE name = 'Украина'),
	    TIMESTAMP '2021-06-29 22:00:00',
	    TIMESTAMP '2021-06-30 00:00:00'
	   ),

	   ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 		 WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021),
	    (SELECT id FROM participants WHERE name = 'Бельгия'),
	    (SELECT id FROM participants WHERE name = 'Италия'),
	    TIMESTAMP '2021-07-02 22:00:00',
	    TIMESTAMP '2021-07-03 00:00:00'
	   );		
		
INSERT INTO events(tournament_id, first_participant_id, second_participant_id, start_time, end_time)
VALUES ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019),
	    (SELECT id FROM participants WHERE name = 'Реал Мадрид'),
	    (SELECT id FROM participants WHERE name = 'Аякс'),
	    TIMESTAMP '2019-03-05 23:00:00',
	    TIMESTAMP '2019-03-06 01:00:00'
	   ),
	   ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019),
	    (SELECT id FROM participants WHERE name = 'Барселона'),
	    (SELECT id FROM participants WHERE name = 'Ливерпуль'),
	    TIMESTAMP '2019-05-01 22:00:00',
	    TIMESTAMP '2019-05-07 23:50:00'
	   ),
	   ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019),
	    (SELECT id FROM participants WHERE name = 'Ливерпуль'),
	    (SELECT id FROM participants WHERE name = 'Барселона'),
	    TIMESTAMP '2019-05-05 22:00:00',
	    TIMESTAMP '2019-05-07 23:50:00'
	   ),
	   ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019),
	    (SELECT id FROM participants WHERE name = 'Аякс'),
	    (SELECT id FROM participants WHERE name = 'Тоттенхэм Хотспур'),
	    TIMESTAMP '2019-05-08 22:00:00',
	    TIMESTAMP '2019-05-08 23:50:00'
	   );		
		
INSERT INTO events(tournament_id, first_participant_id, second_participant_id, start_time, end_time)
VALUES ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Российская премьер-лига' AND EXTRACT(YEAR FROM TIS.end_date) = 2024),
	    (SELECT id FROM participants WHERE name = 'Зенит'),
	    (SELECT id FROM participants WHERE name = 'Динамо Москва'
	   									AND sport_id = (SELECT id FROM sports WHERE name = 'футбол')),
	    TIMESTAMP '2023-08-06 18:00:00',
	    TIMESTAMP '2023-08-06 20:00:00'
	   ),
	   ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Российская премьер-лига' AND EXTRACT(YEAR FROM TIS.end_date) = 2024),
	    (SELECT id FROM participants WHERE name = 'Факел'),
	    (SELECT id FROM participants WHERE name = 'Спартак'),
	    TIMESTAMP '2023-10-28 14:00:00',
	    TIMESTAMP '2023-10-28 16:00:00'
	   );

INSERT INTO events(tournament_id, first_participant_id, second_participant_id, start_time, end_time)
VALUES ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Примера' AND EXTRACT(YEAR FROM TIS.end_date) = 2024),
	    (SELECT id FROM participants WHERE name = 'Атлетико Мадрид'),
	    (SELECT id FROM participants WHERE name = 'Реал Мадрид'),
	    TIMESTAMP '2023-09-24 22:00:00',
	    TIMESTAMP '2023-09-24 23:50:00'
	   ),
	   ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Примера' AND EXTRACT(YEAR FROM TIS.end_date) = 2024),
	    (SELECT id FROM participants WHERE name = 'Реал Мадрид'),
	    (SELECT id FROM participants WHERE name = 'Барселона'),
	    TIMESTAMP '2023-10-28 22:00:00',
	    TIMESTAMP '2023-10-28 23:50:00'
	   );	
		
		
INSERT INTO events(tournament_id, first_participant_id, second_participant_id, start_time, end_time)
VALUES ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'шахматы')),
	    (SELECT id FROM participants WHERE name = 'Магнус Карлсен'),
	    (SELECT id FROM participants WHERE name = 'Василий Иванчук'),
	    TIMESTAMP '2023-08-12 14:00:00',
	    TIMESTAMP '2023-08-12 18:00:00'
	   ),
	   ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'шахматы')),
	     (SELECT id FROM participants WHERE name = 'Магнус Карлсен'),
	     (SELECT id FROM participants WHERE name = 'Василий Иванчук'),
	     TIMESTAMP '2023-08-13 14:00:00',
	     TIMESTAMP '2023-08-13 17:00:00'
	   );
		
INSERT INTO events(tournament_id, first_participant_id, second_participant_id, start_time, end_time)
VALUES ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'хоккей')),
	    (SELECT id FROM participants WHERE name = 'Россия'
	   									AND sport_id = (SELECT id FROM sports WHERE name = 'хоккей')),
	    (SELECT id FROM participants WHERE name = 'Финляндия'),
	    TIMESTAMP '2016-09-22 15:00:00',
	    TIMESTAMP '2016-09-22 17:00:00'
	   ),
	   ((SELECT TIS.id 
  		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'хоккей')),
	    (SELECT id FROM participants WHERE name = 'Чехия'
	   									AND sport_id = (SELECT id FROM sports WHERE name = 'хоккей')),
	    (SELECT id FROM participants WHERE name = 'США'),
	    TIMESTAMP '2016-09-22 20:00:00',
	    TIMESTAMP '2016-09-22 22:00:00'
	   ),
	   ((SELECT TIS.id 
 		 FROM tournaments_in_seasons AS TIS 
 		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
 	   	 WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'хоккей')),
	    (SELECT id FROM participants WHERE name = 'Канада'),
	    (SELECT id FROM participants WHERE name = 'Россия'
	   									AND sport_id = (SELECT id FROM sports WHERE name = 'хоккей')),
	    TIMESTAMP '2016-09-24 19:00:00',
	    TIMESTAMP '2016-09-24 21:00:00');
		
INSERT INTO events(tournament_id, first_participant_id, second_participant_id, start_time, end_time)
VALUES ((SELECT TIS.id 
  		 FROM tournaments_in_seasons AS TIS 
  		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 WHERE TN.name = 'КХЛ' AND EXTRACT(YEAR FROM TIS.end_date) = 2024),
	    (SELECT id FROM participants WHERE name = 'Ак Барс'),	   							
	    (SELECT id FROM participants WHERE name = 'ЦСКА'
	   									AND sport_id = (SELECT id FROM sports WHERE name = 'хоккей')),
	    TIMESTAMP '2023-10-22 19:00:00',
	    TIMESTAMP '2023-10-22 21:00:00'
	   ),
	   ((SELECT TIS.id 
  		 FROM tournaments_in_seasons AS TIS 
  		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 WHERE TN.name = 'КХЛ' AND EXTRACT(YEAR FROM TIS.end_date) = 2024),
	    (SELECT id FROM participants WHERE name = 'СКА'),	   							
	    (SELECT id FROM participants WHERE name = 'Ак Барс'),
	    TIMESTAMP '2023-10-31 19:00:00',
	    TIMESTAMP '2023-10-31 21:00:00'
	   );
		
INSERT INTO events(tournament_id, first_participant_id, second_participant_id, start_time, end_time)
VALUES ((SELECT TIS.id 
  		 FROM tournaments_in_seasons AS TIS 
  		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 WHERE TN.name = 'Australian Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2023),
	    (SELECT id FROM participants WHERE name = 'Стефанос Циципас'),	   							
	    (SELECT id FROM participants WHERE name = 'Новак Джокович'),
	    TIMESTAMP '2023-01-29 21:00:00',
	    TIMESTAMP '2023-01-29 23:50:00'
	   ),
	   ((SELECT TIS.id 
  		 FROM tournaments_in_seasons AS TIS 
  		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 WHERE TN.name = 'Australian Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2023),
	    (SELECT id FROM participants WHERE name = 'Андрей Рублёв'),	   							
	    (SELECT id FROM participants WHERE name = 'Новак Джокович'),
	    TIMESTAMP '2023-01-25 21:00:00',
	    TIMESTAMP '2023-01-25 23:50:00'
	   ),
	   ((SELECT TIS.id 
  		 FROM tournaments_in_seasons AS TIS 
  		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 WHERE TN.name = 'US Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2021),				
	    (SELECT id FROM participants WHERE name = 'Новак Джокович'),
	    (SELECT id FROM participants WHERE name = 'Даниил Медведев'),
	    TIMESTAMP '2023-09-10 21:00:00',
	    TIMESTAMP '2023-09-10 23:50:00'),
	   ((SELECT TIS.id 
  		 FROM tournaments_in_seasons AS TIS 
  		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 WHERE TN.name = 'US Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2023),	
	   (SELECT id FROM participants WHERE name = 'Даниил Медведев'),	   							
	   (SELECT id FROM participants WHERE name = 'Новак Джокович'),
	   TIMESTAMP '2023-09-10 21:00:00',
	   TIMESTAMP '2023-09-10 23:50:00'
	   ),
	   ((SELECT TIS.id 
  		 FROM tournaments_in_seasons AS TIS 
  		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 WHERE TN.name = 'US Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2023),	
	    (SELECT id FROM participants WHERE name = 'Карлос Алькарас'),	   							
	    (SELECT id FROM participants WHERE name = 'Даниил Медведев'),
	    TIMESTAMP '2023-09-09 21:00:00',
	    TIMESTAMP '2023-09-09 23:50:00'
	   ),
	   ((SELECT TIS.id 
  		 FROM tournaments_in_seasons AS TIS 
  		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 WHERE TN.name = 'Wimbledon' AND EXTRACT(YEAR FROM TIS.end_date) = 2023),	
	    (SELECT id FROM participants WHERE name = 'Карлос Алькарас'),	   							
	    (SELECT id FROM participants WHERE name = 'Новак Джокович'),
	    TIMESTAMP '2023-07-16 21:00:00',
	    TIMESTAMP '2023-07-16 23:50:00'
	   ),
	   ((SELECT TIS.id 
  		 FROM tournaments_in_seasons AS TIS 
  		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 WHERE TN.name = 'Roland Garros' AND EXTRACT(YEAR FROM TIS.end_date) = 2022),						
	    (SELECT id FROM participants WHERE name = 'Новак Джокович'),
	    (SELECT id FROM participants WHERE name = 'Рафаэль Надаль'),
	    TIMESTAMP '2022-05-31 21:00:00',
	    TIMESTAMP '2022-05-31 23:50:00'
	   ),
	   ((SELECT TIS.id 
  		 FROM tournaments_in_seasons AS TIS 
  		 JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 WHERE TN.name = 'Roland Garros' AND EXTRACT(YEAR FROM TIS.end_date) = 2023),
	    (SELECT id FROM participants WHERE name = 'Карлос Алькарас'),	   							
	    (SELECT id FROM participants WHERE name = 'Новак Джокович'),
	    TIMESTAMP '2023-06-09 21:00:00',
	    TIMESTAMP '2023-06-09 23:50:00'
	   );		



-- Вставка данных в таблицы "outcomes" и "event_outcomes"
		
INSERT INTO outcomes(name, description)
VALUES ('П1', 'победа первого участника'),
	   ('X', 'ничья'),
	   ('П2', 'победа второго участника');
		
		
INSERT INTO event_outcomes(event_id, outcome_id, odd, occured)
VALUES ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Германия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Япония')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		1.3,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Германия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Япония')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		5.5,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Германия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Япония')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		8.5,
		TRUE),
		
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Япония')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Испания')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		8.5,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Япония')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Испания')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		5.5,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Япония')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Испания')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		1.3,
		FALSE),

	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Португалия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Швейцария')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		2.0,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Португалия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Швейцария')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		3.7,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Португалия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Швейцария')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		3.4,
		FALSE),

	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Марокко')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Португалия')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		4.3,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Марокко')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Португалия')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		4.1,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Марокко')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Португалия')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		1.7,
		FALSE),
		
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Франция')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Марокко')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		1.5,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Франция')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Марокко')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		4.6,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Франция')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Марокко')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		6.4,
		FALSE),
		
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Аргентина')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Хорватия')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		1.7,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Аргентина')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Хорватия')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		4.1,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Аргентина')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Хорватия')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		4.8,
		FALSE),

	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
			AND first_participant_id = (SELECT id FROM participants WHERE name = 'Хорватия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Марокко')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		2.5,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Хорватия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Марокко')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		2.5,
		FALSE),
   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Хорватия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Марокко')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		3.7,
		FALSE);
	
INSERT INTO event_outcomes(event_id, outcome_id, odd, occured)
VALUES ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Россия'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Саудовская Аравия')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		1.5,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Россия'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Саудовская Аравия')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		4.6,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Россия'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Саудовская Аравия')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		6.4,
		FALSE),
		
	  ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Россия'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Египет')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		2.0,
		TRUE),
	   ((SELECT id FROM events
		WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Россия'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Египет')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		3.7,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Россия'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Египет')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		3.4,
		FALSE),
		
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Саудовская Аравия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Египет')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		3.4,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Саудовская Аравия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Египет')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		3.7,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Саудовская Аравия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Египет')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		2.0,
		FALSE),
		
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Бельгия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Япония')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		1.3,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Бельгия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Япония')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		5.5,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Бельгия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Япония')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		8.5,
		FALSE),
		
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Бразилия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Бельгия')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		2.5,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Бразилия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Бельгия')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		3.7,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Бразилия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Бельгия')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		2.5,
		TRUE),
		
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Франция')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Хорватия')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		2.0,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Франция')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Хорватия')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		3.7,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Франция')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Хорватия')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		3.4,
		FALSE);
		
INSERT INTO event_outcomes(event_id, outcome_id, odd, occured)
VALUES ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Бельгия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Россия'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		1.5,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Бельгия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Россия'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))),
		(SELECT id FROM outcomes WHERE name = 'X'),
		4.6,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Бельгия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Россия'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		6.4,
		FALSE),

	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Швеция'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Украина')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		2.5,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Швеция'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Украина')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		3.7,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Швеция'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Украина')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		2.5,
		TRUE),
	   
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Бельгия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Италия')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		2.5,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Бельгия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Италия')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		3.7,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Бельгия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Италия')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		2.5,
		TRUE);
	  
	 
INSERT INTO event_outcomes(event_id, outcome_id, odd, occured)
VALUES ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Аякс')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Тоттенхэм Хотспур')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		2.5,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Аякс')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Тоттенхэм Хотспур')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		3.7,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Аякс')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Тоттенхэм Хотспур')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		2.5,
		TRUE),

	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Барселона')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Ливерпуль')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		2.5,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Барселона')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Ливерпуль')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		3.7,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Барселона')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Ливерпуль')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		2.5,
		FALSE),
	   
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Ливерпуль')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Барселона')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		2.5,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Ливерпуль')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Барселона')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		3.7,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Ливерпуль')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Барселона')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		2.5,
		FALSE),
	   
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Реал Мадрид')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Аякс')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		1.3,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Реал Мадрид')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Аякс')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		5.5,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Реал Мадрид')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Аякс')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		8.5,
		TRUE);	   

INSERT INTO event_outcomes(event_id, outcome_id, odd, occured)
VALUES ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Российская премьер-лига' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Зенит')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Динамо Москва'
									 								AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		1.5,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Российская премьер-лига' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Зенит')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Динамо Москва'
									 								AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))),
		(SELECT id FROM outcomes WHERE name = 'X'),
		4.6,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Российская премьер-лига' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Зенит')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Динамо Москва'
									 								AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		6.4,
		TRUE),
	   
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Российская премьер-лига' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Факел')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Спартак')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		8.5,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Российская премьер-лига' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Факел')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Спартак')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		5.5,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Российская премьер-лига' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Факел')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Спартак')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		1.3,
		FALSE);
	   
INSERT INTO event_outcomes(event_id, outcome_id, odd, occured)
VALUES ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Примера' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Атлетико Мадрид')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Реал Мадрид')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		3.4,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Примера' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Атлетико Мадрид')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Реал Мадрид')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		3.7,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Примера' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Атлетико Мадрид')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Реал Мадрид')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		2.0,
		FALSE),
	   
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Примера' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Реал Мадрид')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Барселона')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		2.0,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Примера' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Реал Мадрид')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Барселона')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		3.7,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Примера' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Реал Мадрид')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Барселона')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		2.7,
		FALSE);
	   
	   
INSERT INTO event_outcomes(event_id, outcome_id, odd, occured)
VALUES ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'шахматы'))
			AND EXTRACT(DAY FROM start_time) = 12
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Магнус Карлсен')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Василий Иванчук')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		1.2,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'шахматы'))
			AND EXTRACT(DAY FROM start_time) = 12
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Магнус Карлсен')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Василий Иванчук')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		3.5,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'шахматы'))
			AND EXTRACT(DAY FROM start_time) = 12
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Магнус Карлсен')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Василий Иванчук')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		15.0,
		FALSE),
	   
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'шахматы'))
			AND EXTRACT(DAY FROM start_time) = 13
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Магнус Карлсен')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Василий Иванчук')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		1.2,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'шахматы'))
			AND EXTRACT(DAY FROM start_time) = 13
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Магнус Карлсен')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Василий Иванчук')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		3.5,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'шахматы'))
			AND EXTRACT(DAY FROM start_time) = 13
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Магнус Карлсен')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Василий Иванчук')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		15.0,
		FALSE);
	   
INSERT INTO event_outcomes(event_id, outcome_id, odd, occured)
VALUES ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Чехия'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'США')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		2.2,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Чехия'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'США')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		1.6,
		FALSE),

	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Россия'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Финляндия')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		1.6,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Россия'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Финляндия')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		2.2,
		FALSE),

	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Канада')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Россия'
									 								AND sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		1.7,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Канада')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Россия'
									 								AND sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		2.1,
		FALSE);
	  
INSERT INTO event_outcomes(event_id, outcome_id, odd, occured)
VALUES ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'КХЛ' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Ак Барс')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'ЦСКА'
									 								AND sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		1.7,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'КХЛ' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Ак Барс')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'ЦСКА'
									 								AND sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		2.1,
		FALSE),
	   
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'КХЛ' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'СКА')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Ак Барс')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		1.8,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'КХЛ' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'СКА')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Ак Барс')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		2.0,
		TRUE);
	
INSERT INTO event_outcomes(event_id, outcome_id, odd, occured)
VALUES ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Australian Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Стефанос Циципас')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Новак Джокович')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		4.0,
		FALSE),	   
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Australian Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Стефанос Циципас')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Новак Джокович')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		1.2,
		TRUE),
	
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Australian Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Андрей Рублёв')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Новак Джокович')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		5.0,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Australian Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Андрей Рублёв')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Новак Джокович')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		1.1,
		TRUE),
	   
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'US Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2021)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Новак Джокович')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Даниил Медведев')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		1.3,
		FALSE),   
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'US Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2021)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Новак Джокович')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Даниил Медведев')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		2.7,
		TRUE),
	   
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'US Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Даниил Медведев')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Новак Джокович')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		2.7,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'US Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Даниил Медведев')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Новак Джокович')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		1.3,
		TRUE),
	   
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'US Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Карлос Алькарас')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Даниил Медведев')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		1.1,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'US Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Карлос Алькарас')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Даниил Медведев')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		5.0,
		TRUE),
	   
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Wimbledon' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Карлос Алькарас')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Новак Джокович')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		2.0,
		TRUE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Wimbledon' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Карлос Алькарас')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Новак Джокович')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		1.7,
		FALSE),
	   
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Roland Garros' AND EXTRACT(YEAR FROM TIS.end_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Новак Джокович')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Рафаэль Надаль')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		1.8,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Roland Garros' AND EXTRACT(YEAR FROM TIS.end_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Новак Джокович')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Рафаэль Надаль')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		2.0,
		TRUE),
	   
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Roland Garros' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Карлос Алькарас')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Новак Джокович')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		2.0,
		FALSE),
	   ((SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Roland Garros' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Карлос Алькарас')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Новак Джокович')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		1.8,
		TRUE);



-- Вставка данных в таблицу "bets"

INSERT INTO bets(user_id, event_id, outcome_id, bet_timestamp, odd, amount)
VALUES ((SELECT id FROM users WHERE login = '@fullback'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Япония')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Испания')),
 		(SELECT id FROM outcomes WHERE name = 'П2'),
		TIMESTAMP '2022-11-30 22:00:00',
		1.3,
		2000
	   ),
	   ((SELECT id FROM users WHERE login = '@fullback'),
	    (SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Россия'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Саудовская Аравия')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2018-06-10 22:00:00',
		1.5,
		5000
	   ),
	   ((SELECT id FROM users WHERE login = '@fullback'),
	    (SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Швеция'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Украина')),
		(SELECT id FROM outcomes WHERE name = 'X'),
		TIMESTAMP '2021-06-29 22:00:00',
		3.7,
		900
	   ),
	   ((SELECT id FROM users WHERE login = '@fullback'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Аякс')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Тоттенхэм Хотспур')),
 		(SELECT id FROM outcomes WHERE name = 'П2'),
		TIMESTAMP '2019-05-01 21:00:00',
		2.5,
		1000000
	   ),
	   ((SELECT id FROM users WHERE login = '@fullback'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Примера' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Атлетико Мадрид')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Реал Мадрид')),
 		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2023-09-23 21:00:00',
		3.4,
		100000
	   ),
	   ((SELECT id FROM users WHERE login = '@fullback'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Российская премьер-лига' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Факел')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Спартак')),
 		(SELECT id FROM outcomes WHERE name = 'П2'),
		TIMESTAMP '2023-10-27 21:00:00',
		1.3,
		800
	   ),
	   ((SELECT id FROM users WHERE login = '@fullback'),
		(SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   	   	 						WHERE TN.name = 'КХЛ' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Ак Барс')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'ЦСКА'
 									 								AND sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))),
 		(SELECT id FROM outcomes WHERE name = 'П2'),
		TIMESTAMP '2023-10-22 17:00:00',
		2.1,
		9000
	   ),
	   ((SELECT id FROM users WHERE login = '@fullback'),
		(SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   	   	 						WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Чехия'
 																	AND sport_id = (SELECT id FROM sports WHERE name = 'хоккей'))
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'США')),
 		(SELECT id FROM outcomes WHERE name = 'П2'),
		TIMESTAMP '2016-09-20 21:00:00',
		1.6,
		50000
	   ),
	   ((SELECT id FROM users WHERE login = '@fullback'),
		(SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Кубок Мира' AND TN.sport_id = (SELECT id FROM sports WHERE name = 'шахматы'))
			AND EXTRACT(DAY FROM start_time) = 13
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Магнус Карлсен')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Василий Иванчук')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		TIMESTAMP '2023-08-11 21:00:00',
		1.1,
		50000
	   ),
	   ((SELECT id FROM users WHERE login = '@fullback'),
		(SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Australian Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Стефанос Циципас')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Новак Джокович')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		TIMESTAMP '2023-01-29 21:00:00',
		1.2,
		50000
	   ),
	   ((SELECT id FROM users WHERE login = '@fullback'),
		(SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'US Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2021)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Новак Джокович')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Даниил Медведев')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2021-09-11 22:00:00',
		1.3,
		100000
	   ),
	   ((SELECT id FROM users WHERE login = '@fullback'),
		(SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'US Open' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Карлос Алькарас')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Даниил Медведев')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2023-09-09 20:00:00',
		1.1,
		25000
	   ),
	   ((SELECT id FROM users WHERE login = '@fullback'),
		(SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Wimbledon' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Карлос Алькарас')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Новак Джокович')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		TIMESTAMP '2023-07-16 20:00:00',
		1.7,
		200000
	   ),
	   ((SELECT id FROM users WHERE login = '@fullback'),
		(SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Roland Garros' AND EXTRACT(YEAR FROM TIS.end_date) = 2022)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Новак Джокович')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Рафаэль Надаль')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		TIMESTAMP '2022-05-31 20:00:00',
		1.7,
		25000
	   ),
	   ((SELECT id FROM users WHERE login = '@fullback'),
		(SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  	   	 						WHERE TN.name = 'Roland Garros' AND EXTRACT(YEAR FROM TIS.end_date) = 2023)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Карлос Алькарас')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Новак Джокович')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		TIMESTAMP '2023-09-06 20:00:00',
		1.8,
		150000
	   );
		
INSERT INTO bets(user_id, event_id, outcome_id, bet_timestamp, odd, amount)
VALUES ((SELECT id FROM users WHERE login = '@kapusta'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Япония')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Испания')),
 		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2022-12-01 18:00:00',
		8.5,
		200
	   ),
	   ((SELECT id FROM users WHERE login = '@kapusta'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Аргентина')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Хорватия')),
 		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2022-12-13 18:00:00',
		1.5,
		700
	   ),
	   ((SELECT id FROM users WHERE login = '@kapusta'),
		(SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Бразилия')
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Бельгия')),
		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2018-07-06 18:00:00',
		2.5,
		300
	   ),
	   ((SELECT id FROM users WHERE login = '@kapusta'),
	    (SELECT id FROM events
		 WHERE tournament_id = (SELECT TIS.id 
  		 						FROM tournaments_in_seasons AS TIS 
  		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
  		 						WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.start_date) = 2021)
	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Швеция'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))
	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Украина')),
		(SELECT id FROM outcomes WHERE name = 'П2'),
		TIMESTAMP '2021-06-29 22:00:00',
		2.5,
		200
	   ),
	   ((SELECT id FROM users WHERE login = '@kapusta'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Лига Чемпионов' AND EXTRACT(YEAR FROM TIS.end_date) = 2019)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Аякс')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Тоттенхэм Хотспур')),
 		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2019-05-01 21:00:00',
		2.5,
		200
	   ),
	   ((SELECT id FROM users WHERE login = '@kapusta'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Российская премьер-лига' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Факел')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Спартак')),
 		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2023-10-27 21:00:00',
		8.5,
		150
	   ),
	   ((SELECT id FROM users WHERE login = '@kapusta'),
		(SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   	   	 						WHERE TN.name = 'КХЛ' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'СКА')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Ак Барс')),
 		(SELECT id FROM outcomes WHERE name = 'П2'),
		TIMESTAMP '2023-10-30 17:00:00',
		1.9,
		600
	   );

INSERT INTO bets(user_id, event_id, outcome_id, bet_timestamp, odd, amount)
VALUES ((SELECT id FROM users WHERE login = '@ivan'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Португалия')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Швейцария')),
 		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2022-12-06 18:00:00',
		2.0,
		750
	   ),
	   ((SELECT id FROM users WHERE login = '@ivan'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Россия'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Египет')),
 		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2018-06-19 18:00:00',
		2.0,
		937
	   ),
	   ((SELECT id FROM users WHERE login = '@lyapis'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Россия'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Египет')),
 		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2018-06-19 18:00:00',
		2.0,
		10000
	   ),
	   ((SELECT id FROM users WHERE login = '@vano'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Россия'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Египет')),
 		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2018-06-19 18:00:00',
		2.0,
		1000
	   ),
	   ((SELECT id FROM users WHERE login = '@plez'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Россия'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Египет')),
 		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2018-06-19 18:00:00',
		2.0,
		2000
	   ),
	   ((SELECT id FROM users WHERE login = '@stepa'''),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Россия'
		 															AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Египет')),
 		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2018-06-19 18:00:00',
		3.4,
		1000
	   ),
	   ((SELECT id FROM users WHERE login = '@milanista'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Примера' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Реал Мадрид')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Барселона')),
 		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2023-10-28 18:00:00',
		2.5,
		500000
	   ),
	   ((SELECT id FROM users WHERE login = '@pup'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Россия'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Саудовская Аравия')),
 		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2018-06-10 18:00:00',
		1.5,
		1000
	   ),
	   ((SELECT id FROM users WHERE login = '@pup'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Франция')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Хорватия')),
 		(SELECT id FROM outcomes WHERE name = 'X'),
		TIMESTAMP '2018-07-15 18:00:00',
		3.7,
		1000
	   ),
	   ((SELECT id FROM users WHERE login = '@pup'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Саудовская Аравия')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Египет')),
 		(SELECT id FROM outcomes WHERE name = 'П2'),
		TIMESTAMP '2018-06-24 18:00:00',
		2.0,
		1000
	   ),
	   ((SELECT id FROM users WHERE login = '@pup'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2018)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Россия'
																	AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Египет')),
 		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2018-06-10 18:00:00',
		2.0,
		1000
	   ),
	   ((SELECT id FROM users WHERE login = '@pup'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Российская премьер-лига' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Факел')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Спартак')),
 		(SELECT id FROM outcomes WHERE name = 'П2'),
		TIMESTAMP '2023-10-27 21:00:00',
		1.3,
		1000
	   ),
	   ((SELECT id FROM users WHERE login = '@pup'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Российская премьер-лига' AND EXTRACT(YEAR FROM TIS.end_date) = 2024)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Зенит')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Динамо Москва'
																	 AND sport_id = (SELECT id FROM sports WHERE name = 'футбол'))),
 		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2023-08-05 21:00:00',
		1.5,
		1000
	   ),
		((SELECT id FROM users WHERE login = '@milanista'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.end_date) = 2021)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Бельгия')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Италия')),
 		(SELECT id FROM outcomes WHERE name = 'П2'),
		TIMESTAMP '2021-07-02 18:00:00',
		2.5,
		1000000
	   ),
	   ((SELECT id FROM users WHERE login = '@kapusta'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.end_date) = 2021)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Бельгия')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Италия')),
 		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2021-07-02 18:00:00',
		2.5,
		739
	   ),
	   ((SELECT id FROM users WHERE login = '@plez'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.end_date) = 2021)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Бельгия')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Италия')),
 		(SELECT id FROM outcomes WHERE name = 'X'),
		TIMESTAMP '2021-07-02 18:00:00',
		3.7,
		500
	   ),
	   ((SELECT id FROM users WHERE login = '@stepa'''),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.end_date) = 2021)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Бельгия')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Италия')),
 		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2021-07-02 18:00:00',
		2.5,
		5000
	   ),
	   ((SELECT id FROM users WHERE login = '@kuzmich'''),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.end_date) = 2021)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Бельгия')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Италия')),
 		(SELECT id FROM outcomes WHERE name = 'П2'),
		TIMESTAMP '2021-07-02 18:00:00',
		2.5,
		5000
	   ),
	   ((SELECT id FROM users WHERE login = '@chelsea'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Европы' AND EXTRACT(YEAR FROM TIS.end_date) = 2021)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Бельгия')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Италия')),
 		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2021-07-02 18:00:00',
		2.5,
		1000000
	   ),
	   ((SELECT id FROM users WHERE login = '@stepa'''),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Португалия')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Швейцария')),
 		(SELECT id FROM outcomes WHERE name = 'П2'),
		TIMESTAMP '2022-12-06 18:00:00',
		3.4,
		1800
	   ),
	   ((SELECT id FROM users WHERE login = '@kapusta'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Марокко')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Португалия')),
 		(SELECT id FROM outcomes WHERE name = 'X'),
		TIMESTAMP '2022-12-01 18:00:00',
		4.1,
		200
	   ),
	   ((SELECT id FROM users WHERE login = '@kapusta'),
	    (SELECT id FROM events
 		 WHERE tournament_id = (SELECT TIS.id 
   		 						FROM tournaments_in_seasons AS TIS 
   		 						JOIN tournaments AS TN ON TN.id = TIS.tournament_id
   		 						WHERE TN.name = 'Чемпионат Мира' AND EXTRACT(YEAR FROM TIS.start_date) = 2022)
 	    	AND first_participant_id = (SELECT id FROM participants WHERE name = 'Франция')
 	  		AND second_participant_id = (SELECT id FROM participants WHERE name = 'Марокко')),
 		(SELECT id FROM outcomes WHERE name = 'П1'),
		TIMESTAMP '2022-12-13 18:00:00',
		1.5,
		700
	   );