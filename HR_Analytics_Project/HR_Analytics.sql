SELECT * FROM public.employees
LIMIT 100

-- 1. Headcount by department
SELECT department, COUNT(*) AS Count_of_an_employee_each_department
FROM employees
GROUP BY department
ORDER BY Count_of_an_employee_each_department DESC;

-- 2. Average , min , max salary by department
SELECT
    department,
    COUNT(*)                         AS Count_of_an_employee_each_department,
    ROUND(AVG(annual_salary), 2)     AS avg_salary,
    MIN(annual_salary)               AS min_salary,
    MAX(annual_salary)               AS max_salary
FROM employees
GROUP BY department
ORDER BY avg_salary DESC;

-- 3. Salary band distribution
SELECT salary_band, COUNT(*) AS employees, ROUND(AVG(annual_salary),2) AS avg_salary
FROM employees
GROUP BY salary_band
ORDER BY avg_salary DESC;

-- 4. Gender pay comparison by department
SELECT
    department,
    gender,
    COUNT(*)                     AS Count_of_an_employee_each_department,
    ROUND(AVG(annual_salary), 2) AS avg_salary
FROM employees
GROUP BY department, gender
ORDER BY department, gender;

-- 5. Top 10 highest-paid employees
SELECT full_name, job_title, department, country, annual_salary
FROM employees
ORDER BY annual_salary DESC
LIMIT 10;


-- 6. Highest salary in each department

SELECT  department, MAX(annual_salary) AS highest_salary
FROM employees
GROUP BY department
ORDER BY highest_salary DESC;


-- 7. Lowest salary in each department

SELECT department, MIN(annual_salary) AS lowest_salary
FROM employees
GROUP BY department;


-- 8. Ranking employees by salary within each department (window function)
SELECT
    full_name,
    department,
    annual_salary,
    RANK() OVER (PARTITION BY department ORDER BY annual_salary DESC) AS salary_rank_in_dept
FROM employees
ORDER BY department, salary_rank_in_dept;

-- 9. Running total of bonus amount paid, ordered by hire date (window function)
SELECT
    full_name,
    hire_date,
    bonus_amount,
    SUM(bonus_amount) OVER (ORDER BY hire_date) AS running_total_bonus
FROM employees
ORDER BY hire_date;

-- 10. Year-over-year hiring trend
SELECT
    EXTRACT(YEAR FROM hire_date) AS hire_year,
    COUNT(*) AS employees_hired
FROM employees
GROUP BY hire_year
ORDER BY hire_year;

-- 11. Ethnicity + gender diversity breakdown
SELECT ethnicity, gender, COUNT(*) AS Count_of_an_employee_each_department
FROM employees
GROUP BY ethnicity, gender
ORDER BY ethnicity, gender;


-- 12. Employees above their department's average salary
SELECT e.full_name, e.department, e.annual_salary, d.avg_salary
FROM employees e
JOIN (
    SELECT department, ROUND(AVG(annual_salary),2) AS avg_salary
    FROM employees
    GROUP BY department
) d ON e.department = d.department
WHERE e.annual_salary > d.avg_salary
ORDER BY e.department, e.annual_salary DESC;

-- 13. City-level headcount (for a Power BI map visual)
SELECT country, city, COUNT(*) AS Count_of_an_employee_each_department
FROM employees
GROUP BY country, city
ORDER BY Count_of_an_employee_each_department DESC;

-- 14. Create a reusable VIEW for department summary
CREATE OR REPLACE VIEW department_summary AS
SELECT
    department,
    business_unit,
    COUNT(*)                        AS Count_of_an_employee_each_department,
    ROUND(AVG(annual_salary), 2)    AS avg_salary,
    ROUND(AVG(age), 1)              AS avg_age,
	MIN(annual_salary)				AS min_salary,
    MAX(annual_salary) 				AS max_salary
   
FROM employees
GROUP BY department, business_unit;

SELECT * FROM department_summary ORDER BY avg_salary DESC;

-- 15. Create a reusable view of employee summary
CREATE OR REPLACE VIEW employees_summary AS
SELECT
    employee_row_id,
    eeid,
    full_name,
    job_title,
    department,
    business_unit,
    gender,
    ethnicity,
    age,
    hire_date,
    tenure_years,
    annual_salary,
    salary_band,
    bonus_pct,
    bonus_amount,
    country,
    city,
    is_duplicate_eeid
FROM employees;


SELECT * FROM employees_summary;
