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
-- bloque que genera el problema 2291
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID)
values ('1202','Alex','De Chan','ADECHAAN','515.123.4569',to_date('13/01/01','DD/MM/RR'),'AD_VP0','17000',null,'100','90');

EXCEPTION 
	WHEN parent_key_not_found THEN dbms_output.put_line('PROBLEMA CON ALGUN DATO PADRE.');
END;
