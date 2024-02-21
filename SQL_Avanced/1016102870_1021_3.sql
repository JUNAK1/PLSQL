-- Cuerpo del paquete PKG_NOMINA
CREATE OR REPLACE PACKAGE BODY PKG_NOMINA AS
  -- Función para obtener los años de servicio de un empleado
  FUNCTION TRAER_ANIOS(PID NUMBER) RETURN NUMBER
  IS
    MI_RETORNO NUMBER := 0;
  BEGIN
    BEGIN
      -- Consulta para obtener los años de servicio desde la tabla JOB_YEARS
      SELECT YEARS INTO MI_RETORNO
      FROM JOB_YEARS
      WHERE EMPLOYEE_ID = PID;
      RETURN MI_RETORNO;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        MI_RETORNO := 0; -- Si no se encuentra ningún dato, se establece el retorno a 0
    END;
  END TRAER_ANIOS;

  -- Función para obtener los días trabajados de un empleado
  FUNCTION TRAER_DIAS(PID NUMBER) RETURN NUMBER
  IS
    MI_RETORNO NUMBER := 0;
  BEGIN
    BEGIN
      -- Consulta para obtener los días trabajados desde la tabla NUM_DAYS
      SELECT NUM_DAYS INTO MI_RETORNO
      FROM NUM_DAYS
      WHERE EMPLOYEE_ID = PID;
      RETURN MI_RETORNO;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        MI_RETORNO := 0; -- Si no se encuentra ningún dato, se establece el retorno a 0
    END;
  END TRAER_DIAS;

  -- Función para obtener el salario de un empleado
  FUNCTION TRAER_SALARIO(PID NUMBER) RETURN NUMBER
  IS
    MI_RETORNO NUMBER := 0;
  BEGIN
    BEGIN
      -- Consulta para obtener el salario desde la tabla EMPLOYEES
      SELECT SALARY INTO MI_RETORNO
      FROM EMPLOYEES
      WHERE EMPLOYEE_ID = PID;
      RETURN MI_RETORNO;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        MI_RETORNO := 0; -- Si no se encuentra ningún dato, se establece el retorno a 0
    END;
  END TRAER_SALARIO;

  -- Función para verificar si un empleado es jefe
  FUNCTION SOY_JEFE(PID NUMBER) RETURN NUMBER
  IS
    MI_RETORNO NUMBER := 0;
  BEGIN
    BEGIN
      -- Consulta para verificar si el empleado es un jefe (basado en el JOB_ID)
      SELECT 1 INTO MI_RETORNO
      FROM EMPLOYEES E, JOBS J
      WHERE E.EMPLOYEE_ID = PID
      AND (E.JOB_ID LIKE '%MGR%'
      OR E.JOB_ID LIKE '%MAN%')
      AND E.JOB_ID = J.JOB_ID;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        MI_RETORNO := 0; -- Si no se encuentra ningún dato, se establece el retorno a 0
    END;
    RETURN MI_RETORNO;
  END SOY_JEFE;
END PKG_NOMINA;
/

DROP FUNCTION TRAER_DIAS;
DROP FUNCTION TRAER_ANIOS;
DROP FUNCTION TRAER_SALARIO;
DROP FUNCTION SOY_JEFE;
DROP PROCEDURE CALC_SB;