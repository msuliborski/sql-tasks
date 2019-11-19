-- 1. Write a PL/SQL block to print information about a given country.
    -- Declare a PL/SQL record based on the structure of the countries table.
    -- Declare a variable v_countryid. Assign CA to v_countryid.
    -- In the declarative section, use the %ROWTYPE attribute and declare the v_country_record variable of type countries.
    -- In the executable section, get all the information from the countries table by using v_countryid. Display selected information about the country.
DECLARE
    TYPE r_countries IS RECORD (
        country_id      hr.countries.country_id%TYPE,
        country_name    hr.countries.country_name%TYPE,
        region_id       hr.countries.region_id%TYPE );
    v_countryid hr.countries.country_id%TYPE := 'CA';
    v_country_record r_countries;
  
BEGIN
  select * into v_country_record from hr.countries
  where country_id = v_countryid;
  
  dbms_output.put_line( v_country_record.country_id || ' ' ||
                        v_country_record.country_name || ' ' ||
                        v_country_record.region_id);
END; 

-- 2. Create a PL/SQL block that does the following:
    -- In the declarative section, declare a variable v_deptno of type NUMBER and assign a value that holds the department ID.
    -- Declare a cursor, c_emp_cursor, that retrieves the last_name, salary, and manager_id of the employees working in the department specified in v_deptno.
    -- In the executable section, use the cursor FOR loop to operate on the data retrieved. If the salary of the employee is less than 5,000 and if the manager ID is either 101 or 124, display the message “<<last_name>> Due for a raise.” Otherwise, display the message “<<last_name>> Not due for a raise.”

    
-- 3. Create a PL/SQL block that determines the top n salaries of the employees. n should be passed as a variable in the block.
-- 4. Write a PL/SQL block, which declares and uses cursors with parameters. In a loop, use a cursor to retrieve the department number and the department name from the departments table for a department whose department_id is less than 100. Pass the department number to another cursor as a parameter to retrieve from the employees table the details of employee last name, job, hire date, and salary of those employees whose employee_id is less than 120 and who work in that department.
-- 5. Write a PL/SQL block to select the name of the employee with a given salary value. If the salary entered returns only one row, display employee’s name and the salary amount. If the salary entered does not return any rows or returns more than one row, handle the exception with appropriate exception handlers and messages.
-- 6. Use the Oracle server error ORA-02292 (integrity constraint violated – child record found) to practice how to declare exceptions with a standard Oracle Server error. Create a PL/SQL block that deletes department with employees assigned. Handle the exception.