create database bd_vinicius;
use bd_vinicius;

CREATE TABLE Controle (
    cod_cont INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    mes_cont VARCHAR(100) NOT NULL,
    saldoanterior_cont FLOAT NOT NULL,
    totalrenda_cont FLOAT NOT NULL,
    totalgastos_cont FLOAT NOT NULL,
    saldofinal_cont FLOAT NOT NULL
);

insert into controle values (null, 'Agosto/2020', 0, 4000, 1000, 3000 );

CREATE TABLE Renda (
    cod_ren INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    referencia_ren VARCHAR(100) NOT NULL,
    valor_ren FLOAT NOT NULL,
    data_ren DATE,
    cod_cont_fk INT NOT NULL,
    FOREIGN KEY (cod_cont_fk) REFERENCES Controle (cod_cont)
);
insert into renda values (null, 'Salario Marido', 2000, '2020-08-05', 1);
insert into renda values (null, 'Salario Esposa', 2000, '2020-08-05', 1);
CREATE TABLE gasto (
    cod_gas INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    referencia_gas VARCHAR(100) NOT NULL,
    valor_gas FLOAT NOT NULL,
    data_gas DATE,
    cod_cont_fk INT NOT NULL,
    FOREIGN KEY (cod_cont_fk) REFERENCES Controle (cod_cont)
);
insert into gasto values (null, 'Energia', 300, '2020-08-15', 1);
insert into gasto values (null, 'Aluguel', 600, '2020-08-20', 1);
insert into gasto values (null, 'Agua', 100, '2020-08-20', 1);

DELIMITER $$
CREATE PROCEDURE inserirControle(mes VARCHAR(100)) 
BEGIN
	declare vMes varchar(30);
    declare vAno varchar(30);
    declare vMesEAno varchar(30);
    declare numeroVMes int default 0;
   
    declare numeroMesAnterior int default 0;
    declare numeroAnoDoMesAnterior int default 0;
    declare vMesAnterior varchar(30);
	declare saldoMesAnterior float DEFAULT 0;
    declare vMesEAnoAnterior varchar(30);
    

	
	IF ( (SELECT  mes_cont FROM controle WHERE mes_cont = mes) IS NOT NULL ) THEN
		SELECT "Já existe um controle cadastrado com esse mês de referência!" AS Alerta;
	ELSE 
		/*Pega todos os caracteres que estão antes da barra e adiciona na variável vMes*/
		set vMes = left(mes, instr(mes, "/") - 1);
        /*Pega todos os caracteres que estão depois da barra e adiciona na variável vAno*/
        set vAno = substring_index(mes, "/", -1);
        set vMesEAno =  concat(concat(vMes, "/"), vAno);
        select vMes as mesParametro;
        select vAno as anoParametro;
        /*Pega o número do mês em parâmetro*/
        set numeroVMes = month(str_to_date(substring(vMes, 1, 3), "%b"));
        select numeroVMes as numeroMesParametro;
        IF ( numeroVMes > 1 AND numeroVMes <= 12)  THEN
			/*Pega o número do mês anterior*/
			set numeroMesAnterior = numeroVMes - 1;
            set numeroAnoDoMesAnterior = vAno;
        ELSE 
			set numeroMesAnterior = 12;
            set numeroAnoDoMesAnterior = vAno - 1;         
        END IF;
		
        select numeroMesAnterior as numeroDoMesAnterior;
        select numeroAnoDoMesAnterior as numeroDoAnoDoMesAnterior;
        /*Passa o número do mês anterior para o nome do mês anterior*/
		SET vMesAnterior = monthname(str_to_date(numeroMesAnterior, "%m"));
        SET vMesEAnoAnterior  = concat(concat(vMesAnterior, "/"), numeroAnoDoMesAnterior);
        SELECT vMesEAnoAnterior as MesEAnoAnterior;
		
        /*Pegar saldo final do mês anterior e adicionar ao saldo anterior do mês atual*/
		SET saldoMesAnterior = (SELECT saldofinal_cont FROM Controle WHERE mes_cont = vMesEAnoAnterior);
        
        /*Não existe mês anterior ao inserido*/
        IF (saldoMesAnterior IS NULL OR saldoMesAnterior = 0) THEN
			 INSERT INTO Controle VALUES (null, mes, 0, 0, 0, 0);
			 Select "Sucesso ao inserir Controle!" as Confirmacao;
        ELSE
			 INSERT INTO Controle VALUES (null, mes, saldoMesAnterior, 0, 0, saldoMesAnterior);
			 Select "Sucesso ao inserir Controle!" as Confirmacao;
        END IF;
      
        SELECT * FROM Controle;
       
    END IF;
END;
$$ DELIMITER ;

insert into controle values ( null, "August/2020", 0, 0, 0, 5000);

call inserirControle("September/2020");

DELIMITER $$
CREATE TRIGGER adicionarValorRendaEmControle AFTER INSERT ON Renda FOR EACH ROW
BEGIN
	UPDATE Controle SET Controle.totalrenda_cont = Controle.totalrenda_cont 
    + NEW.valor_ren WHERE Controle.cod_cont = NEW.cod_cont_fk;
    UPDATE Controle SET Controle.saldofinal_cont 
    = Controle.saldoanterior_cont + Controle.totalrenda_cont - Controle.totalgastos_cont WHERE Controle.cod_cont = NEW.cod_cont_fk;
END;
$$ DELIMITER ;

select * from controle;
insert into renda values (null, "Investimentos", 4000, '2020-09-17', 3);


DELIMITER $$
CREATE TRIGGER updateValorRendaEmControle BEFORE UPDATE ON Renda FOR EACH ROW
BEGIN 
	declare antigoValorRenda FLOAT DEFAULT 0;
    SET antigoValorRenda = OLD.valor_ren; /*(SELECT Renda.valor_ren FROM Renda WHERE Renda.cod_ren = OLD.cod_ren);*/
    -- Remove a quantidade antiga de uma determinada renda na quantidade total de renda
    UPDATE Controle SET Controle.totalrenda_cont = Controle.totalrenda_cont - antigoValorRenda 
    WHERE Controle.cod_cont = NEW.cod_cont_fk;
    -- Adiciona o valor novo da renda na quantidade total de renda
    UPDATE Controle SET Controle.totalrenda_cont = Controle.totalrenda_cont + NEW.valor_ren 
    WHERE Controle.cod_cont = NEW.cod_cont_fk;
    
    UPDATE Controle SET Controle.saldofinal_cont = Controle.saldoanterior_cont + Controle.totalrenda_cont - Controle.totalgastos_cont
    WHERE Controle.cod_cont = NEW.cod_cont_fk;

    
END;

select * from renda;
select * from controle;
update renda set valor_ren = 1000 WHERE cod_ren = 3;

DELIMITER $$
CREATE TRIGGER removerRendaEmControle AFTER DELETE ON Renda FOR EACH ROW
BEGIN
	UPDATE Controle SET Controle.totalrenda_cont = Controle.totalrenda_cont - OLD.valor_ren 
		WHERE Controle.cod_cont = OLD.cod_cont_fk;
    UPDATE Controle SET Controle.saldofinal_cont = Controle.saldoanterior_cont + Controle.totalrenda_cont - Controle.totalgastos_cont 
		WHERE Controle.cod_cont = OLD.cod_cont_fk;
END;
$$ DELIMITER ;

delete from renda where cod_ren = 3;
select * from controle;
select* from renda;


DELIMITER $$
CREATE TRIGGER adicionarValorGastoEmControle AFTER INSERT ON Gasto FOR EACH ROW
BEGIN	
	UPDATE Controle SET Controle.totalgastos_cont = Controle.totalgastos_cont + NEW.valor_gas WHERE Controle.cod_cont = NEW.cod_cont_fk;
    
    UPDATE Controle SET Controle.saldofinal_cont = Controle.saldoanterior_cont + Controle.totalrenda_cont - Controle.totalgastos_cont 
    WHERE Controle.cod_cont = NEW.cod_cont_fk;
END;
$$ DELIMITER ;

select * from controle;
insert into Gasto values (null, 'Imposto', 500, '2020-06-03', 3);

DELIMITER $$
CREATE TRIGGER updateValorGastoEmControle BEFORE UPDATE ON Gasto FOR EACH ROW
BEGIN
	DECLARE valorAntigoGasto FLOAT default 0;
    SET valorAntigoGasto = OLD.valor_gas;
    -- Remove o valor antigo de gastos em total de gastos
	UPDATE Controle SET Controle.totalgastos_cont = Controle.totalgastos_cont - OLD.valor_gas WHERE Controle.cod_cont = NEW.cod_cont_fk;
    -- Adiciona o valor novo do gasto em total de gastos
    UPDATE Controle SET Controle.totalgastos_cont = Controle.totalgastos_cont + NEW.valor_gas WHERE controle.cod_cont = NEW.cod_cont_fk;
    UPDATE Controle SET Controle.saldofinal_cont = Controle.saldoanterior_cont + Controle.totalrenda_cont - Controle.totalgastos_cont 
    WHERE Controle.cod_cont = NEW.cod_cont_fk;
END;
$$ DELIMITER ;

update gasto SET valor_gas = 1000 where cod_gas = 4;

DELIMITER $$
CREATE TRIGGER removerGastoEmControle AFTER DELETE ON Gasto FOR EACH ROW
BEGIN
	UPDATE Controle SET Controle.totalgastos_cont = Controle.totalgastos_cont - OLD.valor_gas WHERE Controle.cod_cont = OLD.cod_cont_fk;
    UPDATE Controle SET Controle.saldofinal_cont = Controle.saldoanterior_cont + Controle.totalrenda_cont - Controle.totalgastos_cont 
    WHERE Controle.cod_cont = OLD.cod_cont_fk;
END;
$$ DELIMITER ;

DELETE FROM gasto WHERE cod_gas = 4;
select * from controle;

DELIMITER $$
CREATE PROCEDURE inserirRenda(referencia_renda varchar(100), valor_renda FLOAT, data_renda DATE, codigo_controle_fk INT)
BEGIN
select * from renda;
	IF (valor_renda > 0) THEN
		INSERT INTO Renda (referencia_ren, valor_ren, data_ren, cod_cont_fk) VALUES (referencia_renda, valor_renda, data_renda, codigo_controle_fk); 
        SELECT "Renda inserida com sucesso!" AS Confirmacao;
    ELSE
		SELECT "O valor da renda deve ser maior que 0!" AS Alerta;
    END IF;
END;
$$ DELIMITER ;

select * from controle;
call inserirRenda("Salário 1", 4000, "2020-04-05", 3);
call inserirRenda("Investimentos CDB", 1000, "2020-04-06", 3);
call inserirRenda("Salário 2", 4000, "2020-04-07", 3);
call inserirRenda("Salário 3", 4000, "2020-06-12", 3);

-- TAREFA 5
DELIMITER $$ 
CREATE PROCEDURE inserirGasto(referencia_gas VARCHAR(100), valor_gas FLOAT, data_gas DATE, cod_cont_fk INT) 
BEGIN
	DECLARE saldoFinalControle FLOAT DEFAULT 0;
    DECLARE totalGastosControle FLOAT DEFAULT 0;

	IF (valor_gas > 0) THEN
		INSERT INTO Gasto VALUES (null, referencia_gas, valor_gas, data_gas, cod_cont_fk);
        SELECT "Sucesso ao inserir gasto!" AS Confirmacao;
        SET saldoFinalControle = (SELECT saldofinal_cont FROM Controle WHERE Controle.cod_cont = cod_cont_fk);
        SET totalGastosControle = (SELECT totalgastos_cont FROM Controle WHERE Controle.cod_cont = cod_cont_fk);
        
        IF (saldoFinalControle > totalGastosControle) THEN
			SELECT concat("Saldo final positivo no valor de: R$ ", saldoFinalControle) as Confirmacao;
        ELSE
			IF (saldoFinalControle = totalGastosControle) THEN
				SELECT "Saldo zerado no valor de R$ 0,00." as Confirmacao;
			ELSE
				IF (saldoFinalControle < totalGastosControle) THEN
					SELECT concat("Saldo negativo no valor de: R$ ", saldoFinalControle)  as Confirmacao; 
				ELSE
					SELECT "Erro ao verificar saldo!" as Alerta;
				END IF;
			END IF;
        END IF;
    ELSE	
		SELECT "O valor do gasto não pode ser 0!" AS Alerta;
    END IF;
END;
$$ DELIMITER ;

SELECT * FROM controle;

call inserirGasto("Conta de luz", 1000, '2020-04-06', 3);
call inserirGasto("Imposto", 2000, '2020-03-06', 3);
call inserirGasto("Despesa Reforma", 3000, '2020-08-06', 3);
call inserirGasto("Imposto 2", 1000, '2020-04-25', 3);
call inserirGasto("Conta de luz", 1000, '2020-04-06', 3);