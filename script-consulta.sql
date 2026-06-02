/* Grupo da Disciplina de Tópicos de Banco de Dados
	Nome 										RA
	Juan Pablo Garcia							769203
	João Victor Chiorato Biagioni 				769135
	João Gabriel Morais Costa 					769208
	Marcelo Henrique Canciano Fratini			760513
*/

/* SELECIONA OS CLIENTES QUE REALIZARAM UMA DEVOLUÇÃO E INDICA QUANTAS DEVOLUÇÕES
CADA CLIENTE REALIZOU */
SELECT COUNT(*),cpfCliente FROM public.devolucao GROUP BY cpfCliente;

/*INDICA O FORNECEDOR E A TRANSPORTADORA QUE ENTREGARAM 
O PRODUTO PARA O CLIENTE E A QUANTIDADE DE DINHEIRO GASTA PELO CLIENTE*/
SELECT SUM(ca.quantidadeProduto*p.preco) as total,c.prenome,p.nome,m.nomefantasia, t.nomefantasia 
FROM public.produto as p, public.fornecedor as m,public.cliente as c, 
public.transportadora as t, public.pedido as pe,public.carrinhodecompras as ca
WHERE m.cnpj = p.cnpjFornecedor 
AND pe.codProduto = p.cod 
AND t.cnpj = pe.cnpjTransportadora
AND c.cpf = ca.cpfCliente 
AND ca.codProduto = p.cod
GROUP BY c.prenome, p.nome,m.nomefantasia,t.nomefantasia;

/* SELECIONA OS CLIENTES QUE REALIZARAM UMA COMPRA E INDICA O TOTAL GASTO, O PRODUTO COMPRADO E A QUANTIDADE*/
SELECT c.prenome as nomecliente,p.nome as nomeproduto,p.preco,ca.quantidadeProduto,SUM((ca.quantidadeProduto*preco)) as total
FROM public.cliente as c, public.carrinhodecompras as ca, public.produto as p 
WHERE c.cpf = ca.cpfCliente AND ca.codProduto = p.cod 
GROUP BY c.prenome,ca.codProduto,p.nome,p.preco,ca.quantidadeProduto
ORDER BY total DESC;

/*MOSTRA OS DADOS DOS CLIENTES QUE COMPRARAM MAIS DO QUE 2 PRODUTOS IGUAIS */
SELECT c.prenome as nomecliente,p.nome as nomeproduto,p.preco,ca.quantidadeProduto,
SUM((ca.quantidadeProduto*p.preco)) as total
FROM public.cliente as c, public.carrinhodecompras as ca, public.produto as p 
WHERE c.cpf = ca.cpfCliente AND ca.codProduto = p.cod 
GROUP BY c.prenome,ca.codProduto,p.nome,p.preco,ca.quantidadeProduto
HAVING quantidadeProduto > '2'
ORDER BY total DESC;

/* MOSTRA OS CLIENTES QUE GASTARAM MAIS QUE 100 REAIS */
SELECT c.prenome as nomecliente,p.nome as nomeproduto,p.preco,ca.quantidadeProduto,
SUM((ca.quantidadeProduto*preco)) as total
FROM public.cliente as c, public.carrinhodecompras as ca, public.produto as p 
WHERE c.cpf = ca.cpfCliente AND ca.codProduto = p.cod 
GROUP BY c.prenome,ca.codProduto,p.nome,p.preco,ca.quantidadeProduto
HAVING SUM((ca.quantidadeProduto*preco)) > '100'
ORDER BY total DESC;

/* Indica a quantidade total de produtos comprados */
SELECT SUM(quantidadeproduto) FROM (SELECT c.prenome as nomecliente,ca.quantidadeProduto
FROM public.cliente as c, public.carrinhodecompras as ca 
WHERE c.cpf = ca.cpfCliente
GROUP BY c.prenome,ca.quantidadeProduto) as tabela1;

/*Indica a quantidade total de dinheiro gasto*/
SELECT SUM(total) FROM (SELECT c.prenome as nomecliente,p.nome as nomeproduto,p.preco,ca.quantidadeProduto,SUM((ca.quantidadeProduto*preco)) as total
FROM public.cliente as c, public.carrinhodecompras as ca, public.produto as p 
WHERE c.cpf = ca.cpfCliente AND ca.codProduto = p.cod 
GROUP BY c.prenome,ca.codProduto,p.nome,p.preco,ca.quantidadeProduto
ORDER BY total DESC) as tabela2;

/* Indica a média do valor por produto gasto no site */
SELECT (
	SELECT SUM(total) FROM 
		(SELECT c.prenome as nomecliente,p.nome as nomeproduto,p.preco,ca.quantidadeProduto,SUM((ca.quantidadeProduto*preco)) as total
		FROM public.cliente as c, public.carrinhodecompras as ca, public.produto as p 
		WHERE c.cpf = ca.cpfCliente AND ca.codProduto = p.cod 
		GROUP BY c.prenome,ca.codProduto,p.nome,p.preco,ca.quantidadeProduto
		ORDER BY total DESC) as tabela2)/
	(SELECT SUM(quantidadeproduto) FROM 
	 (SELECT c.prenome as nomecliente,ca.quantidadeProduto
		FROM public.cliente as c, public.carrinhodecompras as ca 
		WHERE c.cpf = ca.cpfCliente
		GROUP BY c.prenome,ca.quantidadeProduto) as tabela1
);

/*Escolhe o Cliente que termina com 1, concatena nome e sobrenome, 
concatena as informações de endereço e diz a idade do cliente*/
SELECT CONCAT(prenome,' ',sobrenome),cpf,CONCAT(cep,' ',numero,' ',complemento),
AGE(datanascimento) 
FROM public.cliente 
WHERE prenome LIKE '%1';





