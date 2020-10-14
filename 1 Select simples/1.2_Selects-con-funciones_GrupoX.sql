------------------------------------------------------------------------------------------------
-- SELECT CON FUNCIONES
------------------------------------------------------------------------------------------------
/* 1
Mostrar la fecha actual de la siguiente forma:
Fecha actual
------------------------------
Sábado, 11 de febrero de 2017. 16:06:06

El día en palabras con la primera letra en mayúsculas, seguida de una coma, el día en números,
la palabra "de", el mes en minúscula en palabras, la palabra "de", el año en cuatro dígitos
finalizando con un punto. Luego la hora en formato 24h con minutos y segundos.
Y de etiqueta del campo "Fecha actual".
*/

/* 2
Día en palabras en el cual naciste
*/

/* 3
La suma de salarios, cuál es el mínimo, el máximo y la media de salario
*/
Select
        Sum(salary),Min(salary),max(salary),trunc(avg(salary),2)
from employees;
/* 4
Cuántos empleados hay, cuántos tienen salario y cuántos tienen comisión.
*/
Select count(employee_id),count(salary),count(commission_pct)
from employees;
/* 5
Por un lado la media entre la media de salarios y el mínimo salario
Y por otro lado, la media entre la media de salarios y el máximo salario
Solo la parte entera, sin decimales ni redondeo.
*/
Select trunc(AVG(salary)/min(salary),0),trunc(avg(salary)/max(salary),0)
from employees;
/* 6
Listar el número de departamento y el máximo salario en cada uno de ellos.
*/
select department_id,max(salary)
from employees
group by department_id;
/* 7
Mostrar los nombres de los empleados que se repiten indicando cuántos hay del mismo
en orden descendente.
*/
select first_name,count(first_name)
from employees
group by first_name
having count(first_name)>1
order by 2 desc;
/* 8
Mostrar en una fila cuántos empleados son jefes de departamento
y en otra fila cuántos son jefes de otros empleados.
*/

/* 9
Listar nombre, apellido de los empleados que les coindice a la vez
la primera letra de su nombre y el apellido
*/

/* 10
Número de empleados dados de alta por día
ordenados descendentemente por la fecha
*/

/* 11
Un listado por año de la media de salarios
de los empleados que ingresaron ese año
ordenados de forma descendente por año
*/

/* 12
Nombre del día en el que más empleados
se han dado de alta
*/

------------------------------------------------------------------------------------------------
