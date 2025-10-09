/*FUNÇÕES PARA TEXTO*/

SELECT LEN('batatas')
SELECT LEN(' batatas')
SELECT LEN('batatas ') --nao conta os espaços a direita

/*  SUBSTRING  */
SELECT SUBSTRING('batatas',1,4)

-- LEFT e RIGHT

SELECT LEFT('batatas',4)
SELECT RIGHT('batatas',4)

-- CHARINDEX

SELECT CHARINDEX('-','3500-123')

-----------------------------

SELECT email,SUBSTRING(email,1,CHARINDEX('@',email)-1) AS NOME, RIGHT(email, LEN(email)-CHARINDEX('@',email)) as Dominio
FROM Repositores

--OU

SELECT email,SUBSTRING(email,1,CHARINDEX('@',email)-1) AS NOME, SUBSTRING(email, CHARINDEX('@',email)+1, LEN(email)) as Dominio
FROM Repositores


--Listar o nome dos produtos com a primeira letra em maiusculas e as restantes em minusculas

SELECT UPPER(LEFT(Nome,1))+LOWER(SUBSTRING(Nome,2,LEN(Nome)))
FROM Produtos

--Media dos preços dos produtos com 2 casas decimais 

SELECT ROUND(AVG(Preco),2 )
FROM Produtos



SELECT FLOOR(4.5)

SELECT CEILING(4.5)


--IIF------------

SELECT IIF(5=5, 'cinco', 'não é cinco')
SELECT IIF(5=7, 'cinco', 'não é cinco')

--INCERIRI UM REPOSITOR NA TABELA REPOSITORES
INSERT INTO Repositores(NIF, Nome)
Values
('300296215', 'Emily'),
('321','marrie')