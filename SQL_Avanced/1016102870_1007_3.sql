/*Ejercicio 1 : (Salario Basico)	Salario Basico = (Salary/30)*NumDias	*/
begin;
INSERT INTO PAYROLL (EMPLOYEE_ID, PYD, PYD_VALUE) 
SELECT E.EMPLOYEE_ID
     , 1 CONCEPTO
     , (SALARY/30)*NUM_DAYS SALARIO_BASICO
FROM EMPLOYEES E, NUM_DAYS D
WHERE E.EMPLOYEE_ID= D.EMPLOYEE_ID;

/*Ejercicio 2 : (Prima de antiguedad)		Prima de antiguedad= Si antiguedad entre 0 y 10  ==> 10% del codigo 1
											Si antiguedad entre 11 y 20 ==> 15% del codigo 1
											En los demas casos 20% del codigo 1 */

INSERT INTO PAYROLL (EMPLOYEE_ID, PYD, PYD_VALUE) 
SELECT E.EMPLOYEE_ID, 
       2 AS CONCEPTO,
       CASE
           WHEN J.YEARS BETWEEN 0 AND 10 THEN P.PYD_VALUE * 0.1
           WHEN J.YEARS BETWEEN 11 AND 20 THEN P.PYD_VALUE * 0.15
           ELSE P.PYD_VALUE * 0.2
       END AS CALCULADO
FROM EMPLOYEES E
JOIN PAYROLL P ON E.EMPLOYEE_ID = P.EMPLOYEE_ID
JOIN JOB_YEARS J ON E.EMPLOYEE_ID = J.EMPLOYEE_ID;


/*Ejercicio 3 : (Prima de servicios por jefatura)	Prima de servicios=  Si cargo es jefe, el 20% del codigo 1
													En los demas casos, no hay prima*/
			
INSERT INTO PAYROLL (EMPLOYEE_ID, PYD, PYD_VALUE) 
SELECT E.EMPLOYEE_ID, 
       3 AS CONCEPTO,
       P.PYD_VALUE * 0.2 AS CALCULADO
FROM EMPLOYEES E
JOIN JOBS J ON E.JOB_ID = J.JOB_ID
JOIN PAYROLL P ON E.EMPLOYEE_ID = P.EMPLOYEE_ID
WHERE (E.JOB_ID LIKE '%MGR%' OR E.JOB_ID LIKE '%MAN%')
      AND P.PYD = 1
ORDER BY E.EMPLOYEE_ID;



/*Ejercicio 4 : (Subsidio de alimentacion)	Subsidio de alimentacion= Si asignacion mensual < 3000 ==> SA= (100/30)* NumDias
											En los demas caso, no hay auxilio*/

INSERT INTO PAYROLL (EMPLOYEE_ID, PYD, PYD_VALUE) 
SELECT E.EMPLOYEE_ID, 
       4 AS CONCEPTO,
       ROUND((100 / 30) * D.NUM_DAYS, 2) AS CALCULADO
FROM EMPLOYEES E
JOIN NUM_DAYS D ON E.EMPLOYEE_ID = D.EMPLOYEE_ID
WHERE E.SALARY < 3000;


/* Ejercicio 5	: (Subsidio de transporte)	Subsidio de transporte= Si asignacion mensual < 3000 ==> ST=(80/30)*NumDias
											En los demas casos no hay auxilio*/

INSERT INTO PAYROLL (EMPLOYEE_ID, PYD, PYD_VALUE) 
SELECT E.EMPLOYEE_ID, 
       5 AS CONCEPTO,
       ROUND((80 / 30) * D.NUM_DAYS, 2) AS CALCULADO
FROM EMPLOYEES E
JOIN NUM_DAYS D ON E.EMPLOYEE_ID = D.EMPLOYEE_ID
WHERE E.SALARY < 3000;


/* Ejercicio 10 :	Total devengado= Suma de los codigo 1-9*/

INSERT INTO PAYROLL (EMPLOYEE_ID, PYD, PYD_VALUE)
SELECT EMPLOYEE_ID, 10, SUM(PYD_VALUE)
FROM PAYROLL
WHERE PYD BETWEEN 1 AND 9
GROUP BY EMPLOYEE_ID;

/* Ejercicio 11 : Salud = 12% del codigo 1*/

INSERT INTO PAYROLL (EMPLOYEE_ID, PYD, PYD_VALUE) 
SELECT EMPLOYEE_ID, 11, TRUNC (PYD_VALUE*0.12)
FROM PAYROLL
WHERE PYD=1;

/* Ejercicio 12 :	Pension=16% del codigo 1*/

INSERT INTO PAYROLL (EMPLOYEE_ID, PYD, PYD_VALUE) 
SELECT EMPLOYEE_ID, 12, TRUNC (PYD_VALUE*0.16)
FROM PAYROLL
WHERE PYD=1;

/* Ejercicio 13 : 	ReteFuente= Si asignacion mensual entre 0-1999, ==> 0% del codigo 1
					Si asignacion mensual entre 2000-4999 ==> 5% del codigo 1
					Si asignacion mensual entre 5000-8999 ==> 10% del codigo 1
					Los demas casos ==> 15% del codigo 1*/
					
INSERT INTO PAYROLL (EMPLOYEE_ID, PYD, PYD_VALUE) 
SELECT E.EMPLOYEE_ID, 
       13 AS CONCEPTO,
       ROUND(
           CASE
               WHEN E.SALARY BETWEEN 2000 AND 4999 THEN P.PYD_VALUE * 0.05
               WHEN E.SALARY BETWEEN 5000 AND 8999 THEN P.PYD_VALUE * 0.10
               ELSE P.PYD_VALUE * 0.15
           END, 2
       ) AS CALCULADO
FROM EMPLOYEES E
JOIN PAYROLL P ON E.EMPLOYEE_ID = P.EMPLOYEE_ID
WHERE P.PYD = 1;


/* Ejercicio 20 : 	Total deducido= Suma de los codigo 11-19*/

INSERT INTO PAYROLL (EMPLOYEE_ID, PYD, PYD_VALUE) 
SELECT EMPLOYEE_ID, 20, SUM(PYD_VALUE) 
	FROM PAYROLL
		WHERE PYD BETWEEN 11 AND 19
GROUP BY EMPLOYEE_ID;

/* Ejercicio 30 :	Neto= Total devengado - total deducido*/

INSERT INTO PAYROLL (EMPLOYEE_ID, PYD, PYD_VALUE)
SELECT E.EMPLOYEE_ID, 
       30 AS CONCEPTO,
       P.PYD_VALUE - D.PYD_VALUE AS CALCULADO
FROM EMPLOYEES E
JOIN PAYROLL P ON E.EMPLOYEE_ID = P.EMPLOYEE_ID
JOIN PAYROLL D ON E.EMPLOYEE_ID = D.EMPLOYEE_ID
WHERE P.PYD = 10 AND D.PYD = 20;

COMMIT;





