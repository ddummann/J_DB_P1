-- In case u want to drop any of the tables, here are already each one of the the respectives commands

/*drop table Area;
drop table Articulo;
drop table Autor;
drop table ArticuloXArea;
drop table AutoresXArticulo;
drop table Referencias;
drop table Revista;
drop table Publicacion;*/


create table Area(
    codArea number(3,0) not null,
    nameArea varchar(40) not null,
    primary key(codArea)
);

create sequence codArea START WITH 1; -- Para que el codigo no se repite y se auto-incremente desde 1 lol

create table Articulo(
    codArticulo number(3, 0) not null, 
    nameArticulo varchar(40) not null,
    publishedDate date,
    primary key(codArticulo)
);
create sequence codArticulo START WITH 100;

create table ArticuloXArea(
    codArea number(3,0) not null,
    codArticulo number(3, 0) not null,
    foreign key(codArea) references Area,
    foreign key(codArticulo) references Articulo,
    primary key(codArea, codArticulo)
);

create table Autor(
    codAutor number(4, 0) not null,
    nameAutor varchar(25) not null,
    lastNameAutor varchar(25) not null,
    bithDateAutor date,
    emailAdress varchar(40) not null check (
        regexp_like(emailAdress, '^[[:alnum:]]+@[[:alnum:]]+(\.[[:alnum:]]+)+$')
    ),
    primary key (codAutor)
);

create table AutoresXArticulo(
    codAutor number(4, 0) not null,
    codArticulo number(3, 0) not null,
    rol char(1) check ( rol = 'P' or rol = 'C' ),
    foreign key(codAutor) references Autor, 
    foreign key(codArticulo) references Articulo, 
    primary key(codAutor, codArticulo)
);

create table Referencias(
    codArtiRef1 varchar(50) not null,
    foreign key(codArtiRef1) references Articulo,
    codArtiRef2 varchar(50) not null,
    foreign key(codArtiRef2) references Articulo,
    primary key(codArtiRef1, codArtiRef2)
);

create table Revista(
    codRevista number(3, 0),
    createdDate date,
    nameRevista varchar(50),
    categoryRevista char(2) check (
        categoryRevista = 'A1' or categoryRevista = 'A2' or categoryRevista = 'B' or categoryRevista = 'C'
    ),
    primary key (codRevista)
);

create table Publicacion(
    codRevista number(3, 0),
    codArticulo number(3, 0) not null, 
    publishedDate date,
    foreign key(codRevista) references Revista,
    foreign key(codArticulo) references Articulo,
    foreign key(publishedDate) references Articulo,
    primary key (codRevista, codArticulo, publishedDate)
);
