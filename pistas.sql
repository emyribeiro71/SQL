CREATE TABLE Suspeitos (
    id INT PRIMARY KEY,
    nome NVARCHAR(50),
    turma CHAR(3),
    transporte NVARCHAR(50),
    hobby NVARCHAR(50)
);

CREATE TABLE Locais (
    id INT PRIMARY KEY,
    nome_local NVARCHAR(50)
);

CREATE TABLE Testemunhas (
    id INT PRIMARY KEY,
    nome NVARCHAR(50),
    descricao NVARCHAR(255)
);

CREATE TABLE ObjetosEncontrados (
    id INT PRIMARY KEY,
    objeto NVARCHAR(50),
    id_local INT FOREIGN KEY REFERENCES Locais(id)
);

CREATE TABLE Movimentos (
    id INT PRIMARY KEY,
    id_suspeito INT FOREIGN KEY REFERENCES Suspeitos(id),
    id_local INT FOREIGN KEY REFERENCES Locais(id),
    hora TIME
);

-- =====================================
-- INSERÇÃO DE DADOS
-- =====================================

INSERT INTO Suspeitos VALUES
(1, N'Cristiano ', N'12T', N'Carro', N'Música'),
(2, N'Fred 1', N'12T', N'Moto', N'Ciclismo'),
(3, N'Enzo', N'12T', N'Carro', N'Leitura'),
(4, N'Emily', N'12H', N'Bicicleta', N'Música'),
(5, N'David Marques', N'12H', N'Carro', N'Culinária'),
(6, N'Dinis Ribeiro', N'12H', N'Carro', N'Culinária'),
(7, N'Joaquim', N'12H', N'Bicicleta', N'Culinária');

INSERT INTO Locais VALUES
(1, N'Biblioteca'),
(2, N'Sala D5'),
(3, N'Cantina'),
(4, N'Refeitório'),
(5, N'Museu');

INSERT INTO Testemunhas VALUES
(1, N'João', N'Viu o suspeito sair do Museu às 15:00 de bicicleta.'),
(2, N'Maria', N'O culpado gosta de música.'),
(3, N'Ana', N'Não foi visto ninguém com carro no local do crime.');

INSERT INTO ObjetosEncontrados VALUES
(1, N'Luva preta', 5),
(2, N'Garrafa de água', 4),
(3, N'Chave do museu', 5);

INSERT INTO Movimentos VALUES
(1, 1, 1, '14:30'),
(2, 1, 5, '15:05'),
(3, 2, 2, '15:00'),
(4, 3, 3, '15:10'),
(5, 4, 5, '15:00'),
(6, 5, 1, '14:50'),
(7, 4, 4, '15:15'),
(8, 2, 5, '15:20'),
(9, 3, 3, '16:50');

-- Consultas iniciais
-- 1. Lista todos os suspeitos (nome, turma e hobby).

SELECT nome, turma, hobby
FROM Suspeitos

-- 2. Mostra todos os locais da escola.

SELECT nome_local
FROM Locais

-- Consultas com filtros
-- 3. Quem esteve no Museu entre as 14:50 e as 15:10?

SELECT DISTINCT Suspeitos.nome
FROM Suspeitos
INNER JOIN Movimentos
ON Suspeitos.id = Movimentos.id_suspeito
INNER JOIN Locais
ON Movimentos.id_local = Locais.id
WHERE Locais.nome_local = 'Museu' AND Movimentos.hora >= '14:50' OR Movimentos.hora <= '15:10' --Movimentos.hora BETWEEN '14:50' AND '15:10'

-- 4. Que suspeitos andam de bicicleta?

SELECT nome
FROM Suspeitos
WHERE transporte = 'Bicicleta'

-- 5. Que suspeitos não usam carro?

SELECT nome
FROM Suspeitos
WHERE transporte != 'Carro'

-- 6. Que suspeitos têm “música” como hobby?

SELECT nome
FROM Suspeitos
WHERE hobby = 'Música'

-- Consultas com várias tabelas
-- 7. Mostra todos os objetos encontrados no Museu (nome do objeto e local).

SELECT ObjetosEncontrados.objeto
FROM ObjetosEncontrados
INNER JOIN Locais
ON ObjetosEncontrados.id_local = Locais.id
WHERE Locais.nome_local = 'Museu'

-- 8. Lista os movimentos (nome do suspeito, local e hora) de todos os que estiveram no Refeitório.

SELECT Suspeitos.nome, Locais.nome_local, Movimentos.hora
FROM Movimentos
INNER JOIN Locais
ON Movimentos.id_local = Locais.id
INNER JOIN Suspeitos
ON Movimentos.id_suspeito = Suspeitos.id
WHERE Locais.nome_local = 'Refeitório'

-- 9. Quais os nomes das testemunhas que mencionaram bicicleta e os suspeitos que andam de bicicleta?

SELECT Testemunhas.nome, 'Testemunha'
FROM Testemunhas
WHERE descricao LIKE '%bicicleta%'
UNION
SELECT nome, 'Suspeito'
FROM Suspeitos
WHERE transporte = 'Bicicleta'

-- Consultas com dados calculados
-- 10. Conta quantos movimentos cada suspeito fez.

SELECT COUNT(*) AS [MOVIMENTO POR SUSPEITO]
FROM Movimentos
GROUP BY id_suspeito

-- 11. Mostra apenas os suspeitos que fizeram mais de 1 movimento.

SELECT Suspeitos.nome
FROM Movimentos
INNER JOIN Suspeitos
ON Movimentos.id_suspeito = Suspeitos.id
GROUP BY Suspeitos.nome
HAVING COUNT(*) > 1

-- 12. Ordena os suspeitos pelo número de locais diferentes visitados.

SELECT Suspeitos.nome, COUNT(*)
FROM Movimentos
INNER JOIN Suspeitos
ON Movimentos.id_suspeito = Suspeitos.id
GROUP BY Suspeitos.nome
ORDER BY COUNT(*) DESC

--Consulta Final
--13. Usando todas as pistas:
-- - Esteve no Museu por volta das 15:00
-- - Saiu de bicicleta
-- - Gosta de música
-- - Não usava carro

SELECT Suspeitos.nome
FROM Suspeitos
INNER JOIN Movimentos
ON Suspeitos.id = Movimentos.id_suspeito
INNER JOIN Locais
ON Movimentos.id_local = Locais.id
WHERE Locais.nome_local = 'Museu' AND Movimentos.hora = '15:00' AND Suspeitos.transporte = 'Bicicleta' AND Suspeitos.hobby = 'Música'


