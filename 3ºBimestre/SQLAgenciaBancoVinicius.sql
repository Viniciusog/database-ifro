#Script BD_AgenciaBancaria - Versão 4.0 - Atividade 01 - 3ª Etapa
#SEU NOME: Vinícius
# 3º A Informática

create database BD_Vinicius;
use BD_Vinicius;

create table Banco (
cod_ban int primary key not null auto_increment,
nome_ban varchar (200) not null
);

insert into Banco values (null, 'Caixa Econômica Federal');
insert into Banco values (null, 'Banco do Brasil');


create table Agencia (
cod_ag int primary key not null auto_increment,
numero_ag varchar (100) not null,
nome_ag varchar (100),
telefone_ag varchar (200),
cod_ban_fk int not null,
foreign key (cod_ban_fk) references Banco (cod_ban)
);

insert into Agencia values (null, '0951-2', 'Centro', '69 3421 1111', 2);
insert into Agencia values (null, '4402-1', 'Centro', '69 3422 2299', 2);
insert into Agencia values (null, '1824', 'Centro', '69 3423 1925', 1);
insert into Agencia values (null, '1920', 'Nova Brasilia', '69 3421 1122', 1);


create table Cliente (
cod_cli int primary key not null auto_increment,
nome_cli varchar (200) not null,
cpf_cli varchar (50) not null,
rg_cli varchar (100) not null,
sexo_cli varchar (1),
dataNasc_cli date not null,
renda_cli float not null,
endereco_cli varchar (300) not null,
email_cli varchar (300) not null,
telefone_cli varchar (200) not null
);

insert into Cliente values (null, 'Maria da Silva', '123.123.123-23', '1113322 sesdec/RO', 'F', '1990-10-10', 2500.00, 'Rua das Flores', 'maria.silva@hotmail.com', '3423 3333'); 
insert into Cliente values (null, 'Roberto Carlos', '789.789.789-89', '889977 sesdec/RO', 'M', '1975-01-10', 4990.00, 'Av. Costa', 'roberto.carlos@gmail.com', '8444 8899'); 
insert into Cliente values (null, 'Jane Pereira', '444.666.444-44', '005548 sesdec/RO', 'F', '1989-06-07', 1850.50, 'Rua Presidente', 'jane.pereira@hotmail.com', '9977 8899'); 
insert into Cliente values (null, 'Clodoaldo Bragança', '654.456.654-65', '654658 sesdec/RO', 'F', '1991-10-12', 9850.50, 'Av. Brasil', 'clodoaldo.bragança@gmail.com', '3423 5500'); 
insert into Cliente values (null, 'Livia de Souza', '333.444.666-98', '0033333 sesdec/RO', 'F', '1982-01-30', 1100.00, 'Av. Ji-Parana', 'livia.souza@hotmail.com', '8498 9898'); 
insert into Cliente values (null, 'Joab da Silva', '159.425.456-77', '001215 sesdec/RO', 'M', '2000-10-01', 4990.00, 'Av. Ji-Parana', 'joab.silva@hotmail.com', '69 8411 2321');
insert into cliente values (null, 'Rodrigo Hilbert', '123.445.888-99', '5592 sesdec', 'M', '1970-09-30', 2500.00, 'Rua Dr. Luiz', 'rodrigo.hilbert@yahoo.com.br', '9944 4545');
insert into cliente values (null, 'João Eujácio Teixeira Júnior', '999.445.789-99', '978999992 sesdec', 'M', '1989-01-10', 6000.00, 'Rua Silva Abreu', 'joao.eujacio@ifro.edu.br', '3421 1159');
insert into cliente values (null, 'Everton Feline', '123.123.888-99', '12392 sesdec', 'M', '1987-12-10', 11500.00, 'Rua Alencar Vieira', 'everton.feline@gmail.com','69 84228811');
insert into cliente values (null, 'Igor de Souza Santos', '123.345.848-99', '43299892 sesdec', 'M', '1990-12-30', 1000.00, 'Av. Brasil', 'igor.souza@gmail.com', '69 9977 7777');
insert into cliente values (null, 'Francisco Bezerra', '888.123.111-11', '213156 sesdec', 'M', '1965-01-30', 3500.00, 'Rua Fim do Mundo', 'francisco.bezerra@ifro.edu.br', '69 3423 5502');


create table Conta_Corrente (
cod_cc int primary key not null auto_increment,
numero_cc int not null,
dataAbertura_cc date not null,
saldo_cc float not null,
cod_ag_fk int not null,
cod_cli_fk int not null,
foreign key (cod_ag_fk) references Agencia (cod_ag),
foreign key (cod_cli_fk) references Cliente (cod_cli)
);

insert into Conta_Corrente values (null, 40650, '2009-01-01', 0.00, 1, 1);
insert into Conta_Corrente values (null, 41897, '2009-01-30', 0.00, 1, 2);
insert into Conta_Corrente values (null, 42487, '2010-06-06', 0.00, 1, 3);
insert into Conta_Corrente values (null, 43456, '2011-04-21', 0.00, 1, 4);
insert into Conta_Corrente values (null, 44787, '2012-12-31', 0.00, 1, 5);

create table Deposito (
cod_dep int primary key not null auto_increment,
valor_dep float not null,
data_dep date not null,
tipo_dep varchar (100),
cod_cc_fk int not null,
foreign key (cod_cc_fk) references Conta_Corrente (cod_cc)
);

create table Saque (
cod_saq int primary key not null auto_increment,
valor_saq float not null,
data_saq date not null,
local_saq varchar (100) not null,
hora_saq time,
cod_cc_fk int not null,
foreign key (cod_cc_fk) references Conta_Corrente (cod_cc)
);

create table Transferencia (
cod_trans int primary key not null auto_increment,
valor_trans float not null,
data_trans date not null,
descricao_trans varchar (100), #Exemplo: Pagamento de carro
cod_cc_origem_fk int not null,
cod_cc_destino_fk int not null,
foreign key (cod_cc_origem_fk) references Conta_Corrente (cod_cc),
foreign key (cod_cc_destino_fk) references Conta_Corrente (cod_cc)
);

create table Pagamento (
cod_pag int primary key not null auto_increment,
valor_pag float not null,
data_pag date not null,
tipo_pag varchar (100), #Tipos possíveis: Boleto ou Convênio
dataVencimento_pag date not null,
codigoBarras_pag varchar (300),
cod_cc_fk int not null,
foreign key (cod_cc_fk) references Conta_Corrente (cod_cc)
);

#Tarefa 1
#1º
DELIMITER $$
CREATE TRIGGER adicionarValorDepositoNaContaCorrente AFTER INSERT
ON deposito FOR EACH ROW
BEGIN
	UPDATE Conta_Corrente SET saldo_cc = saldo_cc + NEW.valor_dep WHERE cod_cc = NEW.cod_cc_fk;
END;
$$ DELIMITER ;

#2º
DELIMITER $$
CREATE PROCEDURE inserirDeposito(valor_deposito float, data_deposito date, tipo_deposito varchar(100), cod_conta_corrente int) 
BEGIN
	IF (valor_deposito > 0) THEN
		IF (tipo_deposito = "Cheque") THEN
				IF (valor_deposito > 2000) THEN
					Select "Valor de depósito em cheque não pode ser mais que 2000." as Alerta;
                ELSE
					INSERT INTO Deposito (valor_dep, data_dep, tipo_dep, cod_cc_fk) VALUES 
                    (valor_deposito, data_deposito, tipo_deposito, cod_conta_corrente);
                    SELECT "Sucesso ao realizar deposito em cheque." AS Informacao;
                END IF;
        ELSE 
			IF (tipo_deposito = "Dinheiro") THEN
				IF (valor_deposito > 5000) THEN
					Select "Valor de depósito em dinheiro não pode ser mais que 5000." as Alerta;
                ELSE
					INSERT INTO Deposito (valor_dep, data_dep, tipo_dep, cod_cc_fk) VALUES 
                    (valor_deposito, data_deposito, tipo_deposito, cod_conta_corrente);
                    SELECT "Sucesso ao realizar deposito em dinheiro." AS Informacao;
                END IF;
            ELSE 
				Select "Depósito só pode ser feito em Cheque ou Dinheiro." as Alerta;
            END IF;
        END IF;
    ELSE
		Select "Valor de depósito deve ser mais que R$ 0,00" as Alerta;
    END IF;
END;
$$ DELIMITER ;


call inserirDeposito(5000, '2020-08-18', "Dinheiro", 1);
call inserirDeposito(1500, '2020-07-11', "Cheque", 2);
call inserirDeposito(100, '2020-04-15', "Cheque", 3);
call inserirDeposito(4200, '2020-03-18', "Dinheiro", 4);
call inserirDeposito(3200, '2020-06-02', "Dinheiro", 5);

#Tarefa 2
# 1º
DELIMITER $$
CREATE TRIGGER removerValorDoSaqueNaContaCorrente AFTER INSERT
ON Saque FOR EACH ROW
BEGIN
	UPDATE Conta_Corrente SET saldo_cc = saldo_cc - NEW.valor_saq WHERE cod_cc = NEW.cod_cc_fk;
END;
$$ DELIMITER ;

#2º
DELIMITER $$
CREATE PROCEDURE inserirSaque(valor_saque float, data_saq date, local_saq varchar(100), hora_saq time, cod_conta_corrente int)
BEGIN
	IF (valor_saque <= (SELECT saldo_cc FROM Conta_Corrente WHERE cod_cc = cod_conta_corrente)) THEN
		IF ( valor_saque > 3000) THEN
			SELECT "O valor de saque deve ser menor ou igual a R$ 3000,00" as Alerta;
        ELSE
			IF (hora_saq BETWEEN '00:00' AND '06:00') THEN
				SELECT "Não é possível realizar saques entre as 0 horas e 6 da manhã" as Alerta;
            ELSE 
				INSERT INTO Saque (valor_saq, data_saq, local_saq, hora_saq, cod_cc_fk) 
                VALUES (valor_saque, data_saq, local_saq, hora_saq, cod_conta_corrente);
                SELECT "Sucesso ao realizar saque!" as Informacao;
            END IF;
        END IF;
    ELSE
		SELECT "Saldo na Conta Corrente insuficiente para esse valor de saque!" as Alerta;
    END IF;
END;
$$ DELIMITER ;

call inserirSaque(2000, '2020-08-15', "Ji-Paraná", "06:07", 1);
call inserirSaque(200, '2020-07-06', "Ji-Paraná", "08:49", 2);
call inserirSaque(100, '2020-08-15', "Ji-Paraná", "12:45", 3);
call inserirSaque(2005, '2020-04-13', "Ji-Paraná", "07:45", 4);
call inserirSaque(1400, '2020-06-19', "Ji-Paraná", "18:45", 5);

#Tarefa 3
#1º
DELIMITER $$
CREATE TRIGGER inserirTransferencia AFTER INSERT 
ON transferencia FOR EACH ROW
BEGIN 
	UPDATE conta_corrente SET saldo_cc = saldo_cc - NEW.valor_trans WHERE cod_cc = NEW.cod_cc_origem_fk;
	UPDATE conta_corrente SET saldo_cc = saldo_cc + NEW.valor_trans WHERE cod_cc = NEW.cod_cc_destino_fk;
END;
$$ DELIMITER ;


#2º
DELIMITER $$	
CREATE PROCEDURE inserirTransferencia(valor_transf float, data_transf date, descricao_transf varchar(100),
cod_conta_corrente_origem int, cod_conta_corrente_destino int) 
BEGIN
	IF (valor_transf <= (SELECT saldo_cc FROM conta_corrente WHERE cod_cc = cod_conta_corrente_origem)) THEN
		IF (cod_conta_corrente_origem != cod_conta_corrente_destino) THEN
			INSERT INTO transferencia (valor_trans, data_trans, descricao_trans, cod_cc_origem_fk, cod_cc_destino_fk) VALUES
            (valor_transf, data_transf, descricao_transf, cod_conta_corrente_origem, cod_conta_corrente_destino);
            SELECT "Sucesso ao realizar transferência" AS Informcação;
        ELSE
			SELECT "Conta de Origem e Destino devem ser diferentes!" as Alerta;
        END IF;
    ELSE
		SELECT "Saldo insuficiente para realizar essa transferência!" as Alerta;
    END IF;
END;
$$ DELIMITER  ;

call inserirTransferencia(2000, '2020-08-18', "Pagar o Trabalho do Marcelo", 1, 3);

#Tarefa 4
#1º 
DELIMITER $$
CREATE TRIGGER inserirPagamento AFTER INSERT
ON pagamento FOR EACH ROW
BEGIN
	UPDATE conta_corrente SET saldo_cc = saldo_cc - NEW.valor_pag WHERE cod_cc = NEW.cod_cc_fk;
END;
$$ DELIMITER ;

DELIMITER $$ 
CREATE PROCEDURE inserirPagamento(valor_pagt float, data_pagt date, tipo_pagt varchar(100), data_vencimento_pag date, 
codigo_barras_pag varchar(300), cod_conta_corrente_fk int) 
BEGIN
	IF (valor_pagt <= (SELECT saldo_cc FROM conta_corrente WHERE cod_cc = cod_conta_corrente_fk)) THEN
		IF (current_time() BETWEEN '09:00' AND '21:00') THEN
			IF (length(codigo_barras_pag) = 10) THEN
				INSERT INTO pagamento (valor_pag, data_pag, tipo_pag, dataVencimento_pag, codigoBarras_pag, cod_cc_fk) VALUES
                (valor_pagt, data_pagt, tipo_pagt, data_vencimento_pag, codigo_barras_pag, cod_conta_corrente_fk);
                SELECT "Sucesso ao realizar o seu pagamento." as Informacao;
            ELSE
				SELECT "O código de barras precisa ter exatamente 10 caracteres!" as Alerta;
            END IF;
        ELSE
			SELECT "Pagamentos só podem ser realizados entre 9 horas e 21 horas" as Alerta;
        END IF;
    ELSE
		SELECT "Saldo da conta corrente insuficiente para realizar esse pagamento!" AS Alerta;
    END IF;
END;
$$ DELIMITER ;


call inserirPagamento(1200, '2020-08-18', 'Pagamento de contas', '2020-08-24', 'ABH5JSKF93', 4);
call inserirPagamento(150, '2020-08-18', 'Imposto da Moto', '2020-08-24', 'ABH5JSKF93', 3);
call inserirPagamento(240, '2020-08-18', 'Pedreiro', '2020-08-24', 'A54SD5D5F4', 1);