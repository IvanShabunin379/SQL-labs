-- Вставка стран
INSERT INTO countries (name) VALUES 
('USA'), ('Germany'), ('Japan');

-- Вставка марок автомобилей
INSERT INTO car_makes (name, country_id) VALUES 
('Ford', (SELECT id FROM countries WHERE name = 'USA')), 
('BMW', (SELECT id FROM countries WHERE name = 'Germany')), 
('Toyota', (SELECT id FROM countries WHERE name = 'Japan'));

-- Вставка моделей автомобилей
INSERT INTO car_models (name, make_id, body_type, category) VALUES 
('Mustang', (SELECT id FROM car_makes WHERE name = 'Ford'), 'coupe', 'sports'), 
('Camry', (SELECT id FROM car_makes WHERE name = 'Toyota'), 'sedan', 'large-family'), 
('X5', (SELECT id FROM car_makes WHERE name = 'BMW'), 'SUV', 'off-road'),
('Focus', (SELECT id FROM car_makes WHERE name = 'Ford'), 'hatchback', 'small-family'), 
('Corolla', (SELECT id FROM car_makes WHERE name = 'Toyota'), 'sedan', 'small-family'), 
('3 Series', (SELECT id FROM car_makes WHERE name = 'BMW'), 'sedan', 'executive');

-- Вставка владельцев автомобилей
INSERT INTO car_owners (last_name, first_name, patronymic, phone_number) VALUES 
('Ivanov', 'Ivan', 'Ivanovich', '89123456789'), 
('Petrov', 'Petr', 'Petrovich', '89987654321'), 
('Sidorov', 'Sid', 'Sidorovich', '89123123123'),
('Smirnov', 'Sergey', 'Sergeevich', '89321321321'),
('Fedorov', 'Fedor', 'Fedorovich', '89456456456'),
('Nikitin', 'Nikita', 'Nikitovich', '89654654654');

-- Вставка автомобилей
INSERT INTO cars (plate, region, year, model_id, owner_id) VALUES 
('A111AA', 1, 2010, (SELECT id FROM car_models WHERE name = 'Mustang'), (SELECT id FROM car_owners WHERE last_name = 'Ivanov' AND first_name = 'Ivan')), 
('B222BB', 1, 2008, (SELECT id FROM car_models WHERE name = 'Camry'), (SELECT id FROM car_owners WHERE last_name = 'Petrov' AND first_name = 'Petr')), 
('C333CC', 2, 2015, (SELECT id FROM car_models WHERE name = 'X5'), (SELECT id FROM car_owners WHERE last_name = 'Sidorov' AND first_name = 'Sid')),
('Y444YY', 2, 2005, (SELECT id FROM car_models WHERE name = 'Focus'), (SELECT id FROM car_owners WHERE last_name = 'Ivanov' AND first_name = 'Ivan')), 
('E555EE', 3, 2012, (SELECT id FROM car_models WHERE name = 'Corolla'), (SELECT id FROM car_owners WHERE last_name = 'Smirnov' AND first_name = 'Sergey')), 
('X666XX', 3, 2014, (SELECT id FROM car_models WHERE name = '3 Series'), (SELECT id FROM car_owners WHERE last_name = 'Fedorov' AND first_name = 'Fedor'))
('E444YX', 36, 2012, (SELECT id FROM car_models WHERE name = 'Focus'), (SELECT id FROM car_owners WHERE last_name = 'Ivanov' AND first_name = 'Ivan')), 
('X777XX', 3, 2020, (SELECT id FROM car_models WHERE name = 'X5'), (SELECT id FROM car_owners WHERE last_name = 'Fedorov' AND first_name = 'Fedor'));

-- Вставка неисправностей
INSERT INTO car_malfunctions (name) VALUES 
('Engine failure'), 
('Brake malfunction'), 
('Transmission issue'),
('Electrical issue'),
('Suspension issue');

-- Вставка специализаций
INSERT INTO specializations (name) VALUES 
('Engine Specialist'), 
('Brake Specialist'), 
('Transmission Specialist'),
('Electrical Specialist'),
('Suspension Specialist');

-- Вставка механиков
INSERT INTO mechanics (last_name, first_name, patronymic, phone_number, date_of_birth, specialization_id, experience, job_role) VALUES 
('Kuznetsov', 'Alexey', 'Alexeevich', '89111111111', '1980-01-01', (SELECT id FROM specializations WHERE name = 'Engine Specialist'), 10, 'full-time'), 
('Smirnov', 'Dmitry', 'Dmitrievich', '89222222222', '1985-02-02', (SELECT id FROM specializations WHERE name = 'Brake Specialist'), 8, 'part-time'), 
('Vasilev', 'Vasiliy', 'Vasilievich', '89333333333', '1990-03-03', (SELECT id FROM specializations WHERE name = 'Transmission Specialist'), 5, 'full-time'),
('Petrov', 'Alexey', 'Petrovich', '89444444444', '1982-04-04', (SELECT id FROM specializations WHERE name = 'Electrical Specialist'), 7, 'full-time'),
('Ivanov', 'Dmitry', 'Ivanovich', '89555555555', '1988-05-05', (SELECT id FROM specializations WHERE name = 'Suspension Specialist'), 6, 'part-time');

-- Вставка заказов
INSERT INTO orders (car_plate, date_of_receipt, mechanic_id, planned_completion_time, actual_completion_time, total_price, owner_id) VALUES 
('A111AA', '2023-01-01 10:00:00', (SELECT id FROM mechanics WHERE last_name = 'Kuznetsov'), '2023-01-05 10:00:00', '2023-01-05 10:00:00', 1000, (SELECT id FROM car_owners WHERE last_name = 'Ivanov' AND first_name = 'Ivan')), 
('B222BB', '2023-02-01 10:00:00', (SELECT id FROM mechanics WHERE last_name = 'Smirnov'), '2023-02-05 10:00:00', '2023-02-05 10:00:00', 2000, (SELECT id FROM car_owners WHERE last_name = 'Petrov' AND first_name = 'Petr')), 
('C333CC', '2023-03-01 10:00:00', (SELECT id FROM mechanics WHERE last_name = 'Vasilev'), '2023-03-05 10:00:00', '2023-03-07 10:00:00', 1500, (SELECT id FROM car_owners WHERE last_name = 'Sidorov' AND first_name = 'Sid')),
('Y444YY', '2023-01-10 10:00:00', (SELECT id FROM mechanics WHERE last_name = 'Petrov'), '2023-01-15 10:00:00', '2023-01-20 10:00:00', 1200, (SELECT id FROM car_owners WHERE last_name = 'Ivanov' AND first_name = 'Ivan')), 
('E555EE', '2023-02-15 10:00:00', (SELECT id FROM mechanics WHERE last_name = 'Ivanov'), '2023-02-20 10:00:00', '2023-02-18 10:00:00', 1100, (SELECT id FROM car_owners WHERE last_name = 'Smirnov' AND first_name = 'Sergey')), 
('X666XX', '2023-03-20 10:00:00', (SELECT id FROM mechanics WHERE last_name = 'Kuznetsov'), '2023-03-25 10:00:00', '2023-03-21 10:00:00', 1300, (SELECT id FROM car_owners WHERE last_name = 'Fedorov' AND first_name = 'Fedor')),
('X777XX', '2024-05-05 10:00:00', (SELECT id FROM mechanics WHERE last_name = 'Ivanov'), '2024-05-10 10:00:00', 1500, '2024-05-10 10:00:00', (SELECT id FROM car_owners WHERE last_name = 'Fedorov' AND first_name = 'Fedor')),
('E444YX', '2024-05-10 10:00:00', (SELECT id FROM mechanics WHERE last_name = 'Kuznetsov'), '2024-05-11 10:00:00', '2024-05-11 10:00:00', 1000, (SELECT id FROM car_owners WHERE last_name = 'Ivanov' AND first_name = 'Ivan')), 
('B222BB', '2024-05-15 10:00:00', (SELECT id FROM mechanics WHERE last_name = 'Kuznetsov'), '2024-05-15 18:00:00', '2024-05-17 18:00:00', 2000, (SELECT id FROM car_owners WHERE last_name = 'Petrov' AND first_name = 'Petr')), 
('C333CC', '2024-05-20 10:00:00', (SELECT id FROM mechanics WHERE last_name = 'Kuznetsov'), '2024-05-25 10:00:00', '2024-05-27 10:00:00', 1500, (SELECT id FROM car_owners WHERE last_name = 'Sidorov' AND first_name = 'Sid')),
('A111AA', '2024-05-01 10:00:00', (SELECT id FROM mechanics WHERE last_name = 'Ivanov'), '2024-05-01 12:00:00', '2024-05-01 12:00:00', 1000, (SELECT id FROM car_owners WHERE last_name = 'Ivanov' AND first_name = 'Ivan')), 
('B222BB', '2024-05-25 10:00:00', (SELECT id FROM mechanics WHERE last_name = 'Ivanov'), '2024-05-30 10:00:00', '2024-05-27 10:00:00', 2000, (SELECT id FROM car_owners WHERE last_name = 'Petrov' AND first_name = 'Petr')), 
('X666XX', '2024-05-30 10:00:00', (SELECT id FROM mechanics WHERE last_name = 'Ivanov'), '2024-05-31 10:00:00', '2024-05-30 18:00:00', 1300, (SELECT id FROM car_owners WHERE last_name = 'Fedorov' AND first_name = 'Fedor'));

-- Вставка неисправностей в заказах
INSERT INTO malfunctions_in_order (order_id, malfunction_id) VALUES 
((SELECT id FROM orders WHERE car_plate = 'A111AA' AND date_of_receipt = '2023-01-01 10:00:00'), (SELECT id FROM car_malfunctions WHERE name = 'Engine failure')), 
((SELECT id FROM orders WHERE car_plate = 'B222BB' AND date_of_receipt = '2023-02-01 10:00:00'), (SELECT id FROM car_malfunctions WHERE name = 'Brake malfunction')), 
((SELECT id FROM orders WHERE car_plate = 'C333CC' AND date_of_receipt = '2023-03-01 10:00:00'), (SELECT id FROM car_malfunctions WHERE name = 'Transmission issue')),
((SELECT id FROM orders WHERE car_plate = 'Y444YY' AND date_of_receipt = '2023-01-10 10:00:00'), (SELECT id FROM car_malfunctions WHERE name = 'Electrical issue')), 
((SELECT id FROM orders WHERE car_plate = 'E555EE' AND date_of_receipt = '2023-02-15 10:00:00'), (SELECT id FROM car_malfunctions WHERE name = 'Suspension issue')), 
((SELECT id FROM orders WHERE car_plate = 'X666XX' AND date_of_receipt = '2023-03-20 10:00:00'), (SELECT id FROM car_malfunctions WHERE name = 'Engine failure'));

-- Вставка типов ремонтных работ
INSERT INTO repair_work_types (name) VALUES 
('Oil change'), 
('Brake pad replacement'), 
('Transmission repair'),
('Electrical repair'),
('Suspension repair');

-- Вставка ремонтных работ в заказах
INSERT INTO repair_work_in_order (order_id, work_type_id) VALUES 
((SELECT id FROM orders WHERE car_plate = 'A111AA' AND date_of_receipt = '2023-01-01 10:00:00'), (SELECT id FROM repair_work_types WHERE name = 'Oil change')), 
((SELECT id FROM orders WHERE car_plate = 'B222BB' AND date_of_receipt = '2023-02-01 10:00:00'), (SELECT id FROM repair_work_types WHERE name = 'Brake pad replacement')), 
((SELECT id FROM orders WHERE car_plate = 'C333CC' AND date_of_receipt = '2023-03-01 10:00:00'), (SELECT id FROM repair_work_types WHERE name = 'Transmission repair')),
((SELECT id FROM orders WHERE car_plate = 'Y444YY' AND date_of_receipt = '2023-01-10 10:00:00'), (SELECT id FROM repair_work_types WHERE name = 'Electrical repair')), 
((SELECT id FROM orders WHERE car_plate = 'E555EE' AND date_of_receipt = '2023-02-15 10:00:00'), (SELECT id FROM repair_work_types WHERE name = 'Suspension repair')), 
((SELECT id FROM orders WHERE car_plate = 'X666XX' AND date_of_receipt = '2023-03-20 10:00:00'), (SELECT id FROM repair_work_types WHERE name = 'Oil change'));

-- Вставка единиц измерения
INSERT INTO units (name, abbreviation) VALUES 
('Piece', 'pcs'), 
('Liter', 'l'), 
('Kilogram', 'kg');

-- Вставка категорий запчастей
INSERT INTO spare_part_categories (name) VALUES 
('Engine Parts'), 
('Brake Parts'), 
('Transmission Parts'),
('Electrical Parts'),
('Suspension Parts');

-- Вставка запчастей
INSERT INTO spare_parts (code, name, category_id) VALUES 
('E123', 'Engine Oil', (SELECT id FROM spare_part_categories WHERE name = 'Engine Parts')), 
('B456', 'Brake Pads', (SELECT id FROM spare_part_categories WHERE name = 'Brake Parts')), 
('T789', 'Transmission Fluid', (SELECT id FROM spare_part_categories WHERE name = 'Transmission Parts')),
('E234', 'Alternator', (SELECT id FROM spare_part_categories WHERE name = 'Electrical Parts')),
('S345', 'Shock Absorber', (SELECT id FROM spare_part_categories WHERE name = 'Suspension Parts'));

-- Вставка запчастей в заказы
INSERT INTO spare_parts_in_order (spare_part_code, order_id, count, unit_id, additional_info) VALUES 
('E123', (SELECT id FROM orders WHERE car_plate = 'A111AA' AND date_of_receipt = '2023-01-01 10:00:00'), 5, (SELECT id FROM units WHERE name = 'Liter'), '5 liters of engine oil'), 
('B456', (SELECT id FROM orders WHERE car_plate = 'B222BB' AND date_of_receipt = '2023-02-01 10:00:00'), 4, (SELECT id FROM units WHERE name = 'Piece'), '4 brake pads'), 
('T789', (SELECT id FROM orders WHERE car_plate = 'C333CC' AND date_of_receipt = '2023-03-01 10:00:00'), 3, (SELECT id FROM units WHERE name = 'Liter'), '3 liters of transmission fluid'),
('E234', (SELECT id FROM orders WHERE car_plate = 'Y444YY' AND date_of_receipt = '2023-01-10 10:00:00'), 1, (SELECT id FROM units WHERE name = 'Piece'), '1 alternator'), 
('S345', (SELECT id FROM orders WHERE car_plate = 'E555EE' AND date_of_receipt = '2023-02-15 10:00:00'), 2, (SELECT id FROM units WHERE name = 'Piece'), '2 shock absorbers'), 
('E123', (SELECT id FROM orders WHERE car_plate = 'X666XX' AND date_of_receipt = '2023-03-20 10:00:00'), 4, (SELECT id FROM units WHERE name = 'Liter'), '4 liters of engine oil'),
('E123', (SELECT id FROM orders WHERE car_plate = 'Y444YY' AND date_of_receipt = '2023-01-10 10:00:00'), 5, (SELECT id FROM units WHERE name = 'Liter'), '5 liters of engine oil'),
('B456', (SELECT id FROM orders WHERE car_plate = 'Y444YY' AND date_of_receipt = '2023-01-10 10:00:00'), 4, (SELECT id FROM units WHERE name = 'Piece'), '4 brake pads')
('E234', (SELECT id FROM orders WHERE car_plate = 'E444YX' AND date_of_receipt = '2024-05-10 10:00:00'), 1, (SELECT id FROM units WHERE name = 'Piece'), '1 alternator'), 
('B456', (SELECT id FROM orders WHERE car_plate = 'E444YX' AND date_of_receipt = '2024-05-10 10:00:00'), 4, (SELECT id FROM units WHERE name = 'Piece'), '4 brake pads'),
('E234', (SELECT id FROM orders WHERE car_plate = 'X777XX' AND date_of_receipt = '2024-05-05 10:00:00'), 1, (SELECT id FROM units WHERE name = 'Piece'), '1 alternator'), 
('B456', (SELECT id FROM orders WHERE car_plate = 'X777XX' AND date_of_receipt = '2024-05-05 10:00:00'), 4, (SELECT id FROM units WHERE name = 'Piece'), '4 brake pads');


-- Вставка менеджеров поставщиков (продолжение)
INSERT INTO supplier_managers (last_name, first_name, patronymic) VALUES 
('Fedorov', 'Fedor', 'Fedorovich'), 
('Nikitin', 'Nikita', 'Nikitovich'), 
('Stepanov', 'Stepan', 'Stepanovich');

-- Вставка поставщиков запчастей
INSERT INTO spare_parts_suppliers (name, address, first_phone_number, second_phone_number, third_phone_number, manager_id) VALUES 
('Supplier A', '123 Main St', '111-111-1111', '222-222-2222', '333-333-3333', (SELECT id FROM supplier_managers WHERE last_name = 'Fedorov' AND first_name = 'Fedor')), 
('Supplier B', '456 Elm St', '444-444-4444', '555-555-5555', '666-666-6666', (SELECT id FROM supplier_managers WHERE last_name = 'Nikitin' AND first_name = 'Nikita')), 
('Supplier C', '789 Oak St', '777-777-7777', '888-888-8888', '999-999-9999', (SELECT id FROM supplier_managers WHERE last_name = 'Stepanov' AND first_name = 'Stepan'));

-- Вставка заказов на запчасти
INSERT INTO spare_parts_orders (supplier_id, formation_time, planned_delivery_time, actual_delivery_time) VALUES 
((SELECT id FROM spare_parts_suppliers WHERE name = 'Supplier A'), '2023-01-01 10:00:00', '2023-01-05 10:00:00', '2023-01-06 10:00:00'), 
((SELECT id FROM spare_parts_suppliers WHERE name = 'Supplier B'), '2023-02-01 10:00:00', '2023-02-05 10:00:00', '2023-02-05 10:00:00'), 
((SELECT id FROM spare_parts_suppliers WHERE name = 'Supplier A'), '2023-04-01 10:00:00', '2023-04-05 10:00:00', '2023-04-04 10:00:00'), 
((SELECT id FROM spare_parts_suppliers WHERE name = 'Supplier B'), '2023-05-01 10:00:00', '2023-05-05 10:00:00', '2023-05-06 10:00:00'), 
((SELECT id FROM spare_parts_suppliers WHERE name = 'Supplier C'), '2023-06-01 10:00:00', '2023-06-05 10:00:00', '2023-06-05 10:00:00');

-- Вставка запчастей в заказы на запчасти
INSERT INTO spare_parts_in_spare_parts_orders (spare_part_code, spare_parts_order_id, count, cost_of_each) VALUES 
('E123', (SELECT id FROM spare_parts_orders WHERE formation_time = '2023-01-01 10:00:00'), 10, 50), 
('B456', (SELECT id FROM spare_parts_orders WHERE formation_time = '2023-02-01 10:00:00'), 20, 30), 
('T789', (SELECT id FROM spare_parts_orders WHERE formation_time = '2023-04-01 10:00:00'), 15, 40),
('E234', (SELECT id FROM spare_parts_orders WHERE formation_time = '2023-05-01 10:00:00'), 5, 100), 
('S345', (SELECT id FROM spare_parts_orders WHERE formation_time = '2023-06-01 10:00:00'), 7, 70), 
('E123', (SELECT id FROM spare_parts_orders WHERE formation_time = '2023-02-01 10:00:00'), 10, 45);

-- Вставка дополнительных заказов
INSERT INTO orders (car_plate, date_of_receipt, mechanic_id, planned_completion_time, total_price, owner_id) VALUES 
('A111AA', '2023-04-01 10:00:00', (SELECT id FROM mechanics WHERE last_name = 'Smirnov'), '2023-04-05 10:00:00', 1400, (SELECT id FROM car_owners WHERE last_name = 'Ivanov' AND first_name = 'Ivan')), 
('B222BB', '2023-05-01 10:00:00', (SELECT id FROM mechanics WHERE last_name = 'Vasilev'), '2023-05-05 10:00:00', 2100, (SELECT id FROM car_owners WHERE last_name = 'Petrov' AND first_name = 'Petr')), 
('C333CC', '2023-06-01 10:00:00', (SELECT id FROM mechanics WHERE last_name = 'Petrov'), '2023-06-05 10:00:00', 1600, (SELECT id FROM car_owners WHERE last_name = 'Sidorov' AND first_name = 'Sid'));

-- Вставка неисправностей в дополнительные заказы
INSERT INTO malfunctions_in_order (order_id, malfunction_id) VALUES 
((SELECT id FROM orders WHERE car_plate = 'A111AA' AND date_of_receipt = '2023-04-01 10:00:00'), (SELECT id FROM car_malfunctions WHERE name = 'Brake malfunction')), 
((SELECT id FROM orders WHERE car_plate = 'B222BB' AND date_of_receipt = '2023-05-01 10:00:00'), (SELECT id FROM car_malfunctions WHERE name = 'Transmission issue')), 
((SELECT id FROM orders WHERE car_plate = 'C333CC' AND date_of_receipt = '2023-06-01 10:00:00'), (SELECT id FROM car_malfunctions WHERE name = 'Electrical issue'));

-- Вставка ремонтных работ в дополнительные заказы
INSERT INTO repair_work_in_order (order_id, work_type_id) VALUES 
((SELECT id FROM orders WHERE car_plate = 'A111AA' AND date_of_receipt = '2023-04-01 10:00:00'), (SELECT id FROM repair_work_types WHERE name = 'Brake pad replacement')), 
((SELECT id FROM orders WHERE car_plate = 'B222BB' AND date_of_receipt = '2023-05-01 10:00:00'), (SELECT id FROM repair_work_types WHERE name = 'Transmission repair')), 
((SELECT id FROM orders WHERE car_plate = 'C333CC' AND date_of_receipt = '2023-06-01 10:00:00'), (SELECT id FROM repair_work_types WHERE name = 'Electrical repair'));

-- Вставка запчастей в дополнительные заказы
INSERT INTO spare_parts_in_order (spare_part_code, order_id, count, unit_id, additional_info) VALUES 
('B456', (SELECT id FROM orders WHERE car_plate = 'A111AA' AND date_of_receipt = '2023-04-01 10:00:00'), 3, (SELECT id FROM units WHERE name = 'Piece'), '3 brake pads'), 
('T789', (SELECT id FROM orders WHERE car_plate = 'B222BB' AND date_of_receipt = '2023-05-01 10:00:00'), 2, (SELECT id FROM units WHERE name = 'Liter'), '2 liters of transmission fluid'), 
('E234', (SELECT id FROM orders WHERE car_plate = 'C333CC' AND date_of_receipt = '2023-06-01 10:00:00'), 1, (SELECT id FROM units WHERE name = 'Piece'), '1 alternator');


