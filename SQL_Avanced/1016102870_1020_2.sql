 DECLARE
   deadlock_detected EXCEPTION;
   PRAGMA EXCEPTION_INIT(deadlock_detected, -60);
   parent_key_not_found EXCEPTION;
   PRAGMA EXCEPTION_INIT(PARENT_KEY_NOT_FOUND, -2291);
   child_record_found EXCEPTION;
   PRAGMA EXCEPTION_INIT(child_record_found, -2292);
   err_msg VARCHAR2(100);
   err_num NUMBER;
--
BEGIN
--bloque que genera el problema 2292
DELETE FROM EMPLOYEES WHERE EMPLOYEE_ID = 202;
exception
	WHEN parent_key_not_found THEN dbms_output.put_line('PROBLEMA CON ALGUN DATO PADRE.');
   WHEN child_record_found THEN dbms_output.put_line('PROBLEMA CON ALGUN DATO hijo');
END;

