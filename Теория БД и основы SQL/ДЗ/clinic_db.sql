-- Создание таблиц

CREATE TYPE SEX AS ENUM ('male', 'female');

CREATE TABLE doctors (
    personnel_number SERIAL PRIMARY KEY,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL,
    patronymic TEXT,
    date_of_birth DATE NOT NULL,
    sex SEX NOT NULL,
    phone_number TEXT,
    specialization TEXT,
    license_number TEXT UNIQUE,
    hire_date DATE NOT NULL,
    CONSTRAINT valid_phone CHECK (phone_number IS NULL OR phone_number ~ '^\+?[0-9\-\(\) ]+$')
);

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL,
    patronymic TEXT,
    date_of_birth DATE NOT NULL,
    sex SEX NOT NULL,
    address TEXT,
    phone_number TEXT,
    medical_policy_number TEXT UNIQUE,
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT valid_policy_number CHECK (medical_policy_number ~ '^[0-9]{16}$'),
    CONSTRAINT valid_patient_phone CHECK (phone_number IS NULL OR phone_number ~ '^\+?[0-9\-\(\) ]+$')
);

CREATE TABLE receptions (
    id SERIAL PRIMARY KEY,
    reception_date DATE NOT NULL,
    reception_time TIME NOT NULL,
    symptoms TEXT NOT NULL,
    diagnosis TEXT,
    prescriptions TEXT,
    doctor_personnel_number INTEGER NOT NULL REFERENCES doctors(personnel_number),
    patient_id INTEGER NOT NULL REFERENCES patients(id),
    CONSTRAINT unique_reception UNIQUE (reception_date, reception_time, doctor_personnel_number),
    CONSTRAINT future_reception CHECK (reception_date <= CURRENT_DATE)
);

CREATE TABLE medical_records (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER NOT NULL REFERENCES patients(id),
    record_date DATE NOT NULL,
    record_text TEXT NOT NULL,
    doctor_personnel_number INTEGER REFERENCES doctors(personnel_number),
    reception_id INTEGER REFERENCES receptions(id)
);


-- Запросы на выборку данных из БД

-- 1. Удалить данные о пациенте Иванове Иване Ивановиче

DELETE FROM patients
WHERE last_name = 'Иванов'
	AND first_name = 'Иван'
	AND patronymic = 'Иванович';
	
/* 3. Вставить в таблицу Прием данные о приеме врачом Поповым Сергеем Юрьевичем 
пациента Сергеева Сергея Сергеевича. Дата приема сегодняшнее число. */	

INSERT INTO receptions(reception_date, doctor_personnel_number, patient_id)
VALUES (CURRENT_DATE, 
	    (SELECT id FROM doctors
		 WHERE last_name = 'Попов'
		 	AND first_name = 'Сергей'
			AND patronymic = 'Юрьевич'), 
		 (SELECT id FROM patients
		 WHERE last_name = 'Сергеев'
		 	AND first_name = 'Сергей'
			AND patronymic = 'Сергеевич')
	   );
	   
-- 5. Изменить фамилию врача Ивановой Натальи Ивановны на Петрову. 
UPDATE doctors
SET last_name = 'Петрова'
WHERE last_name = 'Иванова'
	AND first_name = 'Наталья'
	AND patronymic = 'Ивановна';
	
-- 7. Выбрать все данные о пациентах мужского пола. 
SELECT *
FROM patients
WHERE sex = 'male';

/* 9. Вывести фамилии, имена, отчества, адреса пациентов, у которых не определен телефон.
Результат упорядочить по фамилии в лексикографическом порядке. */
SELECT last_name, first_name, patronymic, address
FROM patients
WHERE phone_number IS NULL OR phone_number = ''
ORDER BY last_name;

-- 11. Выбрать пациентов, медицинский полис которых включает последовательность символов «8000». 
SELECT *
FROM patients
WHERE medical_policy_number LIKE '%8000%';

/* 13. Выбрать фамилию и инициалы врачей в одном столбце,
телефон во втором столбце. Если телефон врача неизвестен, то
вывести во втором столбце «нет». */

SELECT CONCAT(last_name, ' ',
			  LEFT(first_name), '. ',
			  COALESCE(LEFT(patronymic) || '.', '')
			 ) AS name, 
	   COALESCE(phone_number, 'нет')
FROM doctors;

/* 15. Выбрать средний возраст пациентов, лечившихся у Куликова Сергея Юрьевича 
и бывших у него на приеме более двух раз. */

SELECT AVG(EXTRACT(YEAR FROM AGE(Pat.date_of_birth)))
FROM patients Pat
JOIN receptions Rec
ON Pat.id = Rec.patient_id
JOIN doctors Doc
ON Doc.personnal_number = Rec.doctor_personnal_number
WHERE Doc.

-- 17. Вывести общее количество врачей

SELECT COUNT(*)
FROM doctors;

/* 19. Вывести фамилию, имя, отчество пациента, дату приема,
симптомы, предписания больному и фамилию, имя, отчество врача, осуществившего прием. */

SELECT Pat.last_name || ' ' || Pat.first_name || ' ' || COALESCE(Pat.patronymic, '') AS patient_name,
       Rec.reception_date,
       Rec.symptoms,
       Rec.prescriptions,
       Doc.last_name || ' ' || Doc.first_name || ' ' || COALESCE(Doc.patronymic, '') AS doctor_name
FROM receptions Rec
JOIN patients Pat ON Rec.patient_id = Pat.id
JOIN doctors Doc ON Rec.doctor_personnel_number = Doc.personnel_number
ORDER BY Rec.reception_date DESC, Pat.last_name, Pat.first_name;
