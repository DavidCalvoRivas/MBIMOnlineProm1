------------------------------------------------------------------------------------------------
--SELECTS SIMPLES
------------------------------------------------------------------------------------------------
/* 1
Describir la tabla employees
*/desc employees;
/* 2
Describir la tabla departments
*/
desc departments;
/* 3
Describir la tabla locations
*/
desc locations;
/* 4
Datos de la tabla regions
*/
select * from regions;
/* 5
Datos de la tabla countries
*/
select * from countries;
/* 6
Ciudad y estado de las localidades
*/
select CITY,STATE_PROVINCE from locations;
/* 7
Nombre, apellido, salario de los empleados
*/
select FIRST_NAME,LAST_NAME,SALARY from employees;
/* 8
Número de departamento, nombre, y manager_id de los departamentos
*/
select DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID from departments
/* 9
Número y nombre de departamento, además, el código del empleado jefe,
de la localidad 1700.
*/
select DEPARTMENT_ID,DEPARTMENT_NAME,manager_id
from departments where location_id=1700;
/* 10
Nombre y número de departamento de los empleados.
*/
select first_name,department_id from employees;
/* 11
Nombre y número de departamento de los empleados
ordenados por número de departamento ascendentemente.
*/
select first_name,department_id from employees
order by department_id asc;
/* 12
Listar los distintos números de departamento en el que trabajan los empleados.
*/
select distinct department_id from employees
order by department_id asc;
/* 13
Listar los distintos números de departamento en el que trabajan los empleados
ordenados descendentemente.
*/
select distinct department_id from employees
order by department_id desc;
/* 14
Nombre, apellido y salario ordenados por id de empleado descendentemente
*/
select first_name||' '||last_name,salary from employees
order by employee_id desc;
/* 15
Nombre, apellido y salario ordenado por apellido ascendentemente y salario descendentemente
*/
select first_name||' '||last_name Nombre,salary 
from employees
order by last_name asc,salary desc;
/* 16
códigos de los distintos trabajos que existen en el departamento 30
*/
select distinct job_id
from employees
where department_id=30;
/* 17
códigos de los distintos trabajos que existen en el departamento 60
ordenados descendentemente
*/
select distinct job_id
from employees
where department_id=60
order by job_id desc;
/* 18
Nombre, apellido y correo de los empleados del departamento 30
cuyo salario es menor a 3000
*/
select first_name,last_name,email 
from employees 
where department_id=30 and salary<3000
/* 19
Nombre, apellido y correo de los empleados del departamento 30
cuyo salario es menor a 3000
o que sean del departamento 90
*/
select first_name,last_name,email 
from employees 
where (department_id=30 and salary<3000) or department_id=90;
/* 20
nombre, apellido y número de departamento de los empleados
que no tengan comisión. Ordenados por número de departamento 
del mayor a menor y por apellido descendentemente.
*/
select first_name,last_name,department_id 
from employees 
where commission_pct is null
order by department_id desc,last_name desc;
/* 21
nombre, apellido, número de departamento y salario de los empleados
que no tengan comisión o su salario sea menor a 6000 
y que se cumpla que son del departamento 60 o del 90
ordenados por número de departamento descendentemente
y por salario ascendentemente.
*/
select first_name,last_name,department_id,salary
from employees 
where (commission_pct is null or salary<6000) and department_id in (60,90)
order by department_id desc,salary asc;
/* 22
Número de empleado, nombre y apellido de los empleados
desde el apellido que empieza por L hasta los que su apellido
empieza por la R, incluidos.
*/
select first_name,last_name,employee_id
from employees 
where substr(last_name,1,1)>='L' and substr(last_name,1,1)<='R';
/* 23
Lista de apellidos que su segunda letra sea una 'a'
*/
select last_name
from employees
where last_name LIKE '_a%';
/* 24
Lista de apellidos de empleados donde el apellido empieza por alguna vocal
y que su salario es menor a 3000 o mayor a 9000
y debe cumplirse que su departamento es el 30, 60 o 90.
*/
select last_name
from employees
where substr(last_name,2,1) in ('a','e','i','o','u') 
and department_id in (30,60,90) 
and (salary>9000 or salary<3000);
/* 25
Nombre, apellido y el salario de los empleados
pero como salario una etiqueta que indique 
'BAJO' si es menor a 4280, 'ALTO' si es mayor a 15230
y 'MEDIO' si está entre medias
*/
select first_name,last_name,
CASE
WHEN salary<4280 then 'ALTO'
WHEN salary between 4280 and 15230 then 'MEDIO'
ELSE 'BAJO'
END
salary
from employees;
/* 26
Listar los correos concatenados con el texto '@company.com'
*/
select email||'@company.com'
from employees;
/* 27
Lista de nombres de las ciudades que su país es 'US'
*/
Select city
from locations
where country_id='US';
/* 28
Lista de nombre de las ciudades que su país no es Estados Unidos
*/
Select city
from locations
where country_id!='US';
/* 29
Número y nombre de los departamentos que tienen un jefe.
*/
SELECT department_id,department_name
from departments
where manager_id is not null;
/* 30
Número y nombre de los departamentos que no tienen jefe.
*/
SELECT department_id,department_name
from departments
where manager_id is null;
/* 31
Nombre de las columnas de la tabla de empleados 'Employees'
que no tienen un guión bajo en el nombre.
*/
select column_name, table_name
from user_tables
where   
        table_name='EMPLOYEES' 
        and 
        column_name not like '%_%';
--
------------------------------------------------------------------------------------------------
