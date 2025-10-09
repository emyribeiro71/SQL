/*Operadores relacionais (de comparação) */

/*Mostrar o nome e o defeito dos produtos que est~~ao estragados*/

SELECT Nome, Defeitos
FROM produtos
WHERE Defeitos is not NULL

/*fazer uma consulta usando o operador LIKE*/

SELECT Nome, email
FROM Repositores
WHERE email LIKE '%gmail.com'

/*fazer uma consulta usando o operador LIKE*/

SELECT Nome
FROM Produtos
WHERE RTRIM(Nome) LIKE 'A___'


SELECT Nome, CC
FROM Repositores
WHERE CC LIKE '1[92]%'

SELECT Nome, Loja
FROM Repositores
WHERE Loja LIKE 'Viseu%'

SELECT Nome
FROM Repositores
WHERE RTRIM(Nome) LIKE '%Carvalho'

/*repositores de viseu
qm é tem o sobrenome carvalho 
*/

/*Ordenar ORDER BY*/
/*nome dos produtos do mais caro ao mais barato*/

SELECT Nome, Preco
From Produtos
ORDER BY Preco DESC

/*APenas as bebidas*/

SELECT Nome, Tipo, Fornecedor
From Produtos
WHERE Tipo = 'Bebidas'
ORDER BY Preco DESC

/*idade*/
SELECT Nome, Data_Nascimento
From Repositores
ORDER BY Data_Nascimento desc

/*mostre a data de nascimento a idade de cada um*/

SELECT Nome, Data_Nascimento, (DATEDIFF(YEAR, Data_Nascimento,GETDATE())) as Idade
From Repositores
ORDER BY Data_Nascimento desc

/*nome dos funcionarios ordem«nam«dos pela antiguidade o que esta atrabalhar a amais tempo e vai ter premio , 100€ por ano de trabalho mais um vencimento extra*/

SELECT Nome, Data_Entrada, (DATEDIFF(YEAR, Data_Entrada,GETDATE())) as Anos_Trabalhados
From Repositores
ORDER BY Data_Entrada

SELECT AVG(Preco)
FROM produtos

SELECT count(*)
FROM Produtos

SELECT count(desconto)
FROM Produtos


/*Nome dos produtos mai sbaratos*/

SELECT min(Preco), Nome
FROM Produtos

SELECT *
FROM Produtos
WHERE Preco = (SELECT min(Preco)FROM Produtos)

/*Listar os produtos, cujo o preço é superior a media*/

SELECT *
FROM Produtos
WHERE Preco > (SELECT AVG(Preco)FROM Produtos)


/*--------------------------------------------*/

SELECT (SELECT COUNT(*) FROM Produtos) as [NR Produtos], (SELECT COUNT(*) FROM Repositores) as [NR Repositores]


SELECT COUNT(Fornecedor), Fornecedor FROM Produtos
/*WHERE Fornecedor= 'Mimosa'*/
GROUP BY Fornecedor
ORDER BY COUNT(Fornecedor) DESC


/*Vencimentos a pagar total*/
SELECT SUM(Vencimento) as Total FROM Repositores



/*mostrar o dinheiro que pago aos funcionarios, qual é a 
total a pagar aos funcionarios, media dos ordenados de cada loja*/

SELECT AVG(Vencimento) as Media, Loja FROM Repositores
GROUP BY Loja

/*21_Listar os respositores sem produtos*/

SELECT COUNT(*) - COUNT(Repositor) FROM Produtos

/*21a_PRODUTOS QUE NUNCA FORAM VENDIDOS*/

/*14_número total de produtos em stock*/

SELECT Nome, COUNT(Stock) as STOCK  FROM Produtos
GROUP BY Nome 
ORDER BY COUNT(Stock) DESC

/*_____________________________________________________*/
SELECT Nome, Vencimento
FROM Repositores
WHERE Vencimento = (SELECT min(Vencimento) FROM Repositores)

/*_____________________________________________________*/

SELECT SUM(Preco* Stock)
FROM Produtos
/*_____________________________________________________*/

/*23_Loja com mais funcionários*/
SELECT TOP 1 Loja, COUNT(*) AS FUNCIONARIOS
FROM Repositores
GROUP BY Loja
ORDER BY FUNCIONARIOS DESC

/*24_Média de idades dos funcionários por loja*/
SELECT Loja, AVG((DATEDIFF(YEAR, Data_Nascimento,GETDATE()))) as Media_Idade
From Repositores
GROUP BY Loja

/*14_número total de produtos em stock*/
SELECT SUM(Stock)
FROM Produtos

/*
SELECT AVG(NOTA), NProc
FROM Notas
WHERE NProc != 103
GROUP BY NProc
ORDER BY AVG(Nota) DESC */

/*
SELECT AVG(NOTA), NProc
FROM Notas
GROUP BY NProc
HAVING AVG(Nota)>15*/


/*Calcular a media do preço por tipo*/
SELECT AVG(Preco), Tipo
FROM Produtos
GROUP BY Tipo

/*Calcular a media do preço por fornecedor so as bebidas*/

SELECT AVG(Preco), Fornecedor
FROM Produtos
GROUP BY Fornecedor

/*Lista as compras dos produtos*/

SELECT * 
FROM compras, Produtos
WHERE compras.Referencia_Produto = Produtos.Referencia
--------------------------------------------
--Inner join
SELECT * 
FROM compras inner join Produtos
on compras.Referencia_Produto = Produtos.Referencia

--left join

SELECT * 
FROM compras left join Produtos
on compras.Referencia_Produto = Produtos.Referencia

--right join

SELECT * 
FROM compras right join Produtos
on compras.Referencia_Produto = Produtos.Referencia

-- Listar as compras do produto, o nome do produto e o nome do repositor

SELECT Compras.* , Produtos.Nome, Repositores.Nome
FROM compras, Produtos, Repositores
WHERE compras.Referencia_Produto = Produtos.Referencia and Produtos.Repositor = Repositores.NIF
----------------------------------
SELECT Compras.* , Produtos.Nome, Repositores.Nome
FROM compras 
inner join Produtos
on compras.Referencia_Produto = Produtos.Referencia 
inner join Repositores
on Produtos.Repositor = Repositores.NIF

--Produtos que nunca foram comprados

SELECT * 
FROM compras right join Produtos
on compras.Referencia_Produto = Produtos.Referencia
WHERE ID_Compra is null

-- repositor que não tem nenhum produto atribuido

SELECT * 
FROM Repositores left join Produtos
on Repositores.NIF = Produtos.Repositor
WHERE Produtos.Referencia is null

--LIsta de repositores lem profutos
SELECT *
FROM Repositores left join Produtos
on Repositores.NIF = Produtos.Repositor
WHERE Produtos.Referencia is null
