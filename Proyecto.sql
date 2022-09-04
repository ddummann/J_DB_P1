-- In case u want to drop any of the tables, here are already each one of the the respectives commands

drop table Area cascade constraints;
drop table Articulo cascade constraints;
drop table Autor cascade constraints;
drop table ArticuloXArea cascade constraints;
drop table AutoresXArticulo cascade constraints;
drop table Referencias cascade constraints;
drop table Revista cascade constraints;
drop table Publicacion cascade constraints;
drop sequence codArea; 
drop sequence codArticulo ;
drop sequence codAutor;
drop sequence codRevista;

create table Area(
    codArea number(3,0) not null,
    nameArea varchar(40) not null,
    primary key(codArea)
);

create sequence codArea START WITH 1; -- Para que el codigo no se repite y se auto-incremente desde 1 lol

create table Articulo(
    codArticulo number(3, 0) not null, 
    nameArticulo varchar(100) not null,
    publishedDate date not null,
    primary key(codArticulo)
);
create sequence codArticulo START WITH 99 INCREMENT BY 2;

create table ArticuloXArea(
    codArea number(3,0) not null,
    codArticulo number(3, 0) not null,
    primary key(codArea, codArticulo)
);

create table Autor(
    codAutor number(4, 0) not null,
    nameAutor varchar(25) not null,
    lastNameAutor varchar(25) not null,
    bithDateAutor date,
    emailAdress varchar(40) not null check (emailAdress like '%_@__%.__%' -- if username has a '_', it doesnt allow the insert and shows an error, ask to the professor
    ),
    primary key (codAutor)
);
create sequence codAutor START WITH 1000;

create table AutoresXArticulo(
    codAutor number(4, 0) not null,
    codArticulo number(3, 0) not null,
    rol char(1) check ( rol = 'P' or rol = 'C' ),
    constraint FK_CAMPO_TABLAORIGEN_CAMPO_TABLADESTINO foreign key(codAutor) references Autor, 
    foreign key(codArticulo) references Articulo, 
    primary key(codAutor, codArticulo)
);

create table Referencias(
    codArtiRef1 number(3, 0) not null,
    foreign key(codArtiRef1) references Articulo,
    codArtiRef2 number(3, 0) not null,
    foreign key(codArtiRef2) references Articulo,
    primary key(codArtiRef1, codArtiRef2)
);

create table Revista(
    codRevista number(3, 0),
    createdDate date,
    nameRevista varchar(50),
    categoryRevista varchar(2) check (
        categoryRevista = 'A1' or categoryRevista = 'A2' or categoryRevista = 'B' or categoryRevista = 'C'
    ),
    primary key (codRevista)
);
create sequence codRevista START WITH 1 INCREMENT BY 4;

create table Publicacion(
    codRevista number(3, 0) not null,
    codArticulo number(3, 0) not null, 
    publishedDate_p date not null,
    primary key (codRevista, codArticulo, publishedDate_p),
    foreign key (codRevista) references Revista,
    foreign key (codArticulo) references Articulo
);



/* INSERTERS */ 
-- VALUES THAT ARE IN THE PROJECT STATEMENT AS EXAMPLES 

-- Areas
insert into Area values (codArea.NEXTVAL, 'Matematicas');
insert into Area values (codArea.NEXTVAL, 'Computacion');
insert into Area values (codArea.NEXTVAL, 'Ciencias de la Informacion');
insert into Area values (codArea.NEXTVAL, 'Ingenieria Civil');
insert into Area values (codArea.NEXTVAL, 'Ingenieria Mecanica');

-- Articles
insert into Articulo values (codArticulo.NEXTVAL, 'MER', to_date('22/08/2020', 'DD/MM/YYYY'));
insert into Articulo values (codArticulo.NEXTVAL, 'Corrupcion en LatinoAmerica', to_date('22/08/2008', 'DD/MM/YYYY'));
insert into Articulo values (codArticulo.NEXTVAL, 'Corrupcion en Colombia', to_date('22/08/2018', 'DD/MM/YYYY'));
insert into Articulo values (codArticulo.NEXTVAL, 'El futbol desde la optica fisica', to_date('22/08/2010', 'DD/MM/YYYY'));

-- Article X Area
insert into ArticuloXArea values (3, 100);
insert into ArticuloXArea values (1, 103);
insert into ArticuloXArea values (11, 101);
insert into ArticuloXArea values (10, 101);
insert into ArticuloXArea values (11, 102);
insert into ArticuloXArea values (10, 102);

-- Autors
insert into Autor values (codAutor.NEXTVAL, 'Pedro', 'Perez', to_date('01/01/1980', 'DD/MM/YYYY'), 'pedritop@gmail.com');
insert into Autor values (codAutor.NEXTVAL, 'Maria', 'Perez', to_date('01/01/2000', 'DD/MM/YYYY'), 'mari000@hotmail.com');
insert into Autor values (codAutor.NEXTVAL, 'Juan', 'Vasquez', to_date('02/12/2001', 'DD/MM/YYYY'), 'VasquezWarrior21@gmail.com');
insert into Autor values (codAutor.NEXTVAL, 'Juan', 'Perez', to_date('01/01/1960', 'DD/MM/YYYY'), 'juanitop@outlook.com');

/*delete from AutoresXArticulo;
ALTER TABLE AutoresXArticulo MODIFY rol varchar2(1);*/
-- Autors X Article
insert into AutoresXArticulo values (1002, 100, 'P');
insert into AutoresXArticulo values (1003, 102, 'C');
insert into AutoresXArticulo values (1003, 101, 'P');
insert into AutoresXArticulo values (1004, 103, 'C');

-- References
insert into Referencias values (101, 102);
insert into Referencias values (103, 100);

-- Magazine
insert into Revista values (codRevista.NEXTVAL, to_date('11/03/2002', 'DD/MM/YYYY'), 'ASTROPHYS J', 'A2');
insert into Revista values (codRevista.NEXTVAL, to_date('23/12/2012', 'DD/MM/YYYY'), 'CELL', 'C');
insert into Revista values (codRevista.NEXTVAL, to_date('08/05/2004', 'DD/MM/YYYY'), 'SCIENCE', 'B');
insert into Revista values (codRevista.NEXTVAL, to_date('29/02/2020', 'DD/MM/YYYY'), 'J BIOL CHEM', 'A1');

-- Publication
insert into  Publicacion values (9, 100, to_date('08/05/2004', 'DD/MM/YYYY'));
insert into  Publicacion values (1, 103, to_date('11/03/2002', 'DD/MM/YYYY'));
insert into  Publicacion values (5, 101, to_date('23/12/2012', 'DD/MM/YYYY'));
insert into  Publicacion values (5, 102, to_date('23/12/2012', 'DD/MM/YYYY'));


-- THE VALUES HERE ARE INVENTED

-- Areas
insert into Area values (codArea.NEXTVAL, 'Matematica');
insert into Area values (codArea.NEXTVAL, 'Ciencias Fisicas');
insert into Area values (codArea.NEXTVAL, 'Ciencias Quimicas');
insert into Area values (codArea.NEXTVAL, 'Medicina');
insert into Area values (codArea.NEXTVAL, 'Psicologia');
insert into Area values (codArea.NEXTVAL, 'Derecho');
insert into Area values (codArea.NEXTVAL, 'Lenguas');
insert into Area values (codArea.NEXTVAL, 'Agricultura');

-- Articles
insert into Articulo values (codArticulo.NEXTVAL, 'Un gran avance en la memoria de los ordenadores', to_date('09/09/2018', 'DD/MM/YYYY')); --referenciado
insert into Articulo values (codArticulo.NEXTVAL, 'Memoria, una realidad informática', to_date('08/08/2020', 'DD/MM/YYYY')); --el que lo referencia


-- Article X Area
insert into ArticuloXArea values (2, 104);

-- Autors
insert into Autor values (codAutor.NEXTVAL, 'Marta', 'Nieto', to_date('08/12/1974', 'DD/MM/YYYY'), 'martanietoge80@gmail.com'); --autora del mismo
insert into Autor values (codAutor.NEXTVAL, 'Miranda', 'Croosgrove', to_date('08/12/1976', 'DD/MM/YYYY'), 'mirandita@gmail.com'); --coautora del mismo
insert into Autor values (codAutor.NEXTVAL, 'Miguel', 'Hernandez', to_date('08/12/1976', 'DD/MM/YYYY'), 'miguelherna25@gmail.com'); --autor sin articulos

SELECT * FROM AUTOR;

-- Autors X Article
insert into AutoresXArticulo values (1000, 99, 'P');
insert into AutoresXArticulo values (1001, 99, 'C');

-- References
insert into Referencias values (99, 101);

-- Magazine
insert into Revista values (codRevista.NEXTVAL, to_date('11/03/2002', 'DD/MM/YYYY'), 'ASTROPHYSICS', 'A2');
insert into Revista values (codRevista.NEXTVAL, to_date('11/03/2015', 'DD/MM/YYYY'), 'MECHATRONICS', 'A1'); --revista que no ha publicado ningun articulo


-- Publication
insert into Publicacion values (1, 99, to_date('23/12/2019', 'DD/MM/YYYY'));



/* SELECTERS */ -- Note: This selecters r just for testing and checking what are the current values in the different tables, has nothing to do with the project
select * from Area;
select * from Articulo;
select * from ArticuloXArea;
select * from Autor;
select * from AutoresXArticulo;
select * from Referencias;
select * from Revista;
select * from Publicacion;


-- DANIEL
/* QUERY #1 */


/* QUERY #2 */


-- DAVID
/* QUERY #3 */

with num1 as (select A.nameArticulo as num1_name, count(R.codArtiRef2) as num1_req
from Articulo A left join Referencias R on A.codArticulo = R.codArtiRef2
group by A.nameArticulo),

num2 as(select A.nameArticulo as num2_name, count(R.codArtiRef1) as num2_req
from Articulo A left join Referencias R on A.codArticulo = R.codArtiRef1
group by A.nameArticulo),

prereq3 as (select X.codArticulo as prerq, X.codAutor as preauth
from AutoresXArticulo X
where X.rol = 'P'),

num3 as (select A.nameArticulo as num3_name, count(Y.preauth) as num3_req
from Articulo A left join prereq3 Y on A.codArticulo = Y.prerq
group by A.nameArticulo),

prereq4 as (select X.codArticulo as prerq1, X.codAutor as preauth1
from AutoresXArticulo X
where X.rol = 'C'),

num4 as (select A.nameArticulo as num4_name, count(Y.preauth1) as num4_req
from Articulo A left join prereq4 Y on A.codArticulo = Y.prerq1
group by A.nameArticulo),

num5 as (select A.nameArticulo as num5_name, count(P.codRevista) as num5_req
from Articulo A left join Publicacion P on A.codArticulo = P.codArticulo
group by A.nameArticulo)

select A.nameArticulo "Nombre Artículo", num1.num1_req "Artículos en los que es referenciado", num2.num2_req "Artículos que referencia", num3.num3_req "Número de autores principales", num4.num4_req "Número de coautores", num5.num5_req "Número de revistas (diferentes) publicado"
from Articulo A, num1, num2, num3, num4, num5
where A.nameArticulo = num1.num1_name and A.nameArticulo = num2.num2_name and A.nameArticulo = num3.num3_name and A.nameArticulo = num4.num4_name and A.nameArticulo = num5.num5_name
order by A.codArticulo ASC;


/* QUERY #4 */

select A.nameArticulo "Artículo(s) referenciado(s) en todos los demás" 
from Articulo A
where A.codArticulo in (select R.codArtiRef2
from Referencias R
having count(*) = (select count(*) - 1 as art_n
    from Articulo)
group by R.codArtiRef2);


/* QUERY #5 */ -- KEVIN



/* QUERY #6 */ -- ERNESTO



/* QUERY #7 */ -- KEVIN

delete from Autor
where Autor.codautor not in (select codautor
                             from AutoresXArticulo);

/* QUERY #8 */ -- ERNESTO


