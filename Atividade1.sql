create database locadora
go
use locadora
go
create table filme(
id int not null,
titulo varchar(200) not null,
ano int check(ano<=2021) null
primary key(id)
)
go
create table estrela(
id int not null,
nome varchar(200) not null,
primary key(id)
)
go
create table filme_estrela(
filme_id int not null,
estrela_id int not null,
primary key(filme_id, estrela_id),
foreign key(filme_id) references filme(id),
foreign key(estrela_id) references estrela(id)
)
go
create table cliente(
num_cadastro int not null,
nome varchar(200) not null,
logradouro varchar(200) not null,
num int not null,
CEP char(8) null
primary key(num_cadastro)
)
go
create table dvd(
num int not null,
dataFabricacao date check(dataFabricacao<getdate()) not null,
filme_id int not null,
primary key(num),
foreign key(filme_id) references filme(id)
)
go
create table locacao(
dvdNum int not null,
clienteNum_cadastro int not null,
dataLocacao date default getdate() not null,
dataDevolucao date not null,
valor decimal(7,2) not null,
primary key(dataLocacao, clienteNum_cadastro, dvdNum),
foreign key(dvdNum) references dvd(num),
foreign key(clienteNum_cadastro) references cliente(num_cadastro),
constraint checarData check(dataDevolucao>dataLocacao)
)
go
alter table filme alter column titulo varchar(80) null
go
alter table estrela add nome_real varchar(50) null
go
insert into filme values
(1001,'Whiplash',2015),
(1002,'Birdman',2015),
(1003,'Interestelar',2014),
(1004,'A culpa é das estrelas',2014),
(1005,'Alexandre e o dia terrível, horrível, espantoso e horroroso', 2014),
(1006,'Sing',2016)
go
insert into estrela values
(9901,'Michae Keaton','John Douglas'),
(9902,'Emma Stone','Emilly Jean Stone'),
(9903,'Milles Telles', NULL),
(9904,'Steve Carell','Steve John Crell'),
(9905,'Jennifer Garner','Jennifer Anne Garner')
go
insert into filme_estrela values
(1002, 9901),
(1002, 9902),
(1001, 9903),
(1005, 9904),
(1005, 9905)
go
insert into dvd values
(10001, '2020-12-02', 1001),
(10002, '2019-10-18', 1002),
(10003, '2020-04-03', 1003),
(10004, '2020-12-12', 1001),
(10005, '2019-10-18', 1004),
(10006, '2020-04-03', 1002),
(10007, '2020-12-02', 1002),
(10008, '2019-10-19', 1002),
(10009, '2020-04-03', 1003)
go
insert into cliente values
(5501,'Matilde Luiz', 'Rua Síria', 150, '03086040'),
(5502,'Carlos Carreiro',' Rua Bartolomeu Aires', 1250, '04419110'),
(5503,'Daniel Ramalho','Rua Itajutiba', 169, NULL),
(5504,'Roberta Bento', 'Rua Jayme Von Rosenburg', 36, NULL),
(5505,'Rosa Cerqueira', 'Rua Arnaldo Simões Pinto', 235, '02917110')
go
insert into locacao values
(10001, 5502, '2021-02-18','2021-02-21',3.50),
(10009,5502,'2021-02-18', '2021-02-21',3.50),
(10002,5503,'2021-02-18','2021-02-19',3.50),
(10002,5505,'2021-02-20','2021-02-23',3.00),
(10004,5505,'2021-02-20','2021-02-23',3.00),
(10005,5505,'2021-02-20','2021-02-23',3.00),
(10001,5501,'2021-02-24','2021-02-26',3.50),
(10008,5501,'2021-02-24','2021-02-26',3.50)
go
update cliente set CEP = '08411150' where num_cadastro = 5503
go
update cliente set CEP = '02918190' where num_cadastro = 5504
go
update locacao set valor = 3.25 where clienteNum_cadastro = 5502 and dataLocacao = '2021-02-18'
go
update locacao set valor = 3.10 where clienteNum_cadastro = 5501 and dataLocacao = '2021-02-24'
go
update dvd set dataFabricacao = '2019-07-14' where num = 10005
go
update estrela set nome_real = 'Miles Alexander Teller' where id = 9903
go
delete filme where = titulo = 'Sing'
go
select '2014', titulo from filme
go
select id, ano from filme where titulo = 'Birdman'
go
select id, ano from filme where titulo like '%plash%'
go
select id, nome, nome_real from estrela where nome like '%Steve%'
go
select filme_id, convert(char(10), dataFabricacao, 103) as fab from dvd where dataFabricacao >= '01-01-2020'
go
select dvdNum, dataLocacao, dataDevolucao, valor+(2.00) as valor_multa from locacao where clienteNum_cadastro = 5505
go
select logradouro, num, CEP from cliente where nome = 'Matilde Luiz'
go
select nome_real from estrela where nome = 'Michael Keaton'
go
select num_cadastro, nome, logradouro+'' + Convert(char(10),num)+''+cep as end_comp from cliente where num_cadastro >= 5503

