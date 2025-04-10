-- CREATE'ы. Создание таблиц и наложение ограничений PRIMARY KEY, NOT NULL и DEFAULT

CREATE TABLE bets (
	id SERIAL PRIMARY KEY,
	user_id INT NOT NULL,
	event_id INT NOT NULL,
	outcome_id INT NOT NULL,
	bet_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	odd NUMERIC(6,2) NOT NULL DEFAULT 1.00,
	amount INT NOT NULL
);

CREATE TABLE events (
	id SERIAL PRIMARY KEY,
	tournament_id INT,
	first_participant_id INT NOT NULL,
	second_participant_id INT NOT NULL,
	start_time TIMESTAMP,
	end_time TIMESTAMP
);

CREATE TABLE outcomes (
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	description TEXT 
);

CREATE TABLE event_outcomes (
	event_id INT NOT NULL,
	outcome_id INT NOT NULL,
	odd NUMERIC(6,2) NOT NULL DEFAULT 1.00,
	occured BOOL,
	PRIMARY KEY (event_id, outcome_id)
);

CREATE TABLE odds_history (
	event_id INT NOT NULL,
	outcome_id INT NOT NULL,
	odd_date TIMESTAMP,
	odd NUMERIC(6,2) NOT NULL DEFAULT 1.00,
	PRIMARY KEY (event_id, outcome_id, odd_date)
);

CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	login TEXT NOT NULL,
	password TEXT NOT NULL,
	last_name TEXT NOT NULL,
	first_name TEXT NOT NULL,
	patronymic TEXT,
	phone_number VARCHAR(18) NOT NULL,
	date_of_birth DATE
);

CREATE TYPE PARTICIPANT_TYPE AS ENUM ('club', 'national team', 'athlete');

CREATE TABLE participants (
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	sport_id INT NOT NULL,
	participant_type PARTICIPANT_TYPE NOT NULL,
	country_id INT
);

CREATE TABLE countries (
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL
);

CREATE TABLE tournaments (
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	sport_id INT NOT NULL,
	participant_type PARTICIPANT_TYPE NOT NULL,
	country_id INT
);

CREATE TYPE SPORT_TYPE AS ENUM ('individual', 'team');

CREATE TABLE sports (
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	sport_type SPORT_TYPE
);

CREATE TABLE tournaments_in_seasons (
	id SERIAL PRIMARY KEY,
	tournament_id INT NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE
);

CREATE TABLE participations_in_tournaments (
	participant_id INT NOT NULL, 
	tournament_in_season_id INT NOT NULL,
	PRIMARY KEY (participant_id, tournament_in_season_id)
);


-- ALTER'ы. Наложение ограничений FOREIGN KEY, UNIQUE и CHECK

ALTER TABLE bets 
ADD CONSTRAINT bet_user_fk
	FOREIGN KEY (user_id)
	REFERENCES users(id),
ADD CONSTRAINT bet_event_outcome_fk
	FOREIGN KEY (event_id, outcome_id)
	REFERENCES event_outcomes(event_id, outcome_id),
ADD CONSTRAINT valid_odd
	CHECK (odd >= 1.00 AND odd <= 5000.00),
ADD CONSTRAINT valid_amount
	CHECK (amount::numeric >= 50.00 AND amount * odd <= 3000000.00);
	
ALTER TABLE events
ADD CONSTRAINT event_tourn_fk
	FOREIGN KEY (tournament_id)
	REFERENCES tournaments_in_seasons(id),
ADD CONSTRAINT event_particip_1_fk
	FOREIGN KEY (first_participant_id)
	REFERENCES participants(id),
ADD CONSTRAINT event_particip_2_fk
	FOREIGN KEY (second_participant_id)
	REFERENCES participants(id),
ADD CONSTRAINT valid_datetimes
	CHECK (start_time <= end_time);

ALTER TABLE outcomes
ADD UNIQUE (name);

ALTER TABLE event_outcomes
ADD CONSTRAINT event_fk
	FOREIGN KEY (event_id)
	REFERENCES events(id),
ADD CONSTRAINT outcome_fk
	FOREIGN KEY (outcome_id)
	REFERENCES outcomes(id),
ADD CONSTRAINT valid_odd
	CHECK (odd >= 1.00 AND odd <= 5000.00);
	
ALTER TABLE odds_history
ADD CONSTRAINT event_fk
	FOREIGN KEY (event_id)
	REFERENCES events(id),
ADD CONSTRAINT outcome_fk
	FOREIGN KEY (outcome_id)
	REFERENCES outcomes(id),
ADD CONSTRAINT valid_odd
	CHECK (odd >= 1.00 AND odd <= 5000.00);
	
ALTER TABLE users
ADD UNIQUE (login),
ADD UNIQUE (phone_number),
ADD CONSTRAINT pw_min_len
	CHECK (LENGTH(password) > 5),
/*ADD CONSTRAINT valid_first_name
	CHECK (first_name ~ '^[a-zA-Zа-яА-Я -]*$'),
ADD CONSTRAINT valid_last_name
	CHECK (last_name ~ '^[a-zA-Zа-яА-Я -'']*$'),
ADD CONSTRAINT valid_patronymic
	CHECK (patronymic ~ '^[a-zA-Zа-яА-Я-]*$'),*/
ADD CONSTRAINT valid_phone_number
	CHECK (LENGTH(phone_number) >= 6
		   AND phone_number ~ '^[0-9\+\-\(\)]*$'),
ADD CONSTRAINT valid_age
	CHECK (date_of_birth >= '1930-01-01' 
		   AND EXTRACT(YEAR FROM AGE(date_of_birth)) >= 18);

ALTER TABLE participants
ADD UNIQUE (name, sport_id),
ADD CONSTRAINT partic_country_fk
	FOREIGN KEY (country_id)
	REFERENCES countries(id),
ADD CONSTRAINT partic_sport_fk
	FOREIGN KEY (sport_id)
	REFERENCES sports(id);
	
ALTER TABLE countries
ADD UNIQUE (name);

ALTER TABLE tournaments
ADD UNIQUE (name, sport_id, country_id),
ADD CONSTRAINT tourn_sport_fk
	FOREIGN KEY (sport_id)
	REFERENCES sports(id),
ADD CONSTRAINT tourn_country_fk
	FOREIGN KEY (country_id)
	REFERENCES countries(id);

ALTER TABLE tournaments_in_seasons
ADD CONSTRAINT tourn_fk
	FOREIGN KEY (tournament_id)
	REFERENCES tournaments(id),
ADD CONSTRAINT valid_dates
	CHECK (start_date <= end_date);	

ALTER TABLE participations_in_tournaments
ADD CONSTRAINT participant_fk
	FOREIGN KEY (participant_id)
	REFERENCES participants(id),
ADD CONSTRAINT tourn_in_seas_fk
	FOREIGN KEY (tournament_in_season_id)
	REFERENCES tournaments_in_seasons(id);

ALTER TABLE sports
ADD UNIQUE (name);
