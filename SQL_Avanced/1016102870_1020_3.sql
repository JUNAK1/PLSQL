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
--bloque que manipile las 2 situciones y no genere error
	BEGIN
		Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID)
		values ('1202','Alex','De Chan','ADECHAAN','515.123.4569',to_date('13/01/01','DD/MM/RR'),'AD_VP0','17000',null,'100','90');
	EXCEPTION 
		WHEN parent_key_not_found THEN dbms_output.put_line('PROBLEMA CON ALGUN DATO PADRE.');
		WHEN dup_val_on_index THEN dbms_output.put_line('REGISTRO YA EXISTE');
	BEGIN
		DELETE FROM EMPLOYEES WHERE EMPLOYEE_ID = 202;
	exception
		WHEN child_record_found THEN dbms_output.put_line('PROBLEMA CON ALGUN DATO PADRE.');
	END;
dbms_output.put_line('semanejaron las posibles execeptions')
exception
WHEN OTHERS THEN 
	err_num := SQLCODE;
	err_msg := SQLERRM;
    dbms_output.put_line('Error number = ' || err_num);
    dbms_output.put_line('Error message = ' || err_msg);
END;
/