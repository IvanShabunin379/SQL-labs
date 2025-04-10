/* 43. Для каждого месяца выбрать количество просроченных заказов, количество заказов, 
выполненных вовремя, и количество заказов, выполненных раньше срока по строкам. 
В результирующей таблице должно быть три столбца: 
название месяца, 
название вида количества (просроченные заказы, заказы в срок, заказы, выполненные раньше срока)
и количество. 
Результат отсортировать по месяцам. */

-- 1-й способ
EXPLAIN ANALYZE
WITH order_statuses AS (
    SELECT
        date_trunc('month', date_of_receipt) AS month,
        CASE
            WHEN actual_completion_time > planned_completion_time THEN 'просроченные заказы'
            WHEN actual_completion_time = planned_completion_time THEN 'заказы в срок'
            WHEN actual_completion_time < planned_completion_time THEN 'заказы, выполненные раньше срока'
        END AS status
    FROM orders
    WHERE actual_completion_time IS NOT NULL
)
SELECT 
    month AS месяц,
    status AS "название вида количества",
    COUNT(*) AS количество
FROM order_statuses
GROUP BY month, status
ORDER BY month, status;

-- 2-й способ
EXPLAIN ANALYZE
SELECT 
    date_trunc('month', date_of_receipt) AS месяц,
    CASE
        WHEN actual_completion_time > planned_completion_time THEN 'просроченные заказы'
        WHEN actual_completion_time = planned_completion_time THEN 'заказы в срок'
        WHEN actual_completion_time < planned_completion_time THEN 'заказы, выполненные раньше срока'
    END AS "название вида количества",
    COUNT(*) AS количество
FROM orders
WHERE actual_completion_time IS NOT NULL
GROUP BY 
    date_trunc('month', date_of_receipt),
    CASE
        WHEN actual_completion_time > planned_completion_time THEN 'просроченные заказы'
        WHEN actual_completion_time = planned_completion_time THEN 'заказы в срок'
        WHEN actual_completion_time < planned_completion_time THEN 'заказы, выполненные раньше срока'
    END
ORDER BY 
    date_trunc('month', date_of_receipt),
    "название вида количества";


-- 44. Выбрать автомобиль, на котором ни одну запчасть не меняли дважды. 

-- 1-й способ
EXPLAIN ANALYZE
SELECT C.*
FROM cars C
JOIN (
    SELECT O.car_plate AS plate,
           COUNT(DISTINCT SPIO.spare_part_code) AS spare_parts_count
    FROM orders O 
    LEFT JOIN spare_parts_in_order SPIO ON O.id = SPIO.order_id
    GROUP BY O.car_plate
) AS spare_parts_count_by_car ON spare_parts_count_by_car.plate = C.plate
WHERE spare_parts_count_by_car.spare_parts_count IS NULL 
   OR spare_parts_count_by_car.spare_parts_count < 2;
   
-- 2-й способ 
EXPLAIN ANALYZE
WITH spare_parts_count_by_car AS (
	SELECT O.car_plate AS plate,
           COUNT(DISTINCT SPIO.spare_part_code) AS spare_parts_count
    FROM orders O 
    LEFT JOIN spare_parts_in_order SPIO ON O.id = SPIO.order_id
    GROUP BY O.car_plate
)
SELECT C.*
FROM cars C JOIN spare_parts_count_by_car SPCBC
	ON C.plate = SPCBC.plate
WHERE SPCBC.spare_parts_count IS NULL 
   OR SPCBC.spare_parts_count < 2;
   
-- вариант с NOT EXISTS
EXPLAIN ANALYZE
WITH changed_count_by_car_and_spare_part AS (
	SELECT O.car_plate AS plate,
		   SPIO.spare_part_code,
           COUNT(SPIO.*) AS spare_parts_count
    FROM orders O 
    LEFT JOIN spare_parts_in_order SPIO ON O.id = SPIO.order_id
    GROUP BY O.car_plate, SPIO.spare_part_code
)
SELECT C.*
FROM cars C 
WHERE NOT EXISTS (SELECT 1
				  FROM changed_count_by_car_and_spare_part CH_CNT
				  WHERE C.plate = CH_CNT.plate
				  	AND CH_CNT.spare_parts_count >= 2
				 );
	
-- вариант без группировки
EXPLAIN ANALYZE
SELECT C.*
FROM cars C 
LEFT JOIN orders O ON C.plate = O.car_plate
LEFT JOIN spare_parts_in_order SPIO ON O.id = SPIO.order_id
WHERE NOT EXISTS (SELECT 1
				  FROM spare_parts_in_order SPIO_2 JOIN orders O2
				  	ON SPIO_2.order_id = O2.id
				  WHERE C.plate = O2.car_plate
				  	AND SPIO.spare_part_code = SPIO_2.spare_part_code
				  	AND O.id != O2.id
				 );
	
-- надеюсь, окончательный вариант :)
EXPLAIN ANALYZE
SELECT C.*
FROM cars C
WHERE NOT EXISTS (
    SELECT 1
    FROM orders O1
    JOIN spare_parts_in_order SPIO_1 ON O1.id = SPIO_1.order_id
    JOIN orders O2 ON O1.car_plate = O2.car_plate
    JOIN spare_parts_in_order SPIO_2 ON O2.id = SPIO_2.order_id
    WHERE C.plate = O1.car_plate
      AND SPIO_1.spare_part_code = SPIO_2.spare_part_code
      AND SPIO_1.order_id != SPIO_2.order_id
);


   
   

-- 45. Выбрать фамилию, имя, отчество мастера, который чинил автомобили всех категорий.

-- 1-й способ
EXPLAIN ANALYZE
SELECT M.last_name, M.first_name, M.patronymic
FROM mechanics M 
JOIN orders O ON M.id = O.mechanic_id
JOIN cars C ON O.car_plate = C.plate
JOIN car_models CM ON C.model_id = CM.id
GROUP BY M.id, M.last_name, M.first_name, M.patronymic
HAVING COUNT(CM.category) = (SELECT COUNT(*) 
							 FROM pg_enum
							 WHERE enumtypid = 'car_category'::regtype);
			
-- 2-й способ
EXPLAIN ANALYZE
WITH categories_count_by_mechanic AS (
	SELECT M.id, M.last_name, M.first_name, M.patronymic,
		   COUNT(CM.category)
	FROM mechanics M 
	JOIN orders O ON M.id = O.mechanic_id
	JOIN cars C ON O.car_plate = C.plate
	JOIN car_models CM ON C.model_id = CM.id
	GROUP BY M.id, M.last_name, M.first_name, M.patronymic
),
car_categories_count AS (
	SELECT COUNT(*) 
	FROM pg_enum
	WHERE enumtypid = 'car_category'::regtype
)
SELECT CCBM.last_name, CCBM.first_name, CCBM.patronymic
FROM categories_count_by_mechanic CCBM
WHERE CCBM.count = (SELECT count
				    FROM car_categories_count);


/* 46. Выбрать фамилии, имена, отчества владельцев транспортных средств двух разных категорий, которые 
имеют два автомобиля одной марки. */

-- 1-й способ
EXPLAIN ANALYZE
SELECT OWN.last_name, OWN.first_name, OWN.patronymic
FROM car_owners OWN
JOIN cars C ON OWN.id = C.owner_id
JOIN car_models M ON C.model_id = M.id 
GROUP BY OWN.id, OWN.last_name, OWN.first_name, OWN.patronymic, M.make_id
HAVING COUNT(DISTINCT category) >= 2
	AND COUNT(C.plate) >= 2;

-- 2-й способ
EXPLAIN ANALYZE
WITH owner_cars AS (
    SELECT 
        OWN.id AS owner_id, 
        OWN.last_name, 
        OWN.first_name, 
        OWN.patronymic,
        M.make_id,
        COUNT(M.category) OVER (PARTITION BY OWN.id, M.make_id) AS category_count,
        COUNT(C.plate) OVER (PARTITION BY OWN.id, M.make_id) AS car_count
    FROM car_owners OWN
    JOIN cars C ON OWN.id = C.owner_id
    JOIN car_models M ON C.model_id = M.id
)
SELECT DISTINCT last_name, first_name, patronymic
FROM owner_cars
WHERE category_count >= 2 AND car_count >= 2;


-- 47. Выбрать названия запчастей, которые устанавливались на самые старые автомобили.

-- 1-й способ
EXPLAIN ANALYZE
WITH oldest_car_year AS (
    SELECT MIN(year) AS oldest_year
    FROM cars
)
SELECT SP.name
FROM spare_parts SP
JOIN spare_parts_in_order SPIO ON SP.code = SPIO.spare_part_code
JOIN orders O ON SPIO.order_id = O.id
JOIN cars C ON O.car_plate = C.plate
JOIN oldest_car_year OCY ON C.year = OCY.oldest_year;

-- 2-й способ
EXPLAIN ANALYZE
WITH oldest_cars AS (
	SELECT C.plate
	FROM cars C
	WHERE C.year <= ALL(SELECT year FROM cars)
)
SELECT SP.name 
FROM spare_parts SP
JOIN spare_parts_in_order SPIO ON SP.code = SPIO.spare_part_code
JOIN orders O ON SPIO.order_id = O.id
JOIN oldest_cars OLDC ON O.car_plate = OLDC.plate;


-- 48. Выбрать марку, модель, госномер автомобилей, на которых делали замену, как самой дорогой, так и самой дешевой запчасти.

-- 1-й способ
EXPLAIN ANALYZE
WITH 
	most_expensive_spare_part AS (
		SELECT SP.*
		FROM spare_parts SP JOIN spare_parts_in_spare_parts_orders SPISPO
			ON SP.code = SPISPO.spare_part_code
		WHERE SPISPO.cost_of_each = (SELECT MAX(cost_of_each)
								 	 FROM spare_parts_in_spare_parts_orders)
	),
	cheapest_spare_part AS (
		SELECT SP.*
		FROM spare_parts SP JOIN spare_parts_in_spare_parts_orders SPISPO
			ON SP.code = SPISPO.spare_part_code
		WHERE SPISPO.cost_of_each = (SELECT MIN(cost_of_each)
								 	 FROM spare_parts_in_spare_parts_orders)
	)
SELECT MK.name, MD.name, C.plate
FROM cars C
JOIN car_models MD ON C.model_id = MD.id
JOIN car_makes MK ON MD.make_id = MK.id
JOIN orders O ON C.plate = O.car_plate
WHERE EXISTS (SELECT 1
			  FROM spare_parts_in_order SPIO
			  WHERE O.id = SPIO.order_id AND SPIO.spare_part_code = (SELECT code FROM most_expensive_spare_part)
			 )
	AND EXISTS (SELECT 1
			  	FROM spare_parts_in_order SPIO
			  	WHERE O.id = SPIO.order_id AND SPIO.spare_part_code = (SELECT code FROM cheapest_spare_part)
			   );

-- 2-й способ
EXPLAIN ANALYZE
WITH ranked_spare_parts AS (
    SELECT
        spare_part_code,
        cost_of_each,
        MAX(cost_of_each) OVER () AS max_cost,
        MIN(cost_of_each) OVER () AS min_cost
    FROM spare_parts_in_spare_parts_orders
)
SELECT MK.name, MD.name, C.plate
FROM cars C
JOIN car_models MD ON C.model_id = MD.id
JOIN car_makes MK ON MD.make_id = MK.id
JOIN orders O ON C.plate = O.car_plate
WHERE EXISTS (SELECT 1
			  FROM spare_parts_in_order SPIO 
			  JOIN spare_parts SP ON SPIO.spare_part_code = SP.code
			  JOIN spare_parts_in_spare_parts_orders SPO ON SP.code = SPO.spare_part_code
			  WHERE O.id = SPIO.order_id AND SPO.cost_of_each = (SELECT DISTINCT max_cost FROM ranked_spare_parts)
			 )
	AND EXISTS (SELECT 1
			  FROM spare_parts_in_order SPIO 
			  JOIN spare_parts SP ON SPIO.spare_part_code = SP.code
			  JOIN spare_parts_in_spare_parts_orders SPO ON SP.code = SPO.spare_part_code
			  WHERE O.id = SPIO.order_id AND SPO.cost_of_each = (SELECT DISTINCT min_cost FROM ranked_spare_parts)
			 );

-- 3-й способ
EXPLAIN ANALYZE
WITH ranked_spare_parts AS (
    SELECT
        cost_of_each,
        MAX(cost_of_each) OVER () AS max_cost,
        MIN(cost_of_each) OVER () AS min_cost
    FROM spare_parts_in_spare_parts_orders
),
orders_with_extreme_parts AS (
    SELECT order_id
    FROM spare_parts_in_order SPIO
    JOIN spare_parts_in_spare_parts_orders SPOSO ON SPIO.spare_part_code = SPOSO.spare_part_code
    JOIN ranked_spare_parts RSP ON SPOSO.cost_of_each = RSP.max_cost OR SPOSO.cost_of_each = RSP.min_cost
    GROUP BY order_id
    HAVING COUNT(DISTINCT SPOSO.cost_of_each) = 2
)
SELECT MK.name AS make, MD.name AS model, C.plate
FROM cars C
JOIN car_models MD ON C.model_id = MD.id
JOIN car_makes MK ON MD.make_id = MK.id
JOIN orders O ON C.plate = O.car_plate
WHERE O.id IN (SELECT order_id FROM orders_with_extreme_parts);

-- 4-й способ
EXPLAIN ANALYZE
WITH ranked_spare_parts AS (
    SELECT
        cost_of_each,
        MAX(cost_of_each) OVER () AS max_cost,
        MIN(cost_of_each) OVER () AS min_cost
    FROM spare_parts_in_spare_parts_orders
),
orders_with_extreme_parts AS (
    SELECT order_id
    FROM spare_parts_in_order SPIO
    JOIN spare_parts_in_spare_parts_orders SPOSO ON SPIO.spare_part_code = SPOSO.spare_part_code
    JOIN ranked_spare_parts RSP ON SPOSO.cost_of_each = RSP.max_cost OR SPOSO.cost_of_each = RSP.min_cost
    GROUP BY order_id
    HAVING COUNT(DISTINCT SPOSO.cost_of_each) = 2
)
SELECT MK.name AS make, MD.name AS model, C.plate
FROM cars C
JOIN car_models MD ON C.model_id = MD.id
JOIN car_makes MK ON MD.make_id = MK.id
JOIN orders O ON C.plate = O.car_plate
JOIN orders_with_extreme_parts OWEP ON O.id = OWEP.order_id;


/* 49. Вывести фамилии, имена, отчества владельцев, которые
обладают 2 автомобилями и более, но не имеют тезок и/или однофамильцев. */

-- 1-й способ
EXPLAIN ANALYZE
SELECT OWN.last_name, OWN.first_name, OWN.patronymic
FROM car_owners OWN JOIN cars C
	ON OWN.id = C.owner_id 
WHERE NOT EXISTS (SELECT 1
				  FROM car_owners OWN_2
				  WHERE (OWN_2.last_name = OWN.last_name OR OWN_2.first_name = OWN.first_name)
				  	AND OWN_2.id != OWN.id
				 )
GROUP BY OWN.id, OWN.last_name, OWN.first_name, OWN.patronymic
HAVING COUNT(C.plate) >= 2;

-- 2-й способ
EXPLAIN ANALYZE
WITH owners_with_multiple_cars AS (
    SELECT OWN.id, OWN.last_name, OWN.first_name, OWN.patronymic
    FROM car_owners OWN 
    JOIN cars C ON OWN.id = C.owner_id
    GROUP BY OWN.id, OWN.last_name, OWN.first_name, OWN.patronymic
    HAVING COUNT(C.plate) >= 2
),
owners_with_namesakes AS (
    SELECT DISTINCT OWN.id
    FROM car_owners OWN 
    JOIN car_owners OWN_2 
        ON (OWN_2.last_name = OWN.last_name OR OWN_2.first_name = OWN.first_name)
       AND OWN_2.id != OWN.id
)
SELECT last_name, first_name, patronymic
FROM owners_with_multiple_cars
WHERE id NOT IN (SELECT id FROM owners_with_namesakes);


-- + 50. Выбрать тройку самых старых автомобилей.

-- 1-й способ
EXPLAIN ANALYZE
SELECT *
FROM cars
ORDER BY year
LIMIT 3;

--2-й способ
EXPLAIN ANALYZE
WITH ranked_cars AS (
    SELECT *,
    ROW_NUMBER() OVER (ORDER BY year) AS row_num
    FROM cars
)
SELECT *
FROM ranked_cars
WHERE row_num <= 3;

-- или так?:
EXPLAIN ANALYZE
SELECT *
FROM (
    SELECT *,
    ROW_NUMBER() OVER (ORDER BY year) AS row_num
    FROM cars
) AS ranked_cars
WHERE row_num <= 3;


-- 51. Выбрать все даты прошлого месяца, в которые не осуществляли замену запчастей. 

-- 1-й способ: все даты месяца - generate_series(), выбор нужных - EXCEPT неподходящих
EXPLAIN ANALYZE
SELECT (generate_series(
    date_trunc('month', CURRENT_DATE - interval '1 month')::DATE,
    (date_trunc('month', CURRENT_DATE) - interval '1 day')::DATE,
    '1 day'::interval
))::DATE AS last_month_date
EXCEPT
SELECT O.actual_completion_time::DATE
FROM orders O
JOIN spare_parts_in_order SPIO ON O.id = SPIO.order_id
ORDER BY last_month_date;

-- 2-й способ: все даты месяца - generate_series(), выбор нужных - LEFT JOIN и IS NULL
EXPLAIN ANALYZE
WITH last_month_dates AS (
	SELECT (generate_series(
    	date_trunc('month', CURRENT_DATE - interval '1 month')::DATE,
    	(date_trunc('month', CURRENT_DATE) - interval '1 day')::DATE,
    	'1 day'::interval
	))::DATE AS date
) 
SELECT LMD.date
FROM last_month_dates LMD 
LEFT JOIN orders O ON LMD.date = O.actual_completion_time::DATE
LEFT JOIN spare_parts_in_order SPIO ON O.id = SPIO.order_id
WHERE O.id IS NULL OR SPIO.order_id IS NULL
ORDER BY LMD.date;

-- 3-й способ: все даты месяца - generate_series(), выбор нужных - NOT EXISTS
EXPLAIN ANALYZE
WITH last_month_dates AS (
	SELECT (generate_series(
    	date_trunc('month', CURRENT_DATE - interval '1 month')::DATE,
    	(date_trunc('month', CURRENT_DATE) - interval '1 day')::DATE,
    	'1 day'::interval
	))::DATE AS date
) 
SELECT LMD.date
FROM last_month_dates LMD 
LEFT JOIN orders O ON LMD.date = O.actual_completion_time::DATE
WHERE NOT EXISTS (SELECT 1
				  FROM spare_parts_in_order SPIO
				  WHERE O.id = SPIO.order_id
				 )
ORDER BY LMD.date;

-- 4-й способ: все даты месяца - рекурсия, выбор нужных - EXCEPT неподходящих
EXPLAIN ANALYZE
WITH RECURSIVE last_month_dates AS (
    SELECT (date_trunc('month', CURRENT_DATE - interval '1 month')::DATE) AS date
    UNION ALL
    SELECT (date + interval '1 day')::DATE
    FROM last_month_dates
    WHERE date + interval '1 day' < date_trunc('month', CURRENT_DATE)::DATE
)
SELECT date
FROM last_month_dates
EXCEPT
SELECT O.actual_completion_time::DATE
FROM orders O
JOIN spare_parts_in_order SPIO ON O.id = SPIO.order_id
ORDER BY date;

-- 5-й способ: все даты месяца - рекурсия, выбор нужных - LEFT JOIN и IS NULL
EXPLAIN ANALYZE
WITH RECURSIVE last_month_dates AS (
    SELECT (date_trunc('month', CURRENT_DATE - interval '1 month')::DATE) AS date
    UNION ALL
    SELECT (date + interval '1 day')::DATE
    FROM last_month_dates
    WHERE date + interval '1 day' < date_trunc('month', CURRENT_DATE)::DATE
)
SELECT LMD.date
FROM last_month_dates LMD 
LEFT JOIN orders O ON LMD.date = O.actual_completion_time::DATE
LEFT JOIN spare_parts_in_order SPIO ON O.id = SPIO.order_id
WHERE O.id IS NULL OR SPIO.order_id IS NULL
ORDER BY LMD.date;

-- 6-й способ: все даты месяца - рекурсия, выбор нужных - NOT EXISTS
EXPLAIN ANALYZE
WITH RECURSIVE last_month_dates AS (
    SELECT (date_trunc('month', CURRENT_DATE - interval '1 month')::DATE) AS date
    UNION ALL
    SELECT (date + interval '1 day')::DATE
    FROM last_month_dates
    WHERE date + interval '1 day' < date_trunc('month', CURRENT_DATE)::DATE
)
SELECT LMD.date
FROM last_month_dates LMD 
LEFT JOIN orders O ON LMD.date = O.actual_completion_time::DATE
WHERE NOT EXISTS (SELECT 1
				  FROM spare_parts_in_order SPIO
				  WHERE O.id = SPIO.order_id
				 )
ORDER BY LMD.date;


/* 52. Выбрать названия поставщиков, количество заказов в прошлом году, 
процентное отношение ко всем заказам прошлого года */

-- 1-й способ: 
EXPLAIN ANALYZE
SELECT SPS.name AS supplier_name, 
       COUNT(SPO.id) AS orders_count,
       ROUND((COUNT(SPO.id) * 100.0 / (SELECT COUNT(id)
                                       FROM spare_parts_orders
                                       WHERE EXTRACT(YEAR FROM formation_time) = (EXTRACT(YEAR FROM CURRENT_DATE) - 1)
                                      )
			 ), 2) AS percentage_of_all
FROM spare_parts_suppliers SPS 
    JOIN spare_parts_orders SPO ON SPS.id = SPO.supplier_id
WHERE EXTRACT(YEAR FROM SPO.formation_time) = (EXTRACT(YEAR FROM CURRENT_DATE) - 1)
GROUP BY SPS.id, supplier_name;

-- 2-й способ
EXPLAIN ANALYZE
WITH last_years_orders AS (
    SELECT 
        SPS.name AS supplier_name,
        SPO.id AS order_id
    FROM spare_parts_suppliers SPS
    JOIN spare_parts_orders SPO ON SPS.id = SPO.supplier_id
    WHERE EXTRACT(YEAR FROM SPO.formation_time) = EXTRACT(YEAR FROM CURRENT_DATE) - 1
)
SELECT 
    supplier_name,
    COUNT(order_id) AS orders_count,
    ROUND((COUNT(order_id) * 100.0 / SUM(COUNT(order_id)) OVER ()), 2) AS percentage_of_all
FROM last_years_orders
GROUP BY supplier_name
ORDER BY supplier_name;









