create database Herois;
use Herois;


create table Origem (
cod_ori int primary key not null,
nome_ori varchar (200) not null
);

insert into Origem values (1, 'Marvel');
insert into Origem values (2, 'DC Comics');
insert into Origem values (3, 'TV');
insert into Origem values (4, 'Internet');

create table Heroi (
cod_hero int primary key not null,
nome_hero varchar (200) not null,
arma_hero varchar (100),
cod_ori_fk int,
foreign key (cod_ori_fk) references Origem (cod_ori)
);

insert into heroi values (1, 'Capitão America', 'Escudo', 1);
insert into heroi values (2, 'Homem de Ferro', 'Armadura', 1);
insert into heroi (cod_hero, nome_hero) values (3, 'Huck');
insert into heroi (cod_hero, nome_hero, cod_ori_fk) values (4, 'Power Rangers', 3);
insert into heroi (cod_hero, nome_hero) values (5, 'Big Hero');
insert into heroi values (6, 'Homem-Aranha', 'Teia', 1);
insert into heroi values (7, 'Super Homem', 'Força', 2);
insert into heroi values (8, 'Batman', 'Dinheiro', 2);
insert into heroi values (9, 'Seya de Pegasus', 'Cosmo', 3);

