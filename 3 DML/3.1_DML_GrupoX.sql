------------------------------------------------------------------------------------------------
-- DML
------------------------------------------------------------------------------------------------
/* 1
Insertar un empleado llamado James Dexter 
en el departamento de IT Innovation 
que se encuentra en la ciudad de Madrid, Spain
Y como tipo de trabajo: Software Engineering 
*/
insert into countries
values ('SP','Spain',1979);
insert into locations
values (13,'quevia',39600,'Madrid','Madrid','SP');
insert into jobs
values ('SFTE','Software Engineering',15000,350000);
insert into departments
values (123,'IT Innovation',null,13);
insert into employees
values (999,'James','Dexter','JDexter@',null,'11/09/1979','SFTE',null,null,null,123)
/*
Comprobar que se ven los datos insertados de forma conjunta con una JOIN
y no de forma independiente. Con el fin de comprobar las relaciones.
*/
select first_name,last_name,department_name,city,country_name,job_title
from employees
    join departments
        on employees.department_id=departments.department_id
    join locations
        on departments.location_id=locations.location_id
    join country
        on locations.country_id=countries.country_id
    join jobs
        on employees.job_id=jobs.job_id
where first_name='James' and last_name='Dexter';
/* 2
Actualizarle el salario a 60000
*/
update employees
set salary=60000
where first_name='James' and last_name='Dexter';
/* 3
Colocarle una comisión igual a la media de comisiones
Manteniendo dos centésimas como valor.
*/
update employees
set commision_pct=(select round(avg(commission_pct),2) from employees)
where first_name='James' and last_name='Dexter';
/* 4
Anonimizar sus datos personales: nombre, apellido, email, teléfono
*/
update employees
set first_name='Annonimus',last_name='Annonimus',email='Annonimus',phone_number=null
where first_name='James' and last_name='Dexter';