SELECT 1+1 as [Resultado]

/* COMENTARIO */

SElECT Nome, Loja
FROM Repositores

SElECT *
FROM Repositores

SElECT Servico_saude as [Serviço de Saúde]
FROM Repositores


SElECT Referencia, Nome, Preco, Preco*Taxa_Iva as [Valor Iva], Preco +(Preco* Taxa_Iva) as [PVP]
FROM Produtos

SELECT DISTINCT tipo
FROM Produtos


SELECT DISTINCT Fornecedor
FROM Produtos
WHERE (Origem = 'Portugal')

SELECT DISTINCT Fornecedor, Origem
FROM Produtos
WHERE (Origem <> 'Portugal')

SELECT Nome, Preco 
FROM Produtos
WHERE (Tipo = 'Bebidas' and Preco < 5)


/*o nome de tds os produtos q sejam d portugal e espanha */

SELECT DISTINCT Nome
FROM Produtos
WHERE (Origem= 'Portugal' or Origem= 'Espanha')

/*PRODUTOS DA UNIAO EUROPEIA*/
SELECT  Nome, Origem
FROM Produtos
WHERE Origem In ('Portugal' , 'Espanha' , 'França' , 'Belgica')

/*produtos enlatados ou charcutaria*/
SELECT  Nome, tipo
FROM Produtos
WHERE Tipo = 'Charcutaria' or Tipo = 'Enlatados'



/*produtos sem desconto*/
SELECT  Nome, Desconto
FROM Produtos
WHERE Desconto Is Null or Desconto = 0

