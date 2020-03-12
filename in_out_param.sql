--IN and OUT parameters in a procedure
--first we create a procedure
CREATE OR REPLACE PROCEDURE emp_name(id IN NUMBER, empl_name OUT VARCHAR2) IS
BEGIN
  SELECT emp_name INTO empl_name
  FROM employee WHERE emp_id = id;
END;

--we execute the procedure
--notice the difference in the usage of IN and OUT parameters
DECLARE
empName VARCHAR2(20);
CURSOR id_cur IS (SELECT emp_id FROM employee);
BEGIN
  FOR emp_rec IN id_cur LOOP
    emp_name(emp_rec.emp_id,empName);
    DBMS_OUTPUT.PUT_LINE('The employee '||empName||' has id '||emp_rec.emp_id);
  END LOOP;
END;
