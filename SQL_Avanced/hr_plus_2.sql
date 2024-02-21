*/
CREATE TABLE concepts
(concept_id     NUMBER(4) NOT NULL
,name           VARCHAR2(30) NOT NULL
,description    VARCHAR2(500));

ALTER TABLE concepts ADD CONSTRAINT concepts_pk PRIMARY KEY (concept_id);

CREATE TABLE payroll
AS
SELECT employee_id
       ,999999 pyd
	   ,salary pyd_value
FROM employees
WHERE 1=2; 
-- WHERE 1=2 Condicion falsa para solo crear la estructura de la tabla

ALTER TABLE payroll ADD CONSTRAINT payroll_emp_fk FOREIGN KEY (employee_id) REFERENCES employees(employee_id);

ALTER TABLE payroll ADD CONSTRAINT payroll_pyd_fk FOREIGN KEY (pyd) REFERENCES concepts;

ALTER TABLE payroll ADD CONSTRAINT payroll_pk PRIMARY KEY (employee_id, pyd);

INSERT INTO concepts(concept_id,name) VALUES (1,'Salario Basico');
INSERT INTO concepts(concept_id,name) VALUES (2,'Prima de antiguedad');
INSERT INTO concepts(concept_id,name) VALUES (3,'Prima de servicios');
INSERT INTO concepts(concept_id,name) VALUES (4,'Subsidio de alimentacion');
INSERT INTO concepts(concept_id,name) VALUES (5,'Subsidio de transporte');
INSERT INTO concepts(concept_id,name) VALUES (10,'Total devengado');
INSERT INTO concepts(concept_id,name) VALUES (11,'Salud');
INSERT INTO concepts(concept_id,name) VALUES (12,'Pension');
INSERT INTO concepts(concept_id,name) VALUES (13,'ReteFuente');
INSERT INTO concepts(concept_id,name) VALUES (20,'Total deducido');
INSERT INTO concepts(concept_id,name) VALUES (30,'Neto');
COMMIT;

CREATE TABLE desprendible
(employee_id NUMBER
,linea NUMBER
,texto VARCHAR2(100));
  
ALTER TABLE desprendible 
ADD CONSTRAINT desprendible_pk PRIMARY KEY (employee_id, linea); 

/*
Numero de dias laborados durante el mes a pagar
*/
CREATE TABLE num_days
AS
SELECT employee_id
      , 9999 num_days
FROM employees
WHERE 1=2;

ALTER TABLE num_days 
ADD CONSTRAINT num_days_pk PRIMARY KEY(employee_id);

/*
Generar valores para la tabla del numero de dias laborados
*/
INSERT INTO num_days(employee_id,num_days)
SELECT employee_id
     , DECODE(SIGN(10-days),1,days+10,days)
FROM (
SELECT employee_id,TO_NUMBER(TO_CHAR(hire_date,'dd')) days
FROM employees);
/*
Vista mostrando los años laborados por los empleados, 
dato usado para calcular la prima de antiguedad
*/
CREATE OR REPLACE VIEW job_years
AS
SELECT employee_id
     , ROUND(MONTHS_BETWEEN(SYSDATE,hire_date)/12,0) years
FROM employees;

CREATE TABLE job_grades
 (grade_level  VARCHAR2(2)
  ,lowest_sal  NUMBER(10,2)
  ,highest_sal NUMBER(10,2)
  );
  
INSERT INTO job_grades VALUES ('A',1000,2999);
INSERT INTO job_grades VALUES ('B',3000,5999);
INSERT INTO job_grades VALUES ('C',6000,9999);
INSERT INTO job_grades VALUES ('D',10000,14999);
INSERT INTO job_grades VALUES ('E',15000,24999);
INSERT INTO job_grades VALUES ('F',25000,40000);

INSERT INTO job_grades VALUES ('X',0,999);

COMMIT;

CREATE TABLE parametros
(nombre VARCHAR2(100) CHECK(nombre=UPPER(nombre))
,valor  NUMBER);

INSERT INTO parametros VALUES ('LIMITE AUX. ALIMENTACION', 3000);
INSERT INTO parametros VALUES ('LIMITE AUX. TRANSPORTE',3000 );
INSERT INTO parametros VALUES ('AUX. ALIMENTACION', 100);
INSERT INTO parametros VALUES ('AUX. TRANSPORTE',80 );