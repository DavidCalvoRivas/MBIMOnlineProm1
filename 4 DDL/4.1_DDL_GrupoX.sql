------------------------------------------------------------------------------------------------
-- DDL
------------------------------------------------------------------------------------------------
/* 
Se desea tener una base de datos con la información de instalaciones/edificios (falicities).
-Información acerca de las plantas, nombre, categoria, descripción, GUID (Global Unique identifier), altura.
-Sobre los espacios, nombre, categoria, descripción, altura usable, area, GUID
-componentes, nombre, descripción, GUID, numero de serie, fecha de instalación
-tipo de componentes, nombre, descripción, modelo, GUID, material, color, años de garantia

1-Generar las siguientes tablas
FACILITIES
id
guid
name
description
category
address
    create table FACILITIES(
    id number,
    guid varchar2(1000),
    name varchar2(1000) not null,
    description varchar2(1000),
    category varchar2(1000),
    addres varchar2(1000),
    constraint uq_fac_id primary key(id),
    constraint uq_fac_name unique(name),
    constraint uq_fac_guid unique(guid)
    );  
Create table 
FLOORS
id
guid
name
category
description
height
facilityId
    create table FLOORS(
    id number,
    guid varchar2(1000),
    name varchar2(1000) not null,
    category varchar2(1000),
    description varchar2(1000),
    height number,
    facilityId number,
    constraint pk_flo_id primary key(id),
    constraint uq_flo_name unique(name),
    constraint uq_flo_guid unique(guid));
SPACES
id
guid
name
category
description
usableHeight
area
floorId
    create table SPACES(
    id number,
    guid varchar2(1000),
    name varchar2(1000) not null,
    category varchar2(1000),
    description varchar2(1000),
    usableHeight number,
    area number,
    floorId number,
    constraint pk_spa_id primary key(id),
    constraint uq_spa_guid unique(guid),
    constraint uq_spa_floorId unique(floorId),
    constraint uq_spa_name unique(name));
COMPONENTS
id
guid
name
description
serialNumber
installatedOn
spaceId
typeId
    create table COMPONENTS(
    id number,
    guid varchar2(1000),
    name varchar2(1000) not null,
    description varchar2(1000),
    serialNumber number,
    installatedOn date default sysdate,
    spaceId number,
    typeId number,
    constraint pk_com_id primary key(id),
    constraint uq_com_guid unique(guid),
    constraint uq_com_serialNumber unique(serialNumber),
    constraint uq_com_spaceId unique(spaceId),
    constraint uq_com_typeId unique(typeId),
    constraint uq_com_name unique(name));
TYPES
id
guid
name
description
modelNumber
color
warrantyYears
    create table TYPES(
    id number,
    guid varchar2(1000),
    name varchar2(1000) not null,
    description varchar2(1000),
    modelnumber number,
    color varchar2(1000),
    warrantyYears number,
    constraint pk_typ_id primary key(id),
    constraint uq_typ_name unique(name),
    constraint uq_typ_guid unique(guid),
    constraint ch_typ_wYears check(warrantyYears>=0));

En las definiciones establacer las siguientes restricciones
-Los guid deben ser únicos.
-No es posible dar de alta un componente sin un tipo.
-No es posible dar de alta un espacio sin una planta.
-No es posiblde dar de alta una planta sin un facility.
-Dos componentes no pueden llamarse igual, lo mismo pasa con el resto de entidades.
-La fecha de instalación de un componente por defecto es la actual.
-Los nombres no pueden estar vacíos en todas las entidades.
-Los años de garantia no pueden ser cero ni negativos.
-Se debe mantener la integridad referencial.

NOTA: Algunos ejercicios provocan errores que deben probar (para ver el error) y corregir.
*/
