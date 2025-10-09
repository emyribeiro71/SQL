/*EMILY RIBEIRO ~ Nº9 ~ 12ºH*/

/*1_listar nome dos produtos sem repetir*/

SELECT Nome
FROM Produtos
GROUP BY Nome

/*2_referencia, nome e o valor do iva dos produtos*/

SELECT Referencia, Nome, Taxa_Iva
FROM Produtos
ORDER BY Nome

/*3_referencia,nome e o valor a pagar por produto*/

SELECT Referencia, Nome, Preco +(Preco* Taxa_Iva)
FROM Produtos

/*4_Média do preço dos produtos*/

SELECT AVG(Preco) AS MEDIA
FROM Produtos

/*5_Todos os produtos da categoria Limpeza*/

SELECT Nome
FROM Produtos
WHERE Tipo = 'Limpeza'

/*6_Todos os produtos fora de validade*/

SELECT Nome
FROM Produtos
WHERE Data_validade < GETDATE()
ORDER BY Nome

/*7_todos os produtos com validade do mês atual*/

SELECT Nome
FROM Produtos
WHERE MONTH(Data_validade) = MONTH(GetDATE())

/*8_Nr de produtos por categoria*/

SELECT Tipo, COUNT(*)
FROM Produtos
GROUP BY Tipo

/*9_os produtos da categoria bebidas e cujo preço é inferior a 5 €*/

SELECT Nome
FROM Produtos
WHERE Tipo = 'Bebidas' and Preco < 5

/*10_os produtos enlatados ou charcutaria*/

SELECT  Nome, tipo
FROM Produtos
WHERE Tipo = 'Charcutaria' or Tipo = 'Enlatados'

/*11_os produtos sem desconto*/

SELECT  Nome, Desconto
FROM Produtos
WHERE Desconto Is Null or Desconto = 0

/*12_produtos cujo preço é superior a 5 e inferior a 10*/

SELECT Nome
FROM Produtos
WHERE Preco > 5 AND Preco < 10

/*13_produtos cujo preço unitário é superior à média dos preços*/

SELECT Nome
FROM Produtos
WHERE Preco > (SELECT AVG(Preco)FROM Produtos)

/*14_número total de produtos em stock*/

SELECT SUM(Stock)
FROM Produtos

/*15_nome do produto com maior quantidade em stock*/

SELECT TOP 1 Nome, COUNT(Stock) as STOCK  
FROM Produtos
GROUP BY Nome 
ORDER BY COUNT(Stock) DESC

/*16_número de registos da tabela produtos*/

SELECT COUNT(*)
FROM Produtos

/*17_lista de produtos com o valor mais baixo em stock*/

SELECT Nome, Stock
FROM Produtos
ORDER BY Preco 

/*18_listar o nome do produto e do repositor*/

SELECT Nome, Repositor
FROM Produtos

/*19_listar todos os campos dos produtos cujo preco é superior à média dos preços dos produtos*/

SELECT *
FROM Produtos
WHERE Preco > (SELECT AVG(Preco) FROM Produtos)

/*20_Valor dos produtos em stock*/

SELECT Stock, Preco
FROM Produtos

/*21_Listar os respositores sem produtos*/

SELECT Repositor
FROM Produtos

/*22_Nr de lojas por localidade*/
--???????????????????????????????????????
SELECT COUNT(Loja)
FROM Repositores
GROUP BY Loja

/*23_Loja com mais funcionários*/

SELECT TOP 1 Loja, COUNT(*)
FROM Repositores
GROUP BY Loja
ORDER BY COUNT(*)

/*24_Média de idades dos funcionários por loja*/

Select AVG(CAST(DATEDIFF(YEAR, Data_Nascimento, GETDATE()) AS FLOAT)) AS MEDIA
From Repositores

/*25_atualizar a idade dos funcionários*/

UPDATE Repositores
SET Data_Nascimento = '05/10/2007'

/*26_atualizar o preço dos produtos cuja data de validade já foi ultrapassada retirando 10% ao preço unitário*/

UPDATE Produtos 
SET Preco = Preco - (Preco * 0.10)
WHERE Data_validade < GETDATE()

/*27_Mostrar o funcionario que trabalha mais horas*/

Select  TOP 1 Nome, MAX(Hora_Saida - Hora_Entrada) as horatotal
From Repositores
GROUP BY Nome

/*28_Mostrar o funcionario com o maior nome*/

SELECT TOP 1 Nome
FROM Repositores
GROUP BY Nome
ORDER BY MAX(LEN(Nome)) DESC

/*29_mostrar o preços dos produtos cujo nome da marca termina com b*/

SELECT Preco
FROM Produtos
WHERE RIGHT(Nome,1) = 'b'

/*30_eliminar produtos fora de prazo*/

DELETE Produtos
WHERE Data_validade < GETDATE()