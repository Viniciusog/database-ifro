create database BD_Vinicius;
use BD_Vinicius;

create table Estado (
cod_est int not null primary key auto_increment,
nome_est varchar (200) not null,
sigla_est varchar (2)
);

create table Cidade (
cod_cid int not null primary key auto_increment,
nome_cid varchar (200) not null,
cod_est int,
foreign key (cod_est) references Estado (cod_est)
);

create table Endereço (
cod_end integer not null primary key auto_increment,
rua_end varchar (300) not null,
numero_end integer,
bairro_end varchar (100),
cep_end varchar (100),
cod_cid int not null,
foreign key (cod_cid) references Cidade (cod_cid)
); 

create table Sexo (
cod_sex int not null primary key auto_increment,
nome_sex varchar (100) not null
);

create table Telefone (
cod_tel int not null primary key auto_increment,
celular_tel varchar (100),
casa_tel varchar (100),
trabalho_tel varchar (100)
);

create table Cliente (
cod_cli integer not null primary key auto_increment,
nome_cli varchar (200) not null,
estadocivil_cli varchar (50),
cpf_cli varchar (20) not null,
rg_cli varchar (30),
datanasc_cli date,
cod_sex integer not null,
cod_end integer not null,
cod_tel integer not null,
foreign key (cod_sex) references Sexo (cod_sex),
foreign key (cod_end) references Endereço (cod_end),
foreign key (cod_tel) references Telefone (cod_tel)
);

create table Departamento (
cod_dep integer not null primary key auto_increment,
nome_dep varchar (100),
descrição_dep varchar (300)
);

create table Funcionario (
cod_func integer not null primary key auto_increment,
nome_func varchar (200) not null,
cpf_func varchar (20) not null,
rg_func varchar (20),
datanasc_func date,
salário_func double not null,
função_func varchar (50) not null,
cod_sex integer not null,
cod_dep integer not null,
cod_end integer not null,
cod_tel integer not null,
foreign key (cod_sex) references Sexo (cod_sex),
foreign key (cod_dep) references Departamento (cod_dep),
foreign key (cod_end) references Endereço (cod_end),
foreign key (cod_tel) references Telefone (cod_tel)
);

create table onibus (
cod_oni integer not null primary key auto_increment,
modelo_oni varchar (100) not null,
marca_oni varchar (100),
placa_oni varchar (50),
tipo_oni varchar (100)
);

create table Poltrona(
cod_pol integer not null primary key auto_increment,
número_pol integer not null,
situação_pol varchar (100) not null,
cod_oni integer not null,
foreign key (cod_oni) references Onibus (cod_oni)
);

create table Trecho_Viagem (
cod_tre integer not null primary key auto_increment,
data_part_tre date not null,
data_cheg_tre date not null,
horário_part_tre time not null,
horário_cheg_tre time not null,
distancia_tre float,
tarifa_tre float,
cod_cid_origem int not null,
cod_cid_destino int not null,
cod_oni int not null,
foreign key (cod_cid_origem) references Cidade (cod_cid),
foreign key (cod_cid_destino) references Cidade (cod_cid),
foreign key (cod_oni) references Onibus (cod_oni)
);

create table Passagem (
cod_pas integer not null primary key auto_increment,
data_pas date,
valor_pas float,
cod_cli integer not null,
cod_func integer not null,
cod_tre integer not null,
poltrona_pas integer,
foreign key (cod_cli) references Cliente (cod_cli),
foreign key (cod_func) references Funcionario (cod_func),
foreign key (cod_tre) references Trecho_Viagem (cod_tre)
);

create table Caixa (
cod_caixa integer not null primary key auto_increment,
dataabertura_caixa date not null,
datafechamento_caixa date,
saldoinicial_caixa double not null,
valorcréditos_caixa double,
valordébitos_caixa double,
saldofinal_caixa double,
cod_func int not null,
foreign key (cod_func) references Funcionario (cod_func)
);

create table Recebimentos (
cod_receb integer not null primary key auto_increment,
data_receb date,
valor_receb double,
formapag_receb varchar (100),
cod_caixa integer not null,
cod_pas integer not null,
foreign key (cod_caixa) references Caixa (cod_caixa),
foreign key (cod_pas) references Passagem (cod_pas)
);


#INICIE A PARTIR DAQUI SUA LISTA DE EXERCÍCIOS

#Tarefa 1


DELIMITER $$
CREATE procedure inserirUF(nome VARCHAR(200), sigla_estado VARCHAR(200)) 
BEGIN 
	IF ((select nome_est from estado where nome_est = nome) IS NULL) THEN 
		insert into estado values (null, nome, sigla_estado);
			Select 'Sucesso ao inserir estado!' as Confirmacao;
    ELSE
		Select 'Já existe um estado com esse nome!' as Alerta;
    END IF;
END
$$ DELIMITER ;

select * from estado;
call inserirUF('Rondônia','RO');
call inserirUF('Acre','AC');
call inserirUF('Mato Grosso','MT');
call inserirUF('Amazonas','AM');
call inserirUF('Mato Grosso do Sul','MS');
call inserirUF('Minas Gerais','MG');
call inserirUF('Goiás','GO');
call inserirUF('São Paulo','SP');
call inserirUF('Rio de Janeiro','RJ');
call inserirUF('Paraná','PR');

#Tarefa 2

DELIMITER $$
CREATE procedure inserirCidade(nome VARCHAR(200), cod_estado int) 
BEGIN 
	IF ((select nome_est from estado where cod_est = cod_estado) IS NOT NULL) THEN 
        IF ((select nome_cid from cidade where nome_cid = nome) IS NULL) THEN
			insert into cidade values (null, nome, cod_estado);
			Select 'Sucesso ao inserir cidade!' as Confirmacao;
        ELSE
			Select 'Já existe uma cidade com esse nome!' as Alerta;
        END IF;
    ELSE
		Select 'Não existe estado com esse código! Digite um estado válido!' as Alerta;
    END IF;
END
$$ DELIMITER ;

call inserirCidade('Ji-Paraná', 1);
call inserirCidade('Porto Velho', 1);
call inserirCidade('Ariquemes', 1);
call inserirCidade('Jaru', 1);
call inserirCidade('Ouro Preto do Oeste', 1);
call inserirCidade('Machadinho do Oeste', 1);
call inserirCidade('Cacoal', 1);
call inserirCidade('Vilhena', 1);
call inserirCidade('Rolim de Moura', 1);
call inserirCidade('Presidente Médice', 1);

call inserirCidade('Rio Branco', 2);
call inserirCidade('Xapuri', 2);

call inserirCidade('Cuiabá', 3);
call inserirCidade('São José do Rio Claro', 3);
call inserirCidade('Cáceres', 3);

call inserirCidade('Manaus', 4);
call inserirCidade('Parintins', 4);

call inserirCidade('Campo Grande', 5);
call inserirCidade('Tres Lagoas', 5);

#Tarefa 3

DELIMITER $$
CREATE procedure inserirEndereco(rua VARCHAR(200), numero int, bairro VARCHAR(200), cep VARCHAR(200), cod_cidade int) 
BEGIN 
	IF ((select nome_cid from cidade where cod_cid = cod_cidade) IS NOT NULL) THEN 
       insert into endereço values (null, rua, numero, bairro, cep, cod_cidade);
       Select 'Sucesso ao salvar endereço' as Confirmacao;
    ELSE
		Select 'Não existe cidade com esse código! Digite uma cidade válida!' as Alerta;
    END IF;
END
$$ DELIMITER ;

call inserirEndereco('rua1',1,'bairro1', 11111111, 1);
call inserirEndereco('rua2',2,'bairro2', 22222222, 2);
call inserirEndereco('rua3',3,'bairro3', 33333333, 3);
call inserirEndereco('rua4',4,'bairro4', 44444444, 4);
call inserirEndereco('rua5',5,'bairro5', 55555555, 5);
call inserirEndereco('rua6',6,'bairro6', 66666666, 6);
call inserirEndereco('rua7',7,'bairro7', 77777777, 7);
call inserirEndereco('rua8',8,'bairro8', 88888888, 8);
call inserirEndereco('rua9',9,'bairro9', 99999999, 9);
call inserirEndereco('rua10',10,'bairro10', 10101010, 10);

#Tarefa 4

DELIMITER $$
CREATE procedure inserirSexo(nome varchar(100))
BEGIN 
	IF (nome <> '') THEN 
		IF ((select nome_sex from sexo where nome_sex = nome) IS NULL) THEN
			insert into sexo values (null, nome);
			Select 'Sucesso ao salvar sexo!' as Confirmacao;
        ELSE
			Select 'Esse sexo já existe!' as Alerta;
        END IF;
    ELSE
		Select 'Nome do sexo não pode ser nulo! Insira um valido!' as Alerta;
    END IF;
END
$$ DELIMITER ;

call inserirSexo('Masculino');
call inserirSexo('Feminino');

#Tarefa 5

DELIMITER $$
CREATE procedure inserirTelefone(celular_tel varchar(100), casa_tel varchar(100), trabalho_tel varchar(100))
BEGIN 
	IF (celular_tel <> '') THEN 
			insert into telefone values (null, celular_tel, casa_tel, trabalho_tel);
			Select 'Sucesso ao salvar telefone!' as Confirmacao;
    ELSE
		Select 'Telefone Celular não pode ser nulo! Insira um valido!' as Alerta;
    END IF;
END
$$ DELIMITER ;

call inserirTelefone('6926587945','34215879', '30654789');
call inserirTelefone('6546546546','32541646', '98754654');
call inserirTelefone('9898989895','88498489', '59849845');

#Tarefa 6

DELIMITER $$
CREATE procedure inserirCliente(nome varchar(100), estadocivil varchar(100), cpf varchar(100), rg varchar(100), data_nascimento date, cod_sexo int, cod_endereco int, cod_telefone int)
BEGIN 
	IF ((select rua_end from endereço where cod_end = cod_endereco ) IS NOT NULL) THEN 
		IF ((select nome_sex from sexo where cod_sex = cod_sexo ) IS NOT NULL) THEN 
			IF ((select celular_tel from telefone where cod_tel = cod_telefone ) IS NOT NULL) THEN 
				insert into cliente values (null, nome, estadocivil, cpf, rg, data_nascimento, cod_sexo, cod_endereco, cod_telefone);
                Select 'Cliente cadastrado com sucesso!' as Confirmacao;
			ELSE
				Select 'Esse telefone não existe. Insira um válido!' as Alerta;
			END IF;
		ELSE
			Select 'Esse sexo não existe. Insira um válido!' as Alerta;
		END IF;
    ELSE
		Select 'Esse endereço não existe. Insira um válido!' as Alerta;
    END IF;
END
$$ DELIMITER ;

call inserirCliente('José', 'Casado', '98659475165', '65465465', '1980-01-01', 1, 1, 1);
call inserirCliente('Maria', 'Solteira', '55646546465', '654654654', '1988-09-01', 2, 2, 2);
call inserirCliente('Henrique', 'Casado', '98659475165', '65465465', '1980-01-19', 1, 3, 3);
call inserirCliente('Alfredo', 'Solteiro', '98659475165', '65465465', '2003-01-24', 1, 4, 4);
call inserirCliente('Ana', 'Casada', '98659475165', '65465465', '1997-01-30', 2, 5, 5);

# Tarefa 7
DELIMITER $$
CREATE procedure inserirDepartamento(nome varchar(200), descricao varchar(200))
BEGIN 
	IF (nome <> '') THEN 
		IF (descricao <> '') THEN 
			insert into departamento values (null, nome, descricao);
            Select 'Sucesso ao cadastrar departamento' as Confirmacao;
		ELSE
			Select 'A descricao do departamento não pode ser nula!' as Alerta;
		END IF;
    ELSE
		Select 'O nome do departamento não pode ser nulo!' as Alerta;
    END IF;
END
$$ DELIMITER ;

call inserirDepartamento('Vendas de Passagens', 'Vende passagem de ônibus');
call inserirDepartamento('Regulador de Motorista', 'Organiza os motoristas de cada viagem');
call inserirDepartamento('Entrega de Encomendas', 'Entrega as encomendas feitas pelo site');

# Tarefa 8

DELIMITER $$
CREATE procedure inserirFuncionario(nome varchar(200), cpf varchar(200), rg varchar(200), datanasc date, salario double, funcao varchar(200),
cod_sexo int, cod_departamento int, cod_endereco int, cod_telefone int)
BEGIN 
	IF ((select rua_end from endereço where cod_end = cod_endereco) IS NOT NULL) THEN 
        IF ((select nome_sex from sexo where cod_sex = cod_sexo) IS NOT NULL) THEN 
			IF ((select celular_tel from telefone where cod_tel = cod_telefone) IS NOT NULL) THEN 
				IF ((select nome_dep from departamento where cod_dep = cod_departamento) IS NOT NULL) THEN 
					IF (funcao = 'Vendedor' && (select nome from departamento where cod_dep = cod_departamento) = "Vendas de Passagens") THEN 
						insert into funcionario values (null, nome, cpf, rg, datanasc, salario, funcao, cod_sexo, cod_departamento, cod_endereco, cod_telefone);
						Select 'Sucesso ao salvar funcionário' as Confirmacao;
					ELSE
						Select 'O funcionário vendedor só pode ser cadastrado no departamento Vendas de Passagem!' as Alerta;
					END IF;
				ELSE
					Select 'O departamento informado não existe! Insira um válido!' as Alerta;
				END IF;
			ELSE
				Select 'O telefone informado não existe! Insira um válido!' as Alerta;
			END IF;
		ELSE
			Select 'O sexo informado não existe! Insira um válido!' as Alerta;
		END IF;
    ELSE
		Select 'O endereço informado não existe! Insira um válido!' as Alerta;
    END IF;
END
$$ DELIMITER ;

call inserirFuncionario('José', '98659475165', '65465465', '1980-01-01', 1500, 'Vendedor', 1, 1, 1, 1);
call inserirFuncionario('Fidelio', '98659475165', '65465465', '1985-01-01', 1500, 'Motorista', 1, 2, 2, 2);
call inserirFuncionario('Joana', '65465465456', '946466465', '1995-01-01', 1500, 'Vendedor', 2, 3, 3, 3);
call inserirFuncionario('Maria', '9787878787', '65465465', '1975-01-01', 1500, 'Vendedor', 2, 3, 4, 4);

# Tarefa 9

DELIMITER $$
CREATE procedure inserirOnibus(modelo varchar(200), marca varchar(200), placa varchar(200), tipo varchar(200))
BEGIN 
	IF ((modelo = 'Amazon Bus Premium' && tipo = "Executive" ) || (modelo = 'Amazon Bus Leito' && tipo = 'Confort')) THEN 
		insert into onibus values (null, modelo, marca, placa, tipo);
        Select 'Sucesso ao salvar o ônibus' as Confirmacao;
    ELSE
		Select 'O ônibus só pode ter modelo Amazon Bus Premium e tipo Executive ou modelo Amazon Bus Leito e tipo Confort!' as Alerta;
    END IF;
END
$$ DELIMITER ;

call inserirOnibus('Amazon Bus Premium', 'Amaks', 'abc-369','Executive');
call inserirOnibus('Amazon Bus Premium', 'Amaks', 'def-910','Executive');
call inserirOnibus('Amazon Bus Leito', 'Amaks', 'ghi-101','Confort');
call inserirOnibus('Amazon Bus Leito', 'Amaks', 'jkl-112','Confort');

# Tarefa 10

DELIMITER $$
CREATE procedure inserirPoltronas(cod_onibus int)
BEGIN 
	DECLARE c INT DEFAULT 1;
    IF ((select tipo_oni from onibus where cod_oni = cod_onibus) IS NOT NULL) THEN
		IF ((select tipo_oni from onibus where cod_oni = cod_onibus) = "Executive") THEN 
		SET c = 1;
        WHILE (c <= 48) DO
			insert into poltrona values (null, c, 'Livre', cod_onibus);
            SET c = c + 1;
        END WHILE;
        Select 'Sucesso ao salvar as poltronas para onibus de tipo Executivo' as Confirmacao;
		ELSE
			IF ((select tipo_oni from onibus where cod_oni = cod_onibus) = "Confort") THEN
				SET c = 1;
				WHILE (c <= 58) DO
					insert into poltrona values (null, c, 'Livre', cod_onibus);
					SET c = c + 1;
				END WHILE;
				Select 'Sucesso ao salvar as poltronas para onibus de tipo Confort' as Confirmacao;
			ELSE
				Select 'O ônibus só pode ser dos tipos Executive e Confort' as Alerta;
			END IF;
		END IF;
    ELSE
		Select 'Não existe ônibus com esse id! Insira um ônibus válido!' as Alerta;
    END IF;
END
$$ DELIMITER ;

call inserirPoltronas(1);
call inserirPoltronas(2);
call inserirPoltronas(3);
call inserirPoltronas(4);



