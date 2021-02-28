create database bd_hotel;
use bd_hotel;


create table Endereco (
cod_end integer not null primary key auto_increment,
rua_end varchar (300),
numero_end integer,
bairro_end varchar (100),
cidade_end varchar (100),
estado_end varchar (100)
); 

insert into Endereco values (null, 'Av. Brasil', 111, 'Nova Brasília', 'Ji-Paraná', 'Rondônia');
insert into Endereco values (null, 'Av. Marechal Rondon', 1245, 'Centro', 'Ji-Paraná', 'Rondônia');
insert into Endereco values (null, 'Rua Dr. Telma Rios', 1174, 'Colina Park I', 'Ji-Paraná', 'Rondônia');
insert into Endereco values (null, 'Av. Aracaju', 911, 'BNH', 'Ji-Paraná', 'Rondônia');
insert into Endereco values (null, 'Rua 07 de Setembro', 121, 'Dom Bosco', 'Ji-Paraná', 'Rondônia');
insert into Endereco values (null, 'Rua Mato Grosso', 887, 'Jardim dos Migrantes', 'Ji-Paraná', 'Rondônia');
insert into Endereco values (null, 'Av. Jorge Teixeira', 1589, 'Centro', 'Porto Velho', 'Rondônia');
insert into Endereco values (null, 'Av. Paulista', 989, 'Centro', 'São Paulo', 'São Paulo');
insert into Endereco values (null, 'Travessa dos Mineiros', 456, 'Centro', 'Ariquemes', 'Rondônia');
insert into Endereco values (null, 'Av. Monte Castelo', 555, 'Jardim dos Migrantes', 'Ji-Paraná', 'Rondônia');


create table Cliente (
cod_cli integer not null primary key auto_increment,
nome_cli varchar (200) not null,
estadocivil_cli varchar (50),
cpf_cli varchar (20) not null,
rg_cli varchar (30),
sexo_cli varchar (30),
datanasc_cli date,
rendafamiliar_cli double,
telefone_cli varchar (50) not null,
celular_cli varchar (50) not null,
cod_end integer not null,
foreign key (cod_end) references Endereco (cod_end)
);

insert into cliente values (null, 'Jackson Henrique da Silva Bezerra', 'Casado', '111.111.111-11', '54654 sesdec', 'Masculino', '1987-06-30', 
10000.00, '69 84085712', '69 84111111', 3);
insert into cliente values (null, 'Tony Stark', 'Casado', '111.111.111-22', '54654 sesdec', 'Masculino', '1965-1-1', 
456454.45, '', '', 8);
insert into cliente values (null, 'Capitão América', 'Solteiro', '111.111.111-33', '48877 sesdec', 'Masculino', '1950-05-30', 
0.00, '11 454546511', '', 1);
insert into cliente values (null, 'José Pereira da Silva', 'Casado', '222.222.222-88', '8888888 spp', 'Masculino', '1990-11-12', 
900.00, '69 88998899', '69 4444 4444', 4);
insert into cliente values (null, 'Maria de Jesus dos Santos', 'Solteira', '554.454.444-99', '99999 sesdec', 'Feminino', '1993-06-21', 
3000.00, '69 3421 5511', '69 99111111', 3);
insert into cliente values (null, 'Camila de Oliveira', 'Casada', '987.123.654-55', '8889999 sesdec', 'Feminino', '2000-12-12', 
5450.00, '69 3421 1122', '69 9999 7788', 10);
insert into cliente values (null, 'Marcos Araujo de Souza', 'Casado', '654.789.123-88', '998877 sesdec', 'Masculino', '1970-01-01', 
6845.00, '69 84085712', '69 84111111', 9);
insert into cliente values (null, 'Cleiton Batista Ferraz', 'Solteiro', '321.111.222-44', '1234312 sesdec', 'Masculino', '1982-07-30', 
4199.00, '69 3421 2211', '69 84118811', 2);
insert into cliente values (null, 'Eliana da Cruz', 'Solteira', '988.235.654-54', '12345 sesdec', 'Feminino', '1978-11-11', 
3250.00, '69 3421 9999', '69 84118811', 5);
insert into cliente values (null, 'Igor Garcia da Silva', 'Solteiro', '123.445.888-99', '999992 sesdec', 'Masculino', '1989-12-30', 
9600.00, '69 3421 1123', '69 84118811', 3);


create table Funcionario (
cod_func integer not null primary key auto_increment,
nome_func varchar (200) not null,
cpf_func varchar (20) not null,
rg_func varchar (20),
sexo_func varchar (30),
datanasc_func date,
salário_func double not null,
telefone_func varchar (50),
celular_func varchar (50) not null,
função_func varchar (50) not null,
cod_end integer not null,
foreign key (cod_end) references Endereco (cod_end)
);

insert into funcionario values (null, 'João Eujacio Teixeira', '123.544.311-99', '22222 sesdec', 'Masculino', '1988-10-30', 
5000.00, '', '69 84111155', 'Atendente', 2);
insert into funcionario values (null, 'Paula Fernandes', '565.888.988-88', '64444 sesdec', 'Feminino', '1965-1-20', 
45000.00, '', '', 'Atendente', 1);
insert into funcionario values (null, 'Roberto Carlos', '998.999.789-55', '46666 sesdec', 'Masculino', '1990-05-23', 
1500.00, '11 454546511', '', 'Gerente', 5);


create table Produto (
cod_prod int primary key not null auto_increment,
descrição_prod varchar (200) not null,
quantidade_prod int,
valor_prod float,
dataValidade_prod date
);

insert into produto values (null, 'Agua Mineral Sem Gás 500ml', 50, 3.50, '2020-01-01');
insert into produto values (null, 'Chocolate em Barra 200gr', 30, 4.80, '2018-06-30');
insert into produto values (null, 'Cerveja Skol 350ml', 10, 4.50, '2019-01-01');
insert into produto values (null, 'Vinho Tinto 700ml', 10, 50.50, '2019-01-01');

create table Quarto (
cod_qua int primary key not null auto_increment,
descrição_qua varchar (200) not null,
número_qua int not null,
tipo_qua varchar (100) not null,
valor_qua float
);

insert into quarto values (null, 'Apartamento Duplo', 100, 'Luxo', 200.00);
insert into quarto values (null, 'Apartamento Duplo', 101, 'Simples', 100.00);
insert into quarto values (null, 'Apartamento Individual', 201, 'Simples', 50.00);
insert into quarto values (null, 'Apartamento Tripo', 202, 'Simples', 150.00);
insert into quarto values (null, 'Apartamento Duplo', 301, 'Luxo', 200.00);
insert into quarto values (null, 'Apartamento Duplo', 302, 'Simples', 100.00);
insert into quarto values (null, 'Apartamento Individual', 401, 'Simples', 50.00);
insert into quarto values (null, 'Apartamento Tripo', 402, 'Simples', 150.00);

create table Produtos_quarto (
cod_pq int primary key not null auto_increment,
quantidade_pq int,
dataRecarga_pq date,
cod_qua int not null,
cod_prod int not null,
foreign key (cod_qua) references quarto (cod_qua),
foreign key (cod_prod) references produto (cod_prod)
);


insert into produtos_quarto values (null, 2, '2017-03-29', 1, 1);
insert into produtos_quarto values (null, 5, '2017-03-29', 1, 2);
insert into produtos_quarto values (null, 2, '2017-03-29', 1, 3);

insert into produtos_quarto values (null, 2, '2017-03-30', 2, 1);
insert into produtos_quarto values (null, 1, '2017-03-30', 2, 3);

insert into produtos_quarto values (null, 5, '2017-03-29', 3, 1);
insert into produtos_quarto values (null, 5, '2017-03-29', 3, 2);

insert into produtos_quarto values (null, 5, '2017-03-29', 4, 2);
insert into produtos_quarto values (null, 5, '2017-03-29', 5, 4);

create table Hospedagem (
cod_hosp int primary key not null auto_increment,
dataCheckin_hosp date,
dataCheckout_hosp date,
valorConsumo_hosp float,
valorDiárias_hosp float,
valorTotal_hosp float,
cod_cli int not null,
cod_func int not null,
foreign key (cod_cli) references Cliente (cod_cli),
foreign key (cod_func) references Funcionario (cod_func)
);


insert into hospedagem values (null, '2017-03-29', '2017-03-31', 25.00, 200.00, 0.00, 1, 1);
insert into hospedagem values (null, '2017-03-29', '2017-04-01', 10.00, 100.00, 0.00, 2, 1);
insert into hospedagem values (null, '2017-03-31', '2017-04-05', 15.00, 300.00, 0.00, 10, 1);
insert into hospedagem values (null, '2018-03-29', '2018-04-30', 25.00, 200.00, 0.00, 8, 2);
insert into hospedagem values (null, '2018-03-29', '2018-05-01', 10.00, 100.00, 0.00, 9, 2);
insert into hospedagem values (null, '2018-03-31', '2018-06-05', 15.00, 300.00, 0.00, 1, 2);

create table produtos_hospedagem (
cod_ph int primary key not null auto_increment,
cod_hosp int not null,
cod_prod int not null,
quant_ph int,
valorProd_ph float,
foreign key (cod_hosp) references Hospedagem (cod_hosp),
foreign key (Cod_prod) references Produto (cod_prod)
);

insert into produtos_hospedagem values (null, 1, 1, 3, 0.00);
insert into produtos_hospedagem values (null, 1, 2, 1, 0.00);

insert into produtos_hospedagem values (null, 2, 1, 3, 0.00);
insert into produtos_hospedagem values (null, 2, 3, 3, 0.50);

insert into produtos_hospedagem values (null, 3, 2, 1, 0.00);
insert into produtos_hospedagem values (null, 3, 3, 3, 0.00);
insert into produtos_hospedagem values (null, 3, 1, 10, 0.00);


create table quartos_hospedagem (
cod_qh int primary key not null auto_increment,
cod_hosp int not null,
cod_qua int not null,
quantDiárias_ph int,
valorQuarto_ph float,
foreign key (cod_hosp) references Hospedagem (cod_hosp),
foreign key (Cod_qua) references Quarto (cod_qua)
);

insert into quartos_hospedagem values (null, 1, 2, 2, 0.00);
insert into quartos_hospedagem values (null, 2, 3, 3, 0.00);
insert into quartos_hospedagem values (null, 3, 1, 10, 0.00);
insert into quartos_hospedagem values (null, 4, 6, 5, 0.00);
insert into quartos_hospedagem values (null, 5, 5, 10, 0.00);
insert into quartos_hospedagem values (null, 6, 2, 5, 0.00);

#Exercício 1
DELIMITER $$
CREATE procedure calculadora(n1 int, n2 int, operacao varchar(2))
BEGIN 
DECLARE resultado FLOAT;

IF (n1 IS NOT NULL AND n2 IS NOT NULL) THEN
	IF (operacao = "+") THEN
		SET resultado = n1 + n2;
		SELECT CONCAT('O resultado da soma é ', resultado) as Resultado;
	ELSE 
		IF (operacao = "-") THEN
			SET resultado = n1 - n2;
			SELECT CONCAT('O resultado da subtração é ', resultado) as Resultado;
		ELSE 
			IF (operacao = "*") THEN
				SET resultado = n1 * n2;
				SELECT CONCAT('O resultado da multiplicação é ', resultado) as Resultado;
			ELSE
				IF (operacao = "/") THEN
					SET resultado = n1 / n2;
					SELECT CONCAT('O resultado da divisão é ', resultado) as Resultado;
				ELSE 
					SELECT 'Escolha uma dessas operações: + - * /' as Alerta;
				END IF;
			END IF;
		END IF;
	END IF;
ELSE 
	SELECT 'Os dois valores devem ser diferentes de nulo' as Alerta;
END IF;
END
$$ DELIMITER ;
call calculadora (10, 2, "+");

#Exercicio 2
DELIMITER $$
CREATE PROCEDURE tipoDoCliente(codigo int)
BEGIN 
DECLARE totalHospedagem FLOAT;
	IF (codigo IS NOT NULL) THEN
		IF ((Select COUNT(*) FROM Cliente WHERE cod_cli = codigo) <> 0) THEN 
			UPDATE hospedagem SET valorTotal_hosp = datediff(dataCheckout_hosp, dataCheckin_hosp) * valorDiárias_hosp + valorConsumo_hosp WHERE cod_cli = codigo;
			SELECT SUM(valorTotal_hosp) INTO totalHospedagem FROM hospedagem WHERE cod_cli = codigo;
            
            IF (totalHospedagem > 1000) THEN
				SELECT 'Cliente VIP' as Categoria;
            ELSE 
				IF (totalHospedagem BETWEEN 500 AND 1000) THEN 
					SELECT 'Cliente Normal' as Categoria;
				ELSE 
					IF (totalHospedagem < 500) THEN
						SELECT 'Cliente popular' as Categoria;
                    END IF;
                END IF;
            END IF;
        ELSE 
			SELECT 'Não existe cliente com esse id' as Alerta;
        END IF;
    ELSE 
		SELECT 'O código do cliente não pode ser nulo!' as Alerta;
    END IF;
END 
$$ DELIMITER ;

CALL tipoDoCliente(9);

#Exercicio 3
DELIMITER $$
CREATE PROCEDURE aumentarOuDiminuir(valor int, tipo varchar(30)) 
BEGIN
	IF (tipo = "aumentar") THEN
		IF (valor BETWEEN 0 AND 50) THEN
			UPDATE Produto SET valor_prod = valor_prod + (valor_prod * (valor / 100)) WHERE cod_prod > 0;
            SELECT 'Produtos atualizados com sucesso' AS Resultado;
        ELSE 
			SELECT 'A taxa de aumento não pode ser maior que 50' AS Resultado;
        END IF;
    ELSE
		IF (tipo = "diminuir") THEN
			IF (valor BETWEEN 0 AND 20) THEN
				UPDATE Produto SET valor_prod = valor_prod - (valor_prod * (valor / 100)) WHERE cod_prod > 0;
				SELECT 'Produtos atualizados com sucesso' AS Resultado;
            ELSE
				SELECT 'A taxa de diminuição não pode ser maior que 20' AS Resultado;
            END IF;
        ELSE
			SELECT 'Escolha entre: diminuir/aumentar' AS Resultado;
        END IF;
    END IF;
END
$$ DELIMITER ;

call aumentarOuDiminuir(40, "aumentar");



