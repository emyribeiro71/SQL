/*EMILY RIBEIRO ~ Nº09 ~ 12ºH*/

------- listar os leitores ordenados pelo nome de a para z -------

SELECT nome
FROM Leitores
ORDER BY nome

------- listar a média dos preços dos livros -----------

SELECT AVG(preco) AS MEDIA 
FROM Livros

------- listar o nome do leitor mais velho -------------

SELECT TOP 1 nome
FROM Leitores
ORDER BY data_nasc

------------- listar o nr de leitores ------------------

SELECT COUNT(nleitor)
FROM Leitores

---- listar o nr de leitores cujo campo ativo é 1 ------

SELECT COUNT(nleitor)
FROM Leitores
WHERE ativo = 1 

--------- listar o nr de leitores por género -----------

SELECT genero, COUNT(nleitor) as Quantidade
FROM Leitores
GROUP BY genero

----- listar o nome de todos os leitores e a respetiva idade -------

SELECT nome, DATEDIFF(YY, data_nasc, GETDATE()) AS IDADE
FROM Leitores

----listar o nome dos leitores cuja idade é inferior a 20 anos ----

SELECT nome
FROM Leitores
WHERE DATEDIFF(YY, data_nasc, GETDATE()) < 20

------- listar o nome dos leitores que nasceram No mês atual ------

SELECT nome
FROM Leitores
WHERE MONTH(data_nasc) = MONTH(GETDATE())

-- listar os livros cuja data de aquisição é anterior ao ano de publicação ---

SELECT nome
FROM Livros
WHERE ano > YEAR(data_aquisicao)

-- listar o nome dos livros ordenados por forma a mostrar primeiro os mais baratos ----

SELECT nome, preco
FROM Livros
ORDER BY preco

----------- listar os livros cujo estado é 0 -----------------------
SELECT nome
FROM Livros
WHERE estado = 0

--- listar os livros cujo preço é superior ou igual a 2€ e inferior a 20€ ------

SELECT nome
FROM Livros
WHERE preco >= 2 AND preco < 20

----- listar a duração em dias dos empréstimos -----------

SELECT DATEDIFF(DAY, data_emprestimo,data_devolve) AS DIAS
FROM Emprestimos

------ listar o nome do livro com mais empréstimos ---------

SELECT TOP 1 Livros.nome, COUNT(Emprestimos.nemprestimo) as NEmprestimos
FROM Emprestimos
inner join Livros
ON Livros.nlivro = Emprestimos.nlivro
GROUP BY Livros.nome
ORDER BY NEmprestimos DESC

------ listar a média de empréstimos por leitor ---------

SELECT AVG(SLA.CONTAR)
FROM (SELECT COUNT(*) AS CONTAR FROM Emprestimos GROUP BY nleitor) AS SLA

---- listar o nome do leitor e o nome do livro do empréstimo -------

SELECT Leitores.nome, Livros.nome
FROM Leitores
inner join Emprestimos
on Leitores.nleitor = Emprestimos.nleitor
inner join Livros
on Emprestimos.nlivro = Livros.nlivro

----- listar o número de empréstimo que cada leitor já realizou, devem aparecer todos os leitores ----

SELECT Leitores.nome, COUNT(Emprestimos.nemprestimo) as emprestimos 
FROM Leitores
inner join Emprestimos
on Leitores.nleitor = Emprestimos.nleitor
GROUP BY Leitores.nome

------ atualize o preço dos livros adicionando €0,50 ao preço atual ------

UPDATE Livros
SET preco = preco + 0.50

-------- remova todos os leitores cujo campo estado é 0 -----------

DELETE FROM Leitores
WHERE ativo = 0