-- 20. Выбрать количество студентов, получивших неудовлетворительные оценки за последнюю зимнюю сессию.

SELECT COUNT(DISTINCT student_id_number)
FROM performances 
WHERE grade = 2 
	AND (EXTRACT(YEAR FROM date_of_performance) = EXTRACT(YEAR FROM CURRENT_DATE)
		 	AND EXTRACT(MONTH FROM date_of_performance) BETWEEN 1 AND 2)
		OR (EXTRACT(YEAR FROM date_of_performance) = (EXTRACT(YEAR FROM CURRENT_DATE) - 1)
		   	AND EXTRACT(MONTH FROM date_of_performance) = 12);

-- 21. Выбрать день, в который было сдано больше N дисциплин. 
-- Для примера я взял N=5.

SELECT date_of_performance
FROM performances 
GROUP BY date_of_performance
HAVING COUNT(DISTINCT discipline_id) > 5;

/* 26. Выбрать название факультета, фамилию и инициалы декана факультета, количество 
студентов на факультете, средний балл студентов факультета за зимнюю сессию в этом году. */

SELECT F.name AS faculty_name,
	   (D.last_name || '. ' || D.first_name || '. ' || COALESCE(D.middle_name || '.', '')) AS dean_name,
	   COUNT(DISTINCT S.student_id_number) AS students_count,
	   AVG(P.grade) AS average_grade_for_winter_session
FROM faculties F 
	JOIN lecturers D ON F.dean_id = D.id
	JOIN students S ON F.id = S.faculty_id
	JOIN performances P ON S.student_id_number = P.student_id_number
WHERE (EXTRACT(YEAR FROM date_of_performance) = EXTRACT(YEAR FROM CURRENT_DATE)
		 	AND EXTRACT(MONTH FROM date_of_performance) BETWEEN 1 AND 2)
	   	OR (EXTRACT(YEAR FROM date_of_performance) = (EXTRACT(YEAR FROM CURRENT_DATE) - 1)
		   	AND EXTRACT(MONTH FROM date_of_performance) = 12)
GROUP BY faculty_name, dean_name;

/* 27. Выбрать название факультета, курс, группу, название дисциплины, средний балл по группе. 
Результат отсортировать по названию факультета в лексикографическом порядке, 
по курсу и группе – в возрастающем порядке. */

SELECT F.name AS faculty,
	   S.course,
	   S.group_number,
	   D.name AS discipline,
	   AVG(P.grade) AS average_grade
FROM faculties F
	JOIN students S ON F.id = S.faculty_id
	JOIN performances P ON S.student_id_number = P.student_id_number
	JOIN disciplines D ON P.discipline_id = D.id
GROUP BY faculty, S.course, S.group_number, discipline
ORDER BY 1, 2, 3;

/* 28. Выбрать названия дисциплин, которые преподаются сотрудниками факультета ПММ, количество 
студентов, сдававших дисциплину, среднюю оценку по дисциплине. 
В результат включить только дисциплины, которые сдавало более 20 студентов. */

SELECT D.name AS discipline,
	   COUNT(DISTINCT P.student_id_number) AS count_of_students_who_passed_this,
	   COUNT(P.grade) average_grade
FROM performances P 
	JOIN disciplines D ON P.discipline_id = D.id
	JOIN lecturers L ON P.lecturer_id = L.id
	JOIN faculties F ON L.faculty_id = F.id
WHERE F.name = 'ПММ'
GROUP BY D.name
HAVING COUNT(DISTINCT P.student_id_number) > 20;

-- 37. Для каждого студента факультета ПММ выбрать названия всех имеющихся в БД дисциплин. 

SELECT S.student_id_number, D.name AS discipline_name
FROM students S CROSS JOIN disciplines D;

/* 43. Выбрать названия дисциплин, по которым средний балл ниже 3,5. 
Результат отсортировать в порядке возрастания среднего балла 
и по названию дисциплин в лексикографическом порядке. */

SELECT D.name AS discipline_name
FROM disciplines D JOIN performances P
	ON D.id = P.discipline_id
GROUP BY discipline_name
HAVING AVG(P.grade) < 3.5;

-- Условие 45-го совпадает точь-в-точь с условием 28-го.



