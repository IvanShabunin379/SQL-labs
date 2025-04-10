CREATE TYPE body_type AS ENUM ('sedan', 'coupe', 'convertible', 'hatchback', 'limousine', 'minivan', 'SUV', 'truck', 'pickup', 'van');
CREATE TYPE car_category AS ENUM ('mini', 'small-family', 'large-family', 'executive', 'hybrid', 'sports', 'off-road');
CREATE TYPE job_role AS ENUM ('full-time', 'part-time'); 

CREATE TABLE countries (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE car_makes (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    country_id INT NOT NULL REFERENCES countries(id)
);

CREATE TABLE car_models (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    make_id INT NOT NULL REFERENCES car_makes(id),
    body_type body_type NOT NULL,
    category car_category NOT NULL
);

CREATE TABLE car_owners (
    id SERIAL PRIMARY KEY,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL,
    patronymic TEXT,
    phone_number TEXT
);

CREATE TABLE cars (
    plate TEXT PRIMARY KEY,
    region INT NOT NULL,
    year INT NOT NULL,
    model_id INT NOT NULL REFERENCES car_models(id),
    owner_id INT NOT NULL REFERENCES car_owners(id)
);

CREATE TABLE car_malfunctions (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE specializations (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE mechanics (
    id SERIAL PRIMARY KEY,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL,
    patronymic TEXT,
    phone_number TEXT,
    date_of_birth DATE,
    specialization_id INT NOT NULL REFERENCES specializations(id),
    experience INT,
    job_role job_role
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    car_plate TEXT NOT NULL REFERENCES cars(plate),
    date_of_receipt TIMESTAMP NOT NULL,
    mechanic_id INT NOT NULL REFERENCES mechanics(id),
    planned_completion_time TIMESTAMP,
	actual_completion_time TIMESTAMP,
    total_price NUMERIC,
    owner_id INT NOT NULL REFERENCES car_owners(id)
);

CREATE TABLE malfunctions_in_order (
    order_id INT NOT NULL REFERENCES orders(id),
    malfunction_id INT NOT NULL REFERENCES car_malfunctions(id),
    PRIMARY KEY (order_id, malfunction_id)
);

CREATE TABLE repair_work_types (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE repair_work_in_order (
    order_id INT NOT NULL REFERENCES orders(id),
    work_type_id INT NOT NULL REFERENCES repair_work_types(id),
    PRIMARY KEY (order_id, work_type_id)
);

CREATE TABLE units (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    abbreviation TEXT
);

CREATE TABLE spare_part_categories (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE spare_parts (
    code TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    category_id INT NOT NULL REFERENCES spare_part_categories(id)
);

CREATE TABLE spare_parts_in_order (
    spare_part_code TEXT NOT NULL REFERENCES spare_parts(code),
    order_id INT NOT NULL REFERENCES orders(id),
    count INT NOT NULL,
    unit_id INT NOT NULL REFERENCES units(id),
    additional_info TEXT,
    PRIMARY KEY (spare_part_code, order_id)
);

CREATE TABLE supplier_managers (
    id SERIAL PRIMARY KEY,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL,
    patronymic TEXT
);

CREATE TABLE spare_parts_suppliers (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    address TEXT,
    first_phone_number TEXT,
    second_phone_number TEXT,
    third_phone_number TEXT,
    manager_id INT NOT NULL REFERENCES supplier_managers(id)
);

CREATE TABLE spare_parts_orders (
    id SERIAL PRIMARY KEY,
    supplier_id INT NOT NULL REFERENCES spare_parts_suppliers(id),
    formation_time TIMESTAMP NOT NULL,
    planned_delivery_time TIMESTAMP,
    actual_delivery_time TIMESTAMP
);

CREATE TABLE spare_parts_in_spare_parts_orders (
    spare_part_code TEXT NOT NULL REFERENCES spare_parts(code),
    spare_parts_order_id INT NOT NULL REFERENCES spare_parts_orders(id),
    count INT NOT NULL,
    cost_of_each NUMERIC,
    PRIMARY KEY (spare_part_code, spare_parts_order_id)
);





















