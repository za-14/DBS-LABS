--LAB 5

--Q1
--part a
SELECT e.first_name, e.last_name, d.department_id, d.department_name 
FROM EMPLOYEES e
CROSS JOIN DEPARTMENTS d
WHERE e.department_id = d.department_id;

--part b
SELECT e.first_name, e.last_name, department_id, d.department_name
FROM EMPLOYEES e
INNER JOIN DEPARTMENTS d
USING(department_id);

--part c
SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM EMPLOYEES e
INNER JOIN DEPARTMENTS d
ON e.department_id = d.department_id;

--part d
SELECT e.first_name, e.last_name, department_id, d.department_name
FROM EMPLOYEES e
NATURAL JOIN DEPARTMENTS d;

--part e
-- parts a to c give 106 records and part d gives 32 records

--part f
-- we cant use USING/natural join as it requires same name, then we would need to use ON CLAUSE as we can map different column names

--Q2
-- first name, last name, department name, city, and state province for each employee
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_NAME, CITY, STATE_PROVINCE
FROM ((EMPLOYEES e
INNER JOIN DEPARTMENTS d ON e.department_id = d.department_id)
INNER JOIN LOCATIONS l ON d.location_id = l.location_id);

--Q3
--first name, last name, salary, and job title for all employees
SELECT FIRST_NAME, LAST_NAME, SALARY, JOB_TITLE
FROM EMPLOYEES 
LEFT JOIN JOBS 
USING(JOB_ID);

--Q4
--full name, department number and department name of employees who work in Finance or Accounting department
SELECT FIRST_NAME || ' '  || LAST_NAME AS FULL_NAME, DEPARTMENT_ID, DEPARTMENT_NAME
FROM EMPLOYEES 
INNER JOIN DEPARTMENTS 
USING(DEPARTMENT_ID)
WHERE DEPARTMENT_NAME IN ('Finance','Accounting');

--Q5
SELECT FIRST_NAME || ' '  || LAST_NAME AS FULL_NAME, DEPARTMENT_NAME, JOB_ID, CITY || ' ' || STATE_PROVINCE AS LOCATIONS
FROM ((EMPLOYEES 
INNER JOIN DEPARTMENTS USING(DEPARTMENT_ID))
INNER JOIN LOCATIONS USING(LOCATION_ID));

--Q6
SELECT FIRST_NAME || ' '  || LAST_NAME AS FULL_NAME, DEPARTMENT_NAME, JOB_ID, CITY || ' ' || STATE_PROVINCE AS LOCATIONS
FROM ((EMPLOYEES 
INNER JOIN DEPARTMENTS USING(DEPARTMENT_ID))
INNER JOIN LOCATIONS USING(LOCATION_ID))
WHERE CITY LIKE 'S%';

--Q7
SELECT EMP.FIRST_NAME || ' ' || EMP.LAST_NAME AS EMP_NAME,manager.first_name || ' ' || manager.last_name AS MANAGER_NAME  FROM EMPLOYEES MANAGER
INNER JOIN EMPLOYEES EMP
ON MANAGER.employee_id = EMP.manager_id;

--Q8
-- department name, city, state province for all departments that end with “ing
SELECT DEPARTMENT_NAME, CITY, STATE_PROVINCE
FROM DEPARTMENTS
INNER JOIN LOCATIONS
USING(LOCATION_ID)
WHERE DEPARTMENT_NAME LIKE '%ing';

--Q9
-- full name of each employee with their department ID and department name
SELECT FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME, DEPARTMENT_ID, DEPARTMENT_NAME
FROM EMPLOYEES
LEFT JOIN DEPARTMENTS
USING(DEPARTMENT_ID);

--Q10
-- names of departments with no employee working in it
SELECT DEPARTMENT_NAME
FROM EMPLOYEES
RIGHT JOIN DEPARTMENTS
USING(DEPARTMENT_ID)
WHERE EMPLOYEE_ID IS NULL;

--Q11
--first name and last name of employee and manager. Those employees who do not MANAGER
SELECT EMP.FIRST_NAME AS EMPLOYEE_FIRST_NAME, EMP.LAST_NAME AS EMPLOYEE_LAST_NAME, MANAGER.FIRST_NAME AS MANAGER_FIRST_NAME, MANAGER.LAST_NAME AS MANAGER_LAST_NAME
FROM EMPLOYEES EMP
LEFT JOIN EMPLOYEES MANAGER
USING(MANAGER_ID);

--Q12
SELECT * FROM EMPLOYEES EMP
LEFT JOIN EMPLOYEES MANAGER
ON emp.manager_id = MANAGER.employee_id
WHERE EMP.MANAGER_ID IS NULL;

--Q13
--complete address information for each department. Output department name, street address, postal code, city, state_province, country name, region name
SELECT DEPARTMENT_NAME, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_NAME
FROM ((DEPARTMENTS
INNER JOIN LOCATIONS USING(LOCATION_ID))
INNER JOIN COUNTRIES USING(COUNTRY_ID));

--Q14
-- full names of employees who are earning more than their own managers
SELECT EMP.FIRST_NAME || ' ' || EMP.LAST_NAME AS FULL_NAME FROM HR.EMPLOYEES EMP
LEFT JOIN HR.EMPLOYEES MANAGER
ON emp.manager_id = MANAGER.employee_id
WHERE EMP.SALARY > MANAGER.SALARY;

--Q15
--all employees who started a job between January 1993 and December 1995. Display the employee_name, job_title, department name and start_date
SELECT e.FIRST_NAME || ' ' || e.LAST_NAME AS FULL_NAME, j.JOB_TITLE, d.DEPARTMENT_NAME, jh.start_date
FROM ((( HR.EMPLOYEES e 
LEFT JOIN HR.DEPARTMENTS d USING(DEPARTMENT_ID))
LEFT JOIN HR.JOBS j USING(JOB_ID))
LEFT JOIN HR.JOB_HISTORY jh ON e.EMPLOYEE_ID = jh.EMPLOYEE_ID)
WHERE e.hire_date BETWEEN TO_DATE('01-01-1993','DD-MM-YYYY') AND TO_DATE('31-12-1995','DD-MM-YYYY');
    
--Q16
SELECT E.FIRST_NAME || ' ' || e.LAST_NAME AS FULL_NAME, E.SALARY, E.PHONE_NUMBER, D.DEPARTMENT_NAME 
FROM HR.EMPLOYEES E
FULL OUTER JOIN HR.DEPARTMENTS D
USING(DEPARTMENT_ID);

--Q17
-- average salary for employees in different departments
SELECT ROUND(AVG(E.SALARY),2) AS AVG_SALARY, D.DEPARTMENT_NAME
FROM HR.EMPLOYEES E
INNER JOIN HR.DEPARTMENTS D
USING(DEPARTMENT_ID)
GROUP BY D.DEPARTMENT_NAME;

--Q18
SELECT E.FIRST_NAME || ' ' || E.LAST_NAME AS FULL_NAME, J.JOB_TITLE, J.MAX_SALARY - E.SALARY AS SALARY_DIFFERENCE
FROM HR.EMPLOYEES E
INNER JOIN HR.JOBS J
USING(JOB_ID)
ORDER BY SALARY_DIFFERENCE;

--Q19
SELECT COUNT(E.EMPLOYEE_ID) AS NO_OF_EMPLOYEES, J.JOB_TITLE
FROM HR.EMPLOYEES E
INNER JOIN HR.JOBS J
USING(JOB_ID)
GROUP BY job_title
ORDER BY NO_OF_EMPLOYEES;

--Q20
--number of departments in each city
SELECT COUNT(D.DEPARTMENT_ID) AS NO_OF_DEPS, L.CITY
FROM HR.DEPARTMENTS D
INNER JOIN HR.LOCATIONS L
USING(LOCATION_ID)
GROUP BY L.CITY
ORDER BY NO_OF_DEPS;

