DECLARE salary_of_emp  NUMBER(8,2);
 
  PROCEDURE approx_salary (
    emp        NUMBER, 
    empsal IN OUT NUMBER,
    addless     NUMBER ) 
    IS
  BEGIN
    empsal := empsal + addless;
  END;
 
BEGIN
  SELECT salary INTO salary_of_emp
  FROM employees
  WHERE employee_id = 122;
 
  DBMS_OUTPUT.PUT_LINE
   ('Before invoking procedure, salary_of_emp: ' || salary_of_emp);
 
  approx_salary (100, salary_of_emp, 1000);
 
  DBMS_OUTPUT.PUT_LINE
   ('After invoking procedure, salary_of_emp: ' || salary_of_emp);
END;