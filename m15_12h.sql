/* 12º H */
/* Criar a tabela dos EE (incompleto)*/
CREATE TABLE T_ENC_ED
(
	nprocesso varchar(6) primary key,
	nome varchar(100)
)

/* Criar a tabela T_ALUNOS*/
CREATE TABLE T_ALUNOS(
 n_processo INT IDENTITY(25216,1) PRIMARY KEY,
 nome NVARCHAR(100) NOT NULL
	CHECK (len(nome)>2 AND charindex(' ',trim(nome))>0),
 tipo_documento VARCHAR(20) NOT NULL 
	CHECK (tipo_documento IN ('CC',' Visto', 'Passaporte', 'Outro')),
 n_documento VARCHAR(20) NOT NULL,
 NIF CHAR(9) UNIQUE CHECK(len(nif)=9),
 sexo CHAR(1) NOT NULL CHECK (sexo IN ('f','m')),
 nacionalidade VARCHAR(20) DEFAULT 'Portuguesa',
 data_nascimento DATE NOT NULL 
	CHECK (datediff(year,data_nascimento,getdate())>=14 AND
	datediff(year,data_nascimento,getdate())<=21),
	morada VARCHAR(100) NOT NULL,
	codigo_postal CHAR(8) 
		CHECK ( codigo_postal like '[1-9][0-9][0-9][0-9]-[0-9][0-9][0-9]'),
	email_pessoal NVARCHAR(100) NOT NULL 
		CHECK (email_pessoal LIKE '%@%.%' AND 
		CHARINDEX('@',email_pessoal) < CHARINDEX('.',email_pessoal)),
	tempo_percurso TIME, /* HH:MM */ 
	nr_agregado TINYINT DEFAULT 1 
		CHECK ( nr_agregado >= 1 AND nr_agregado < 20),
	escalao_ase CHAR(1) CHECK (escalao_ase IN ('A','B','C')),
	medidas_dl_54 bit DEFAULT 0,
	delegado bit DEFAULT 0,

 	/* CONSTRAINTS */
	CONSTRAINT verifica_documento UNIQUE(tipo_documento,n_documento),
	CONSTRAINT verifica_delegado CHECK (delegado = 0 
						OR (delegado = 1 AND tempo_percurso <= '01:00')),
	/* FOREIGN KEY */
	--enc_educacao varchar(6) REFERENCES T_ENC_ED(nprocesso)
	/*enc_educacao varchar(6),
	FOREIGN KEY (enc_educacao)
	REFERENCES T_ENC_ED(nprocesso)*/
	/* PERMITIR DELETE*/
	/*enc_educacao varchar(6) REFERENCES T_ENC_ED(nprocesso)
		ON DELETE CASCADE*/
	/* DEFINIR NULL*/
	/*enc_educacao varchar(6) REFERENCES T_ENC_ED(nprocesso)
		ON DELETE SET NULL*/
	/* PERMITIR DELETE e ALTERAR O NPROCESSO */
	enc_educacao varchar(6) REFERENCES T_ENC_ED(nprocesso)
		ON DELETE CASCADE
		ON UPDATE CASCADE
)



/* INSERIR UM ALUNO */
INSERT INTO T_Alunos(nome,tipo_documento,n_documento,NIF,sexo,
dta_nascimento,morada,codigo_postal,email_pessoal,tempo_percurso,
escalao_ase,enc_educacao, id_turma)
VALUES
('Laura almeira','cc','45679','387462908','f','2005-06-01',
'rua hhiuio 23','3542-133','laura@gmail.com','01:30','A','123456' ,3)

SELECT * FROM T_ALUNOS

SELECT * FROM T_ENC_ED

INSERT INTO T_ENC_ED
VALUES ('123','Maria')

DELETE FROM T_ALUNOS WHERE n_processo=25217
DELETE FROM T_ENC_ED WHERE nprocesso='123'

CREATE INDEX PESQUISA_NOME
ON T_ALUNOS(nome)

/*CRIAR TABELA TURMAS*/

CREATE TABLE T_TURMAS(
 id_turma INT IDENTITY PRIMARY KEY,
 ano TINYINT NOT NULL CHECK (ano IN (10,11,12)),
 letra CHAR(1) NOT NULL,
 ano_letivo CHAR(9) NOT NULL CHECK (ano_letivo LIKE '____/____'),
 n_alunos TINYINT DEFAULT 0,
 delegado INT REFERENCES T_ALUNOS(n_processo) --IDENTIFICA O DELEGADO DE TURMA
 
)

INSERT INTO T_TURMAS(ano,letra,ano_letivo)
VALUES 
	(10,'A','2025/2026'),
	(11,'B','2025/2026'),
	(12,'H','2025/2026')


/*Adicionar um FK a tabela T_Alunos*/
/*CRIAR CAMPO*/

ALTER TABLE T_Alunos
ADD id_turma INT

/*Definis como chave estrangeira FK*/

ALTER TABLE T_Alunos
ADD FOREIGN KEY (id_turma)
REFERENCES T_TURMAS(id_turma)

/*REgra para evitar repetir ano, letra e anoletivo*/

ALTER TABLE T_TURMAS
ADD CONSTRAINT Validar_turma
UNIQUE(ano, letra, ano_letivo)

/*Adicionar campo idade a tabela t_alunos*/
/*adicionar regra de validação no campo idade para que seja superior ou igual  a 14*/

ALTER TABLE T_Alunos
ADD idade TINYINT

---

ALTER TABLE T_Alunos
ADD CONSTRAINT Validar_idade
CHECK (idade >= 14)

/*Criar vista para listar os alunos do 12ºH*/

CREATE VIEW Lista_Alunos_12H
AS 
	SELECT T_Alunos.*
	FROM T_Alunos
	INNER JOIN T_TURMAS ON T_Alunos.id_turma = T_TURMAS.id_turma
	WHERE T_TURMAS.ano = 12 AND T_TURMAS.letra = 'H'

SELECT * FROM Lista_Alunos_12H

-- APAGAR VISTA

DROP VIEW Lista_Alunos_12H

/*Atribuir a turma com id=1 a todos os alunos sem turma*/

UPDATE T_Alunos
SET id_turma = 1
WHERE id_turma IS NULL

/*Procedimentos*/

CREATE PROCEDURE Lista_Alunos_Por_Turma
(
	@ano TINYINT,
	@letra CHAR(1)
)

AS 
BEGIN
	SELECT T_Alunos.*
	FROM T_Alunos
	INNER JOIN T_TURMAS
	ON T_Alunos.id_turma = T_TURMAS.id_turma
	WHERE ano = @ano AND letra =@letra
END

/*executar o procedimento*/

EXECUTE Lista_Alunos_Por_Turma @ano = 12, @letra = 'H'

/*procedimento para calcular a idade de todos os alunos com base na data atual*/

CREATE PROCEDURE atualizar_idade

AS 
BEGIN

	UPDATE T_Alunos
	SET idade= DATEDIFF(YEAR, dta_nascimento,GETDATE())

END

EXECUTE atualizar_idade

/*procedimento para calcular a idade de todos os alunos com base numa data qqr com paramentro*/

CREATE PROCEDURE atualizar_idade_v2
(
	@data DATE
)
AS 
BEGIN

	UPDATE T_Alunos
	SET idade= DATEDIFF(YEAR, dta_nascimento,@data)

END

EXECUTE atualizar_idade_v2 @data = '2025/11/01'

DECLARE @dataatual = ''
set @dataatual = getdate()
EXECUTE atualizar_idade_v2 @data=@dataatual

/*TRIGGER */

CREATE TRIGGER Calcula_Idade_Aluno
ON T_Alunos
AFTER INSERT
AS 
BEGIN
--decalração de variaveis
	DECLARE @datanasc as date;
	DECLARE @nprocesso as int;
	--Preencher as  variaveis com os valores dos registros inseridos
	SELECT @datanasc = INSERTED.dta_nascimento FROM inserted;
	SELECT @nprocesso = INSERTED.n_processo FROM  INSERTED;
	--atualizar o campo idade
	UPDATE T_Alunos
	SET idade = DATEDIFF(YEAR, @datanasc, GETDATE())
	WHERE T_Alunos.n_processo = @nprocesso;

END

-- CRIAR UM TRIGGER PARA ATUALIZAR O CAMPO NR_ALUNOS DA TABELA T_TURMAS

CREATE TRIGGER Atualizar_Turma
ON T_Alunos
AFTER INSERT 
AS 
BEGIN

	DECLARE @idturma AS INT;

	SELECT @idturma = INSERTED.id_turma FROM INSERTED

	UPDATE T_TURMAS
	SET n_alunos = n_alunos + 1
	WHERE T_TURMAS.id_turma = @idturma

END

CREATE TRIGGER Atualizar_Turma_UPDATE
ON T_Alunos
AFTER UPDATE
AS 
BEGIN

	DECLARE @idturma AS INT;

	SELECT @idturma = INSERTED.id_turma FROM INSERTED

	UPDATE T_TURMAS
	SET n_alunos = (SELECT COUNT(*) FROM T_Alunos WHERE T_Alunos.id_turma = @idturma)
	WHERE T_TURMAS.id_turma = @idturma

END

DROP TRIGGER Atualizar_Turma_UPDATE

/* INSERIR UM ALUNO */
INSERT INTO T_Alunos(nome,tipo_documento,n_documento,NIF,sexo,
dta_nascimento,morada,codigo_postal,email_pessoal,tempo_percurso,
escalao_ase,enc_educacao, id_turma)
VALUES
('Emily Ribeiro','Outro','98J689','300296215','f','2007-09-03',
'Rua Herois Lusitanos','3510-233','a22992@esenviseu.net','00:20','B','123456' ,3)