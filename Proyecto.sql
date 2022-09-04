/*Proyecto 1 -  Ernesto Duarte, Daniel Orjuela, David Valderrama y Kevin Velasco*/

-- In case you want to drop any of the tables, here are already each one of the the respectives commands

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
    birthDateAutor date,
    emailAdress varchar(40) not null check (emailAdress like '%_@__%.__%'
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
insert into Articulo values (codArticulo.NEXTVAL, 'Memoria, una realidad informÃ¡tica', to_date('08/08/2020', 'DD/MM/YYYY')); --el que lo referencia


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


/* QUERY #1 */
select concat(concat(lastNameAutor, ' ') , nameAutor) as "Nombre Completo: ", round((to_date(SYSDATE) - birthDateAutor)/365, 1) as "Edad: ",
        nvl(nameArticulo, 'No ha publicado') as "Nombre del Articulo: ", nvl(publishedDate, '01/01/0001') as "Fecha de Publicacion: ",
        axa.codArticulo 
from Autor natural left outer join autoresxarticulo axa, 
    articulo inner join autoresxarticulo axa2 on (articulo.codArticulo = axa2.codArticulo)
where axa.codArticulo = articulo.codArticulo
order by(lastNameAutor) asc, (nameAutor) asc;


/* QUERY #2 */
select "Nombre Autor: ", "Numero de Articulos: ", "Autor Principal: ", "Coautor: ", min(firstDate) as "Fecha Primera Publicación: ", max(lastDate)  as "Fecha Ultima Publicación", (LISTAGG(Areas, ';')) as "Areas: "
from (
        select concat(concat(lastNameAutor, ' '), nameAutor) as "Nombre Autor: ", 
        (
            select count(*) 
            from autoresxarticulo aXa 
            where aXa.codAutor = Autor.codAutor
         ) as "Numero de Articulos: ", 
        (
            select count(*) 
            from autoresxarticulo aXa 
            where aXa.codAutor = Autor.codAutor and aXa.rol = 'P'
        ) as "Autor Principal: ", 
        (
            select count(*) 
            from autoresxarticulo aXa 
            where aXa.codAutor = Autor.codAutor and aXa.rol = 'C'
        ) as "Coautor: ", 
         firstDate, lastDate, nvl(( 
            select LISTAGG(nameArea, ';') as "Areas"
            from Area natural left join ArticuloXArea
            where codArticulo = auXar.codArticulo)
            ,
            '"No ha publicado"') Areas
        from Autor left outer join ( 
            select min(publishedDate_p) firstDate,
                   max(publishedDate_p) lastDate,
                   codArticulo, codAutor
            from Publicacion natural full join autoresXArticulo
            group by (codArticulo, codAutor)
        ) auXar on (auXar.codAutor = Autor.codAutor)
    )
group by ("Nombre Autor: ", "Numero de Articulos: ", "Autor Principal: ", "Coautor: ");

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

select A.nameArticulo "Nombre ArtÃ­culo", num1.num1_req "ArtÃ­culos en los que es referenciado", num2.num2_req "ArtÃ­culos que referencia", num3.num3_req "NÃºmero de autores principales", num4.num4_req "NÃºmero de coautores", num5.num5_req "NÃºmero de revistas (diferentes) publicado"
from Articulo A, num1, num2, num3, num4, num5
where A.nameArticulo = num1.num1_name and A.nameArticulo = num2.num2_name and A.nameArticulo = num3.num3_name and A.nameArticulo = num4.num4_name and A.nameArticulo = num5.num5_name
order by A.codArticulo ASC;


/* QUERY #4 */

select A.nameArticulo "ArtÃ­culo(s) referenciado(s) en todos los demÃ¡s" 
from Articulo A
where A.codArticulo in (select R.codArtiRef2
from Referencias R
having count(*) = (select count(*) - 1 as art_n
    from Articulo)
group by R.codArtiRef2);


/* QUERY #5 */

select * from publicacion;
with numeroarticulos as (select to_char(publisheddate_p, 'yyyy') as year1, count(codarticulo) as cuentarti
                         from publicacion natural join articulo
                         group by to_char(publisheddate_p, 'yyyy')
                            ), numeroautores as (select to_char(publisheddate_p, 'yyyy') year1, count(distinct codautor) numeroautors
                                                from articulo natural join publicacion natural join autoresxarticulo
                                                group by to_char(publisheddate_p, 'yyyy')
                                                    ), total as (select sum(cuentarti) totaltotal
                                                                 from numeroarticulos), porcentaje as  (select numeroarticulos.year1, cuentarti/total.totaltotal porcentajerequerido
                                                                                                        from numeroarticulos natural join total)(select year1 Año, numeroarticulos.cuentarti NúmeroDeArtículosPublicadosEnRevistas, numeroautores.numeroautors NumeroDeAutores, porcentaje.porcentajerequerido PorcentajeT
                                                                                                                                                                 from numeroarticulos natural join numeroautores natural join porcentaje
                                                                                                                                                                 union all
                                                                                                                                                                 select 'TOTAL', sum(numeroarticulos.cuentarti), sum(numeroautores.numeroautors), sum(porcentaje.porcentajerequerido)
                                                                                                                                                                 from numeroarticulos natural join numeroautores natural join porcentaje);
                                                                                                                                                                 

/* QUERY #6 */

with autoresarticulos as (
select autor.nameautor, articulo.namearticulo, articulo.codarticulo, autor.birthdateautor, autor.birthdateautor as fecha
from autoresxarticulo, articulo, autor
where autoresxarticulo.codautor = autor.codautor and autoresxarticulo.codarticulo = articulo.codarticulo
),

publicacionarticulo as(
select articulo.codarticulo, extract(year from publicacion.publisheddate_p) as anio
from publicacion, articulo
where articulo.codarticulo = publicacion.codarticulo
),

anios as (
select anio
from publicacionarticulo
group by anio
),

menor as (
select MAX(birthdateautor) as menanio
from autoresarticulos
),

mayor as (
select MIN(birthdateautor) as maxanio
from autoresarticulos
),

autores as (
select publicacionarticulo.anio, autoresarticulos.nameautor, autoresarticulos.birthdateautor
from anios, publicacionarticulo, autoresarticulos
where anios.anio = publicacionarticulo.anio and publicacionarticulo.codarticulo = autoresarticulos.codarticulo
),

menores as (
select a.anio, a.nameautor, a.birthdateautor
from autores a
where a.birthdateautor = (select max(a2.birthdateautor)
                         from autores a2
                         where a2.anio = a.anio
                        )
),

mayores as (
select a.anio, a.nameautor, a.birthdateautor
from autores a
where a.birthdateautor = (select min(a2.birthdateautor)
                         from autores a2
                         where a2.anio = a.anio
                        )
)

select *
from  menores mn
inner join mayores my on mn.anio = my.anio;


/* QUERY #7 */

delete from Autor
where Autor.codautor not in (select codautor
                             from AutoresXArticulo);


/* QUERY #8 */

create view autores_revista as
with abc as (select distinct A.codAutor as abc_1, P.codArticulo as abc_2
from Autor A, AutoresXArticulo X, Publicacion P
where A.codAutor = X.codAutor and X.codArticulo = P.codArticulo),

xyz as (select A.codAutor as xyz_1, count(E.abc_2) as xyz_2
from Autor A left join abc E on A.codAutor = E.abc_1
group by A.codAutor)

select A.nameAutor || ' ' || A.lastNameAutor as NombreAutor, A.birthDateAutor, xyz.xyz_2 "Artículos Publicados"
from Autor A, xyz
where xyz.xyz_1 = A.codAutor;

grant all on autores_revista to public;

