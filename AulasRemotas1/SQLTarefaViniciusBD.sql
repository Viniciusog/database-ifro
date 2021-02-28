CREATE DATABASE mecanica;

USE mecanica;

CREATE TABLE Fornecedor (
	cod_forn int not null auto_increment,
    nome_forn varchar(200) not null,
    razao_forn varchar(200) not null,
    telefone_forn varchar(100) not null,
    endereco_forn varchar(200) not null,
    cnpj_forn varchar(40) not null,
    primary key (cod_forn)
);

CREATE TABLE Cliente (
	cod_cli int not null auto_increment,
	nome_cli varchar(100) not null,
    data_nasc_cli date not null,
    endereco_cli varchar(200) not null,
    rg_cli varchar(100) not null,
    renda_familiar_cli decimal(10,2) not null,
    sexo_cli varchar(50) not null,
     primary key (cod_cli)
);

CREATE TABLE Funcionario (
	cod_func int not null auto_increment,
    nome_func varchar(100) not null,
    telefone_func varchar(100) not null,
    rg_func varchar(100) not null,
    cpf_func varchar(20) not null,
    salario_func decimal (20,2) not null,
    endereco_func varchar(200) not null,
    sexo_func varchar(200) not null,
    funcao_func varchar(50) not null,
	primary key(cod_func)    
);

CREATE TABLE Compra (
	cod_comp int not null auto_increment,
    cod_forn int not null,
    data_compra_comp date not null,
    forma_pagamento_comp varchar(100) not null,
    valor_comp decimal(14,2) not null,
    quantidade_comp int not null,
    primary key (cod_comp),
    foreign key (cod_forn) references Fornecedor(cod_forn)
);

CREATE TABLE Produto (
    cod_prod INT NOT NULL AUTO_INCREMENT,
    tipo_prod VARCHAR(100) NOT NULL,
    tamanho_prod VARCHAR(100) NOT NULL,
    marca_prod VARCHAR(100) NOT NULL,
    valor_prod DECIMAL(14 , 2 ) NOT NULL,
    quantidade_prod INT NOT NULL,
    descricao_prod VARCHAR(200) NOT NULL,
    PRIMARY KEY (cod_prod)
);

CREATE TABLE Compra_Produto (
	cod_comp_prod int not null auto_increment,
    cod_comp int not null,
    cod_prod int not null,
    primary key (cod_comp_prod),
    foreign key (cod_comp) references Compra (cod_comp),
    foreign key (cod_prod) references Produto (cod_prod)
);

CREATE TABLE Venda (
	cod_vend int not null auto_increment,
    cod_cli int not null,
    cod_func int not null,
    data_vend date not null,
    hora_vend time not null,
    form_pag_vend varchar(100) not null,
    valor_vend decimal(14,2) not null,
    primary key(cod_vend),
    foreign key (cod_cli) references Cliente(cod_cli),
    foreign key (cod_func) references Funcionario(cod_func)
);


CREATE TABLE Venda_Produto (
	cod_vend_prod int not null auto_increment,
    cod_vend int not null,
    cod_prod int not null,
    PRIMARY KEY (cod_vend_prod),
    FOREIGN KEY (cod_vend) REFERENCES Venda (cod_vend),
    FOREIGN KEY (cod_prod) REFERENCES Produto (cod_prod)
);

CREATE TABLE Servico (
	cod_serv int not null auto_increment,
    descricao_serv varchar(200) not null,
    valor_serv decimal(14,2) not null,
    tempo_serv time not null,
    primary key(cod_serv)
);

CREATE TABLE Venda_Servico (
	cod_vend_serv int not null auto_increment,
	cod_vend int not null,
	cod_serv int not null,
	primary key(cod_vend_serv),
	foreign key(cod_vend) references Venda (cod_vend),
	foreign key(cod_serv) references Servico (cod_serv)
);

CREATE TABLE Servico_Funcionario (
cod_serv_func int not null auto_increment,
    cod_serv int not null,
    cod_func int not null,
    primary key(cod_serv_func),
    foreign key(cod_serv) references Servico(cod_serv),
    foreign key(cod_func) references Funcionario(cod_func)
);

CREATE TABLE Caixa (
	cod_caixa int not null auto_increment,
	cod_func int not null,
	total_receb_caixa decimal(20,2) not null,
	total_pag_caixa decimal(20,2) not null,
	saldo_inicial_caixa decimal(20,2) not null,
	saldo_final_caixa decimal(20,2) not null,
	data_caixa date not null,
    primary key (cod_caixa),
    foreign key (cod_func) references Funcionario (cod_func)
);

CREATE TABLE Recebimento (
cod_receb int not null auto_increment,
    cod_vend int not null,
    cod_caixa int not null,
    valor_receb decimal(14,2) not null,
    forma_receb varchar(100) not null,
    parcela_receb int not null,
    data_vencimento_receb date not null,
    primary key (cod_receb),
    foreign key (cod_vend) references Venda (cod_vend),
    foreign key (cod_caixa) references Caixa (cod_caixa)
);

CREATE TABLE Despesa (
    cod_desp INT NOT NULL AUTO_INCREMENT,
    cod_forn INT NOT NULL,
    descricao_desp VARCHAR(100) NOT NULL,
    data_venc_desp DATE NOT NULL,
    forma_pag_desp VARCHAR(100) NOT NULL,
    valor_desp DECIMAL(14 , 2 ) NOT NULL,
    PRIMARY KEY (cod_desp),
    FOREIGN KEY (cod_forn)
        REFERENCES Fornecedor (cod_forn)
);

CREATE TABLE Pagamento (
	cod_pag int not null auto_increment,
    cod_caixa int,
    cod_desp int,
    cod_comp int,
	forma_pag varchar(100) not null,
	parcela_pag decimal(10,2) not null,
	valor_pag decimal(14,2) not null,
	data_pag date not null,
    PRIMARY KEY (cod_pag),
    FOREIGN KEY (cod_desp) REFERENCES Despesa (cod_desp),
    FOREIGN KEY (cod_caixa) REFERENCES Caixa (cod_caixa),
    FOREIGN KEY (cod_comp) REFERENCES Compra (cod_comp)
);

INSERT INTO Fornecedor (nome_forn, razao_forn, telefone_forn, endereco_forn, cnpj_forn) VALUES
("Ultra Borracha", "Ultra Borracha LTDA ME", 69912345678, "Centro Universal, Avenida Top, 1230, Ji-Paraná", "16.968.457/0001-40"),
("Ferramais", "Ferramais Ferramentas e Serviços", 69912987678, "Rui Henrique, Rua das pedras, 789, Ji-Paraná", "08.968.784/00009-21"),
("KitMaster", "Kitmaster pneus e acessórios", 69995874126, "Jardim Presidencial, Avenida Top, 668, Ji-Paraná", "27.968.457/0001-65"),
("Papel Verde", "Papel Verde LTDA ME", 69912345678, "Bairro Maringá, Avenida de mais, 698, Ji-Paraná", "18.968.477/0007-31"),
("Ferreira Ferramentas", "Ferreira Ferramentas de metal ", 69912345678, "Bairro Doutor Amélio, Avenida Legal, 1245, Ji-Paraná", "08.968.477/0003-86"),
("ABC Automóveis", "ABC Automóveis LTDA", 69912345678, "Jucelino da Ventura, Água de pedra, 3254, Ji-Paraná", "15.968.477/0001-40"),
("Escoros Jipa", "Escoros Jipa Ferramentas e Escoros", 69912345678, "Defauti, Avenida Henrique Cardoso, 1245, Ji-Paraná", "19.968.477/0201-24"),
("Poltronas de ouro", "Poltronas de ouro LTDA", 69912345678, "Casa Preta, Predioze de moura, 789, Ji-Paraná", "12.968.477/0001-40"),
("Pingo dagua", "Pingo dagua Aguas minerais", 69997845612, "Flores roxas, Delete sem where, 9897, Ji-Paraná", "11.968.477/0001-40"),
("Tapeçaria Marconio", "Tapeçaria Marcônio LTDA ME", 69912345678, "Maringá do céu, Gigabyte por todos, 199, Ji-Paraná", "20.868.477/0001-40");

INSERT INTO Funcionario (nome_func, sexo_func, telefone_func, rg_func, cpf_func, salario_func, endereco_func, funcao_func) VALUES
("João Pereira", "masculino", "69992305684", "154879", "03915879448", '1045.00', "Aurélio Bernardes, 1265, Rua das Flores, Ji-Paraná", "Secretária Geral"),
("Maria Alves",  "feminino","69987456524", "487561", "03987456328", '900.00', "Jardim Presidencial, Avenida Top, 668, Ji-Paraná", "Atendente"),
("Francisco Santos", "masculino","69935897641", "658412", "03478562136", '2045.00', "Bairro Maringá, Avenida de mais, 698, Ji-Paraná", "Mecânico"),
("Henrique Junior", "masculino","69913245687", "325489", "01478965234", '2045.00', "Defauti, Avenida Henrique Cardoso, 1245, Ji-Paraná", "Vendedor"),
("Juliano Skipt", "masculino","69912345698", "987456", "80498756542", '2045.00', "Jucelino da Ventura, Água de pedra, 3254, Ji-Paraná", "Mecânico"),
("Andreia Filho", "feminino","69968497951", "165794", "32654788712", '900.00', "Casa Preta, Predioze de moura, 789, Ji-Paraná", "Limpadora"),
("Pedro Tots", "masculino","69936985217", "345876", "65498732156", '1045.00', "Rui Henrique, Rua das pedras, 789, Ji-Paraná", "Gerente"),
("Ana Gabriely", "feminino","69910254897", "258645", "98745554252", '1045.00', "Centro Universal, Avenida Top, 1230, Ji-Paraná", "Secretária Geral"),
("Jonas de Abreu", "masculino","69920158067", "357951", "89465465465", '2045.00', "Bairro Maringá, Avenida de mais, 698, Ji-Paraná", "Mecânico"),
("Felipe Camargo", "masculino","69965849712", "268479", "88797987897", '2045.00', "Flores roxas, Delete sem where, 9897, Ji-Paraná", "Mecânico");

INSERT INTO Cliente (nome_cli, data_nasc_cli, endereco_cli, rg_cli, renda_familiar_cli, sexo_cli) VALUES
("João Pereira", "1997-04-20", "Ji-Paraná, Rua top, Bairro Ouro verde, 1203", "984984", 890, "masculino"),
("Maria Pereira", "1993-05-20", "Ji-Paraná, Rua legal, Bairro Teclado, 1203", "5151515", 2500, "feminino"),
("Elena Pereira", "1991-04-06", "Ji-Paraná, Rua Aparecida 1, Bairro Computador, 1203", "784545", 1000, "feminino"),
("Patricia Pereira", "1991-05-20", "Ji-Paraná, Rua Aparecida 2, Bairro dos Manés, 1203", "362591", 780, "feminino"),
("Henrique Pereira", "1990-04-20", "Ji-Paraná, Rua Desapcel, Bairro Guarda o Celular, 1203", "325147", 12300, "masculino"),
("Joana Pereira", "1975-04-08", "Ji-Paraná, Rua Incrivel, Bairro Céu azul, 1203", "7558956", 685479, "feminino"),
("Amadeu Pereira", "1985-05-20", "Ji-Paraná, Rua das Pessoas, Bairro Das Pedras, 1203", "987465", 1400, "masculino"),
("Daniel Pereira", "1975-04-14", "Ji-Paraná, Rua Dois Abreus, Bairro Das águas, 1203", "233229", 2999.99, "masculino"),
("Felipe Pereira", "1985-05-20", "Ji-Paraná, Rua Amazing, Bairro Melancieiras, 1203", "987654", 4000, "masculino"),
("Gustavo Pereira", "1985-04-26", "Ji-Paraná, Rua De mais, Bairro Oufin, 1203", "7558956", 5000, "masculino");
   
INSERT INTO Produto (tipo_prod, tamanho_prod, marca_prod, valor_prod, quantidade_prod, descricao_prod) VALUES
("pneu", "35cm", "Pirelli", 652, 20, "Pneu Ultra Leve"),
("pneu", "70cm", "Micahha", 3600, 40, "Pneu Trator"),
("corrente", "120cm", "Sabreu", 65, 10, "Corrente de Moto"),
("corrente", "600cm", "Sabreu", 2500, 59, "Corrente Trator"),
("óleo", "150ml", "Pirelli", 6.99, 26, "Óleo para Corrente"),
("óleo", "200ml", "Pirelli", 8.30, 49, "Óleo para Corrente"),
("ferramenta", "70g", "Suinfo", 64, 47, "Ferramenta mecanica SX tipo 1"),
("ferramenta", "140g", "Oplius", 86, 59, "Ferrificador de óleo"),
("pneu", "26cm", "Pirelli", 667.00, 59, "Pneu médio casual"),
("pneu", "29", "Pirello", 689.00, 59, "Pneu médio menor tipo 2s");

INSERT INTO Servico (descricao_serv, valor_serv, tempo_serv) VALUES
("Troca de pneu", 65, "00:26:21"),
("Troca de pneu", 80, "00:32:29"),
("Troca de pneu", 65, "00:25:04"),
("Troca de corrente trator", 140, "00:15:16"),
("Aperto amortecedor", 70, "00:10:02"),
("Revisão geral", 560, "01:20:15"),
("Revisão geral moto", 120, "00:34:06"),
("Troca de peça banco", 31, "00:16:15"),
("Limpeza de óleo", 140, "00:40:08"),
("Troca de pneu", 360, "00:48:15");

INSERT INTO Caixa (cod_func, total_receb_caixa, total_pag_caixa, saldo_inicial_caixa, saldo_final_caixa, data_caixa)
VALUES (1, 35068.00,16850.00, 6.00, 18224, "2020-02-16");
INSERT INTO Caixa (cod_func, total_receb_caixa, total_pag_caixa, saldo_inicial_caixa, saldo_final_caixa, data_caixa)
VALUES (7, 16000.00,9800.00, 3000, 6200, "2020-02-18");
INSERT INTO Caixa (cod_func, total_receb_caixa, total_pag_caixa, saldo_inicial_caixa, saldo_final_caixa, data_caixa)
VALUES (8, 29006,6700, 250, 22506, "2020-02-16");
   
INSERT INTO Despesa (cod_forn, descricao_desp, data_venc_desp, forma_pag_desp, valor_desp) VALUES (1, "Detetização", "2020-05-06", "a vista", "450");
INSERT INTO Despesa (cod_forn, descricao_desp, data_venc_desp, forma_pag_desp, valor_desp) VALUES (1, "Água", "2020-04-01", "a vista", "156");
INSERT INTO Despesa (cod_forn, descricao_desp, data_venc_desp, forma_pag_desp, valor_desp) VALUES (1, "Energia", "2020-05-06", "a vista", "1200");
   
INSERT INTO Compra (cod_forn, data_compra_comp, forma_pagamento_comp, valor_comp, quantidade_comp) VALUES
(1, "2020-01-08", "a vista", 653, 3),
(3, "2020-02-15", "a prazo", 1250, 4),
(6, "2020-02-06", "a prazo", 789, 2),
(5, "2020-02-06", "a vista", 654, 5),
(4, "2020-02-07", "a prazo", 321, 2);
   
INSERT INTO Pagamento (cod_caixa, cod_desp, forma_pag, parcela_pag, valor_pag, data_pag) VALUES
(1, 1,  "a vista", 450, 450, "2020-05-03"),
(1, 2, "a vista", 156, 156, "2020-05-25");
INSERT INTO Pagamento (cod_caixa, cod_comp, forma_pag, parcela_pag, valor_pag, data_pag) VALUES
(2, 1, "a vista", 653, 653, "2020-01-27");
   
INSERT INTO Venda (cod_cli, cod_func, data_vend, hora_vend, form_pag_vend, valor_vend) VALUES
(1, 1, "2020-04-03", "13:45", "a vista", 652),
(2, 2, "2020-04-01", "09:36", "a prazo", 3600),
(3, 3, "2020-04-21", "14:39", "a vista", 656),
(4, 4, "2020-04-02", "14:06", "a prazo", 65),
(1, 1, "2020-04-21", "16:47", "a vista", 2500);
   
INSERT INTO Recebimento (cod_vend, cod_caixa, valor_receb, forma_receb, parcela_receb, data_vencimento_receb) VALUES
(1, 1, 652, "a vista", 1, "2020-04-03"),
(2, 2, 3600, "a vista", 1, "2020-04-01"),
(3, 1, 656, "a vista", 1, "2020-04-21");

INSERT INTO Compra_Produto (cod_comp, cod_prod) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 5),
(5, 4);
   
INSERT INTO Venda_Produto (cod_vend, cod_prod) VALUES
(1,1),
(2, 2),
(3,3),
(4,4),
(5,5);

INSERT INTO Venda_Servico (cod_vend, cod_serv) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO Servico_Funcionario (cod_serv, cod_func) VALUES
(1, 4),
(2, 6),
(3, 3),
(4, 8),
(5, 9);

CREATE TABLE Sexo (
	cod_sexo int auto_increment not null primary key,
    tipo_sexo varchar(100) not null
);

insert into sexo (tipo_sexo) values ("Masculino");
insert into sexo (tipo_sexo) values ("Feminino");

/*Altera a tabela cliente passando uma foreign key de sexo, de acordo com o antigo atributo de sexo*/
ALTER TABLE Cliente ADD cod_sexo_cli INT NOT NULL;
UPDATE Cliente SET cod_sexo_cli = 1 WHERE sexo_cli = "masculino" AND cod_cli > 0;
UPDATE Cliente SET cod_sexo_cli = 2 WHERE sexo_cli = "feminino" AND cod_cli > 0;
ALTER TABLE Cliente ADD FOREIGN KEY (cod_sexo_cli) REFERENCES Sexo (cod_sexo);

/*Altera a tabela funcionário passando uma foreign key de sexo, de acordo com o antigo atributo de sexo*/
alter table Funcionario add cod_sexo_func int not null;
update Funcionario set cod_sexo_func = 1 where sexo_func = "masculino" AND cod_func > 0;
update Funcionario set cod_sexo_func = 2 where sexo_func = "feminino" AND cod_func > 0;
alter table Funcionario add foreign key (cod_sexo_func) references Sexo (cod_sexo);

/*Deleta a antiga coluna de sexo nas tabelas cliente e funcionario*/
alter table Cliente drop column sexo_cli;
alter table Funcionario drop column sexo_func;

/*ADICIONA STATUS DE ACORDO COM RENDA FAMILIAR*/
/*cod_cli > 0 para resolver o erro de: You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.*/
/*Fiz isto pois não havia conseguido arrumar nas configurações*/
ALTER TABLE Cliente ADD status_cli VARCHAR(100);
UPDATE Cliente SET status_cli = "vip" WHERE renda_familiar_cli > 3000 AND cod_cli > 0;
UPDATE Cliente SET status_cli = "médio" WHERE renda_familiar_cli BETWEEN 1000 AND 2999.99 AND cod_cli > 0;
UPDATE Cliente SET status_cli = "simples" WHERE renda_familiar_cli BETWEEN 0 AND 999.99 AND cod_cli > 0;

/*Exclui coluna tempo da tabela serviço*/
ALTER TABLE Servico DROP COLUMN tempo_serv;

/*Altera o campo parcela_pag para parcelamento_pag*/
ALTER TABLE Pagamento CHANGE COLUMN parcela_pag parcelamento_pag DECIMAL(10,2);

/*Dá um aumento de 30% para todos os funcionários*/
UPDATE Funcionario SET salario_func = salario_func * 1.3 where cod_func > 0;

/*Dá um aumento de 50 reais no salário dos vendedores*/
UPDATE Funcionario SET salario_func = salario_func + 50 WHERE funcao_func = "Vendedor" AND cod_func > 0;

/*Dá um aumento de 50 reais mais 10% do salário normal dos mecânicos*/
UPDATE Funcionario SET salario_func = salario_func * 1.1 + 50 WHERE funcao_func = "Mecânico" AND cod_func > 0;

/*Relacionar produto e fornecedor*/
ALTER TABLE Produto ADD cod_forn_prod INT NOT NULL;
UPDATE Produto SET cod_forn_prod = 1 WHERE cod_prod = 1;
UPDATE Produto SET cod_forn_prod = 2 WHERE cod_prod = 2;
UPDATE Produto SET cod_forn_prod = 3 WHERE cod_prod = 3;
UPDATE Produto SET cod_forn_prod = 4 WHERE cod_prod = 4;
UPDATE Produto SET cod_forn_prod = 5 WHERE cod_prod = 5;
UPDATE Produto SET cod_forn_prod = 6 WHERE cod_prod = 6;
UPDATE Produto SET cod_forn_prod = 7 WHERE cod_prod = 7;
UPDATE Produto SET cod_forn_prod = 8 WHERE cod_prod = 8;
UPDATE Produto SET cod_forn_prod = 9 WHERE cod_prod = 9;
UPDATE Produto SET cod_forn_prod = 10 WHERE cod_prod = 10;
ALTER TABLE Produto ADD FOREIGN KEY (cod_forn_prod) REFERENCES Fornecedor (cod_forn);

/*Cria campo email na tabela cliente e seta seu valor de acordo com o sexo*/
ALTER TABLE Cliente ADD email_cli VARCHAR(100) NOT NULL;
UPDATE Cliente SET email_cli  = "homem@hotmail.com" WHERE cod_sexo_cli = 1 AND cod_cli > 0;
UPDATE Cliente SET email_cli  = "mulher@gmail.com" WHERE cod_sexo_cli = 2 AND cod_cli > 0;

/*Zera a quantidade de produtos em que o valor de venda é menor que 50 reais*/
UPDATE Produto SET quantidade_prod = 0 WHERE valor_prod < 50 AND cod_prod > 0;

/*Inserir produto Pneu 15 na tabela produto*/
INSERT INTO Produto (tipo_prod, tamanho_prod, marca_prod, valor_prod, quantidade_prod, descricao_prod, cod_forn_prod) VALUES
("Pneu 15", "40cm", "Masterix", 890, 6, "Pneu Ultra Médio", 1);

/*Atualiza quantidade do Pneu 15 para 10 unidades*/
UPDATE Produto SET quantidade_prod = 10 where tipo_prod = "Pneu 15" AND cod_prod > 0;

/*Dá um desconto de 15% em todas as vendas a vista*/
UPDATE Venda SET valor_vend = 0.85 WHERE form_pag_vend = "a vista" AND cod_vend > 0;

/*Cria a tabela Carro*/
CREATE TABLE Carro (
	cod_carro int not null auto_increment primary key,
    cod_cliente int not null,
	modelo_carro varchar(200) not null,
    ano_carro int not null,
    marca_carro varchar(200) not null,
    foreign key (cod_cliente) references Cliente (cod_cli)
);

/*Insere um carro para cada cliente*/
INSERT INTO Carro (cod_cliente, modelo_carro, ano_carro, marca_carro) VALUES
(1, "Ford K+", 2017, "Ford"),
(2, "Uno", 2014, "Fiat"),
(3, "Gol", 2010, "Volkswagen"),
(4, "Palio", 2014, "Volkswagen"),
(5, "Fox", 2013, "Ford"),
(6, "Siena", 2012, "Fiat"),
(7, "Voyage", 2015, "Volkswagen"),
(8, "HB20", 2016, "Hyundai"),
(9, "Corsa Sedan", 2018, "General Motors"),
(10, "Onix", 2018, "General Motors");

/***************************TAREFA 3*****************************/
/*1*/
SELECT nome_cli, email_cli FROM Cliente WHERE email_cli LIKE "%hotmail.com" OR email_cli LIKE "%gmail.com";

/*2*/
SELECT * FROM Cliente ORDER BY nome_cli;

/*3*/
SELECT * FROM Cliente ORDER BY data_nasc_cli DESC;

/*4*/
SELECT * FROM Cliente WHERE (nome_cli LIKE "%Souza%" OR nome_cli LIKE "%Silva%")
AND (cod_sexo_cli = 2) AND (renda_familiar_cli BETWEEN 500 AND 10000) AND data_nasc_cli > '1980-01-01';

/*5*/
SELECT COUNT(*) FROM Cliente;

/*6*/
SELECT * FROM Cliente ORDER BY renda_familiar_cli DESC LIMIT 1;

/*7*/
SELECT AVG(renda_familiar_cli) FROM Cliente;

/*10*/
SELECT AVG(valor_prod) FROM Produto;

/*11*/
SELECT Sexo.tipo_sexo AS Sexo, COUNT(cod_sexo_cli) AS quantidade FROM Cliente, Sexo WHERE Sexo.cod_sexo = Cliente.cod_sexo_cli GROUP BY cod_sexo_cli;

/*12*/
SELECT * FROM Cliente WHERE nome_cli IS NULL;

/*13*/
SELECT COUNT(DISTINCT endereco_cli) FROM Cliente;

/*14*/
SELECT nome_cli FROM Cliente WHERE renda_familiar_cli = (SELECT min(renda_familiar_cli) FROM Cliente);

/*15*/
SELECT SUM(valor_vend) FROM Venda WHERE data_vend BETWEEN '2010-01-01' AND '2017-12-31';

/*16*/
SELECT * FROM Produto WHERE quantidade_prod = (SELECT MIN(quantidade_prod) FROM Produto);

/*17*/
SELECT * FROM Produto WHERE quantidade_prod = (SELECT MAX(quantidade_prod) FROM Produto);

/*18*/
SELECT Carro.cod_carro, Carro.modelo_carro, Carro.ano_carro, Carro.marca_carro,
Cliente.nome_cli FROM Cliente, Carro  
WHERE (Carro.cod_cliente = Cliente.cod_cli);

/*19*/
SELECT Caixa.cod_caixa, Funcionario.nome_func, Caixa.total_receb_caixa, Caixa.total_pag_caixa, 
Caixa.saldo_inicial_caixa, Caixa.saldo_final_caixa, Caixa.data_caixa FROM Caixa, Funcionario 
WHERE (Caixa.cod_func = Funcionario.cod_func);

/*20*/
SELECT Venda.cod_vend, Venda.data_vend, Venda.hora_vend, Venda.form_pag_vend, Venda.valor_vend,
Cliente.nome_cli, Funcionario.nome_func FROM Cliente, Venda, Funcionario 
WHERE (Cliente.cod_cli = Venda.cod_cli AND Funcionario.cod_func = Venda.cod_func);

/*21*/
SELECT Venda.cod_vend, Venda.data_vend, Venda.hora_vend, Venda.form_pag_vend, Venda.valor_vend,
Cliente.nome_cli, Funcionario.nome_func, Produto.descricao_prod FROM Cliente, Venda, Funcionario, Venda_Produto, Produto
WHERE (Cliente.cod_cli = Venda.cod_cli AND Funcionario.cod_func = Venda.cod_func AND Produto.cod_prod = Venda_Produto.cod_prod
AND Venda.cod_vend = Venda_Produto.cod_vend);

/*22*/
SELECT  Venda_Servico.cod_vend_serv, Cliente.nome_cli, Carro.modelo_carro, Servico.descricao_serv
FROM Cliente, Venda_Servico, Venda, Carro, Servico WHERE (Venda_Servico.cod_vend = Venda.cod_vend) AND 
(Venda_Servico.cod_serv = Servico.cod_serv) AND (Carro.cod_cliente = Cliente.cod_cli) AND (Venda.cod_cli = Cliente.cod_cli);