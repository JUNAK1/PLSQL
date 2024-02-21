/*
Juan Camilo Serrano Correa
07/10/2023
Ejercicios SQL 
*/
/*
Salario Basico
1	Salario Basico = (Salary/30)*NumDias
*/

INSERT INTO PAYROLL (EMPLOYEE_ID, PYD, PYD_VALUE) 
SELECT E.EMPLOYEE_ID
     , 1 CONCEPTO
     , (SALARY/30)*NUM_DAYS SALABASICO
FROM EMPLOYEES E, NUM_DAYS D
WHERE E.EMPLOYEE_ID= D.EMPLOYEE_ID;
/*

Prima de antiguedad
2	Prima de antiguedad= Si antiguedad entre 0 y 10  ==> 10% del codigo 1
						 Si antiguedad entre 11 y 20 ==> 15% del codigo 1
						 En los demas casos 20% del codigo 1*/


INSERT INTO PAYROLL (EMPLOYEE_ID, PYD, PYD_VALUE) 
SELECT E.EMPLOYEE_ID, 2, P.PYD_VALUE*0.1
FROM EMPLOYEES E, PAYROLL P, JOB_YEARS J
WHERE E.EMPLOYEE_ID= P.EMPLOYEE_ID
AND P.EMPLOYEE_ID= J.EMPLOYEE_ID
AND J.YEARS BETWEEN 0 AND 10
UNION
SELECT E.EMPLOYEE_ID, 2, P.PYD_VALUE*0.15
FROM EMPLOYEES E, PAYROLL P, JOB_YEARS J
WHERE E.EMPLOYEE_ID= P.EMPLOYEE_ID
AND P.EMPLOYEE_ID= J.EMPLOYEE_ID
AND J.YEARS BETWEEN 11 AND 20
UNION
SELECT E.EMPLOYEE_ID, 2, P.PYD_VALUE*0.2
FROM EMPLOYEES E, PAYROLL P, JOB_YEARS J
WHERE E.EMPLOYEE_ID= P.EMPLOYEE_ID
AND P.EMPLOYEE_ID= J.EMPLOYEE_ID
AND J.YEARS >20;
Prima de servicios por jefatura

--3	Prima de servicios=  Si cargo es jefe, el 20% del codigo 1
						-- En los demas casos, no hay prima
INSERT INTO PAYROLL (EMPLOYEE 1D, PYD, PYD VALUE) 
SELECT E. EMPLOYEE ID, 3, P.PYD VALUE*0.2
FROM EMPLOYEES E, JOBS J, PAYROLL P
WHERE (E. JOB ID LIKE MGR
OR E. JOB ID LIKE 'MANS')
AND E.JOB ID = J. JOB ID
AND E. EMPLOYEE ID = P. EMPLOYEE ID
AND P.PYD=1
ORDER BY 1;

--Subsidio de alimentacion
--4	Subsidio de alimentacion= Si asignacion mensual < 3000 ==> SA= (100/30)* NumDias
							 -- En los demas caso, no hay auxilio
INSERT INTO PAYROLL (EMPLOYEE_ID, PYD, PYD VALUE) 
SELECT E.EMPLOYER ID, 4, ROUND ((100/30)*NUM_DAYS, 2) 
FROM EMPLOYEES E, NUM DAYS D
WHERE E.SALARY<3000
AND E.EMPLOYEE_ID=D.EMPLOYEE ID;

--5	Subsidio de transporte= Si asignacion mensual < 3000 ==> ST=(80/30)*NumDias
							--En los demas casos no hay auxilio
INSERT INTO PAYROLL (EMPLOYEE_ID, PYD, PYD_VALUE) 
SELECT E. EMPLOYEE ID, 5, ROUND ((80/30) *NUM DAYS,2)
FROM EMPLOYEES E, NUM DAYS D
WHERE E.SALARY<3000
AND E.EMPLOYEE_ID=D. EMPLOYEE ID;

--10	Total devengado= Suma de los codigo 1-9

INSERT INTO PAYROLL (EMPLOYEE_ID, PYD, PYD_VALUE)
SELECT EMPLOYEE_ID, 10, SUM(PYD_VALUE)
FROM PAYROLL
WHERE PYD BETWEEN 1 AND 9
GROUP BY EMPLOYEE_ID;

--11	Salud = 12% del codigo 1

INSERT INTO PAYROLI. (EMPLOYEE TD, PYD, PYD VALUE) 
SELECT EMPLOYEE ID, 11, TRUNC (PYD) VALUE*0.12)
FROM PAYROLL
WHERE PYD=1;

--12	Pension=16% del codigo 1

INSERT INTO PAYROLI. (EMPLOYEE TD, PYD, PYD VALUE) 
SELECT EMPLOYEE ID, 12, TRUNC (PYD) VALUE*0.16)
FROM PAYROLL
WHERE PYD=1;

/*13  ReteFuente= Si asignacion mensual entre 0-1999, ==> 0% del codigo 1
				Si asignacion mensual entre 2000-4999 ==> 5% del codigo 1
				Si asignacion mensual entre 5000-8999 ==> 10% del codigo 1
				Los demas casos ==> 15% del codigo 1
	*/
SELECT E. EMPLOYEE_ID, 13, ROUND (P.PYD_VALUE*0.05,2)
FROM EMPLOYEES E, PAYROLL P
WHERE E.EMPLOYEE_ID= P.EMPLOYEE_ID
AND P.PYD=1
AND E.SALARY BETWEEN 2000 AND 4999
UNION
SELECT E. EMPLOYEE_ID, 13, ROUND (P.PYD VALUE*0.10,2)
FROM EMPLOYEES E, PAYROLL P
WHERE E.EMPLOYEE_ID= P.EMPLOYEE_ID
AND P.PYD=1
AND E.SALARY BETWEEN 5000 AND 8999
UNION
SELECT E. EMPLOYEE_ID, 13, ROUND (P. PYD VALUE*0.15,2)
FROM EMPLOYEES E, PAYROLL P
WHERE E.EMPLOYEE ID= P. EMPLOYEE ID
AND P.PYD=1
AND E.SALARY > 8999;

--20 	Total deducido= Suma de los codigo 11-19
--0 Total deducido Suma de los codigo 11-19

INSERT INTO PAYROLL (EMPLOYEE ID, PYD, PYD VALUE) 
SELECT EMPLOYEE_ID, 20, SUM(PYD VALUE) 
FROM PAYROLL
WHERE PYD BETWEEN 11 AND 19
GROUP BY EMPLOYEE_ID;

--30 Neto =Total devengado - total deducido

INSERT INTO PAYROLL (EMPLOYEE_ID, PYD, PYD_VALUE)
SELECT E. EMPLOYEE_ID, 30, P.PYD VALUE - D. PYD VALUE
FROM EMPLOYEES E, PAYROLL P, PAYROLL D
WHERE E. EMPLOYEE ID=P. EMPLOYEE ID
AND E. EMPLOYEE ID= D. EMPLOYEE ID
AND P.PYD=10 AND D.PYD=20;
