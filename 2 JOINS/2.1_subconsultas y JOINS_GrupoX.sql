------------------------------------------------------------------------------------------------
-- SELECT con suncolsultas y JOINS
------------------------------------------------------------------------------------------------
-- 1
-- Nombre y apellido del empleado que más gana.
select first_name,last_name,salary
from employees
where salary=(select max(salary) from employees);
-- 2
-- Nombre, apellido y salario de los empleados que ganan más que la media de salarios.
select first_name,last_name,salary
from employees
where salary>(select avg(salary) from employees);
-- 3
-- Nombre y apellido del jefe del departamento de Marketing
select first_name,last_name
from employees
join departments
on employees.manager_id=departments.manager_id
where departments.manager_id=(select manager_id
                                from departments
                                where department_name='Marketing');
-- 4
-- Nombre y apellido  de los empleados del departamento de Marketing
select first_name,last_name
from employees
join departments
on employees.department_id=departments.department_id
where departments.department_id=(select department_id
                                from departments
                                where department_name='Marketing');
-- 5
-- Nombre, apellido, salario, nombre del departamento y ciudad
-- del empleado que gana más y el que menos
select first_name,last_name,salary,department_name,city
from employees
Join departments
on departments.department_id=employees.department_id
join locations
on locations.location_id=departments.location_id
where salary=(select max(salary) from employees) or salary=(select min(salary) from employees);
-- 6
-- Número de empleados y número de departamentos por ciudad (nombre)
select city,count(employee_id),count(departments.department_id)
from locations
join departments
on locations.location_id=departments.location_id
join employees
on departments.department_id=employees.department_id
group by city;
-- 7
-- Número de empleados y número de departamentos de todas las ciudades (nombre)
-- ordenado por número de empleados descendentemente
select city,count(employee_id),count(departments.department_id)
from locations
join departments
on locations.location_id=departments.location_id
join employees
on departments.department_id=employees.department_id
group by city
order by 2 desc;
-- 8
-- Mostrar el número de empleado, nombre y apellido de los empleados
-- que sean jefes tanto como de departamento como de otro empleado
-- indicando en una sola columna con un literal 'DEP' si es jefe de departamento
-- y 'EMP' si es jefe de otro empleado. Ordenados por número de empleado.
select First_name,last_name,
Case
when employee_id in (select manager_id from employees) then 'EMP'
else 'DEP'
end JEFE
from employees
where employee_id in (select manager_id from employees) or employee_id in (select manager_id from departments)
order by employee_id desc;
-- 9
-- Listar el nombre, apellido y salario de los tres empleados que ganan más
select rownum,Orden,first_name,last_name,salary
from (select rownum Orden,first_name,last_name,salary
        from employees
        order by salary desc)
where rownum<4;
-- 10
-- Imaginad que queremos crear nombres de usuario para direcciones de correo.
-- Cuyo formato es la primera letra del nombre más el apellido.
-- Queremos saber si del listado de nombres y apellidos alguien coinciden
select Email,count(email),
case when count(email)>1 then 'Repetido'
else 'No_Repetido'
end Repetidos
from
(select substr(first_name,1,1)||last_name Email
from employees)
group by email
order by 1 desc;
-- 11
-- Listar nombre, apellido y un literal que indique el salario.
-- 'BAJO' si el salario es menor a la mediabaja (media entre el salario mínimo y la media de salarios)
-- 'ALTO' si el salario es mayor a la mediaalta (media entre el salario máximo y la media de salarios)
-- 'MEDIO' si el salario está entre la mediabaja y medialata.
select first_name,last_name,
case
when salary<MediaBaja then 'BAJO'
when salary>MediaAlta then 'ALTO'
else 'MEDIO'
end Salario
from employees,(select round((avg(salary)+max(salary))/2,2) MediaAlta,max(salary),min(salary),round((avg(salary)+min(salary))/2,2) MediaBaja
from employees);
-- 12
-- Número de empleados dados de alta por día
-- entre dos fechas. Ej: entre 1997-10-10 y 1998-03-07
-- y para una o varias ciudades. Ej: Seattle, Rome
-- (Pensad que es una consulta que se va adaptar a variables
-- es decir, que las ciudades o el rango de fechas varia
-- en la parte visual de la aplicación se muestran desplegables
-- para escoger los valores, pero luego eso se reemplaza en la consulta)
-- Aquí usamos valores fijos de ejemplo.
select count(Fecha_Alta)
from (select hire_date Fecha_Alta,city Ciudad
from employees
join departments on employees.department_id=departments.department_id
join locations on departments.location_id=locations.location_id
order by city desc)
where Fecha_Alta<='03/07/98' and Fecha_Alta>='10/10/97' and Ciudad in('Seattle','Southlake');
-- 13
-- Un listado en el que se indique en líneas separadas
-- una etiqueda que describa el valor y como valor:
-- el número de empleados en Seattle, 
-- el número de departamentos con empleados en Seattle
-- el número de departamentos sin empleados en Seattle
-- el número de jefes de empleado en Seattle
-- el número de jefes de departamento en Seattle
Select count(distinct employee_id) SEATTLE
from employees
right join departments on employees.department_id=departments.department_id
join locations on departments.location_id=locations.location_id
where city='Seattle'
UNION ALL
select count(distinct departments.department_id)
from employees
right join departments on employees.department_id=departments.department_id
join locations on departments.location_id=locations.location_id
where city='Seattle' and employee_id is null
UNION ALL
select count(distinct departments.department_id)
from employees
right join departments on employees.department_id=departments.department_id
join locations on departments.location_id=locations.location_id
where city='Seattle' and employee_id is not null
UNION ALL
Select count(distinct departments.manager_id)
from departments
join locations on departments.location_id=locations.location_id
where city='Seattle'
UNION ALL
Select count(distinct employees.manager_id)
from employees
right join departments on employees.department_id=departments.department_id
join locations on departments.location_id=locations.location_id
where city='Seattle';
-- 14
-- Nombre, apellido, email, department_name
-- de los empleados del departamento con más empleados
select first_name,last_name,email,department_name
from employees
join departments on employees.department_id=departments.department_id
where employees.department_id=(select department_id from (select department_id,count(distinct employee_id) Nº_empleados
                            from employees
                            group by department_id)
                            where nº_empleados=(select max(nº_empleados) from (select department_id,count(distinct employee_id) Nº_empleados
                            from employees
                            group by department_id)));
-- 15
-- Cuál es la fecha en la que más empleados
-- se han dado de alta
select hire_date Fecha_Mayor_NºAltas
from (select hire_date,count(employee_id) Altas
        from employees
        group by hire_date)
where Altas=(select max(Altas) from (select hire_date,count(employee_id) Altas
                                    from employees
                                    group by hire_date));
------------------------------------------------------------------------------------------------
