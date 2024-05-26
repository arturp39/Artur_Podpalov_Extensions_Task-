-- Install extensions
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Verify that the extensions are installed
SELECT * FROM pg_extension;

-- Create the "employees" Table
DROP TABLE IF EXISTS employees;
CREATE TABLE  employees (
   id serial PRIMARY KEY,
   first_name VARCHAR(255),
   last_name VARCHAR(255),
   email VARCHAR(255),
   encrypted_password TEXT
);

-- Insert employee data
INSERT INTO employees (first_name, last_name, email, encrypted_password) VALUES
   ('Artur', 'Podpalov', 'podpalov.artur@student.ehu.lt', crypt('123123', gen_salt('bf'))),
   ('John', 'Cena', 'sena.john@student.ehu.lt', crypt('password403', gen_salt('bf')));

-- Verify  data
SELECT * FROM employees;

-- Update last name
UPDATE employees SET last_name = 'Lennon' WHERE email = 'sena.john@student.ehu.lt';

-- Verify the update
SELECT * FROM employees;

-- Delete an employee record
DELETE FROM employees WHERE email = 'podpalov.artur@student.ehu.lt';

-- Verify the deletion
SELECT * FROM employees;

-- Configure pg_stat_statements
ALTER SYSTEM SET shared_preload_libraries TO 'pg_stat_statements';
ALTER SYSTEM SET pg_stat_statements.track TO 'all';

SELECT * FROM pg_stat_statements;

-- Identify the most frequently executed queries
SELECT query, calls 
FROM pg_stat_statements
ORDER BY calls DESC;

-- Determine which queries have the highest average and total runtime
SELECT query, total_plan_time + total_exec_time AS total_time, 
       (total_plan_time + total_exec_time) / calls AS avg_time
FROM pg_stat_statements
ORDER BY avg_time DESC, total_time DESC;

-- Determine which queries have the highest average and total runtime
SELECT query, total_plan_time + total_exec_time AS total_time , 
       (total_plan_time + total_exec_time) / calls AS avg_time
FROM pg_stat_statements
ORDER BY avg_time DESC, total_time DESC;
