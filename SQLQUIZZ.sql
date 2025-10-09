------- Quantos alunos fizeram o teste -----------

SELECT COUNT(*)
FROM alunos
inner join Resultados on alunos.n_processo = Resultados.N_Processo

-- or

SELECT COUNT(distinct N_Processo )
FROM Resultados

--------- Nome dos alunos que aidna não fizeram o teste --------

SELECT alunos.nome
FROM alunos
left join Resultados on alunos.n_processo = Resultados.N_Processo
WHERE Resultados.Pontos IS NULL

---------- Qual melhor turma de GPSI do 12º ano ---------------

SELECT AVG(Pontos) as [media dos resultados], alunos.turma, COUNT(alunos.n_processo)
FROM Resultados
inner join alunos on Resultados.N_Processo = alunos.n_processo
GROUP BY alunos.turma
ORDER BY alunos.turma

----  NOME DOS ALUNOS QUE TIVERAM MAIS DO QUE A MEDIA -----

SELECT alunos.nome, Resultados.Pontos
FROM alunos
INNER JOIN Resultados on alunos.n_processo = Resultados.N_Processo
WHERE Resultados.Pontos > (SELECT AVG(Pontos) 
							FROM Resultados	
							inner join alunos on Resultados.N_Processo = alunos.n_processo
							WHERE alunos.turma = '12H') and alunos.turma = '12H'
ORDER BY alunos.nome
--ORDER BY Resultados.Pontos desc, Id

----------- NOME DOS ALUNOS QUE FICARAM NOS 10% MELHORES

SELECT TOP 10 PERCENT alunos.nome, Resultados.Pontos
FROM alunos
INNER JOIN Resultados on alunos.n_processo = Resultados.N_Processo
--WHERE alunos.turma = '12H'
ORDER BY Resultados.Pontos desc, Id


--- 3 melhores alunos da turma

SELECT TOP 3 alunos.nome, Resultados.Pontos
FROM alunos
INNER JOIN Resultados on alunos.n_processo = Resultados.N_Processo
WHERE alunos.turma = '12H'
ORDER BY Resultados.Pontos desc, Id


--- meu nome, turma o resultado em creditos que vou ganhar,

SELECT CONCAT( SUBSTRING(alunos.nome, 1, CHARINDEX(' ', alunos.nome,1)),' - ', alunos.turma,' - ', (Resultados.Pontos / 2)+5 ,' Creditos')
FROM alunos
inner join Resultados on alunos.n_processo = Resultados.N_Processo
WHERE  alunos.nome LIKE '%Emily%' 


