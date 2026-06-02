
/* Grupo da Disciplina de Tópicos de Banco de Dados
	Nome 										 RA
	Juan Pablo Garcia							769203
	João Victor Chiorato Biagioni 				769135
	João Gabriel Morais Costa 					769208
	Marcelo Henrique Canciano Fratini			760513
*/

/* INSERINDO VALORES TABELA FORNECEDOR 
Comando para deletar todos os registros da tabela
DELETE FROM public.fornecedor;
*/

INSERT INTO public.fornecedor VALUES
('90821876000191','Fornecedor 1','Fornecedor 1 Ltda','13165001','Eletrônicos'),
('16158725000199','Fornecedor 2','Fornecedor 2 Ltda','13165002','Beleza e Cuidados Pessoais'),
('53791832000130','Fornecedor 3','Fornecedor 3 Ltda','13165003','Livros'),
('64703150000144','Fornecedor 4','Fornecedor 4 Ltda','13165204','Brinquedos'),
('39435057000159','Fornecedor 5','Fornecedor 5 Ltda','13165005','Alimentos e Bebidas');

/* INSERINDO VALORES TABELA TRANSPORTADORA 
Comando para deletar todos os registros da tabela
DELETE FROM public.transportadora;
*/
INSERT INTO public.transportadora VALUES
('97721467000162','Transportadora 1','Transportadora 1 Ltda','13165000','0','Não Tem','10981'),
('31412001000177','Transportadora 2','Transportadora 2 Ltda','13165200','0','Não Tem','10981'),
('20132504000172','Transportadora 3','Transportadora 3 Ltda','13165002','0','Não Tem','10981'),
('79356942000167','Transportadora 4','Transportadora 4 Ltda','13165201','0','Não Tem','10981'),
('31557518000154','Transportadora 5','Transportadora 5 Ltda','13165003','0','Não Tem','10981');

/* INSERINDO VALORES TABELA CLIENTE
Comando para deletar todos os registros da tabela
DELETE FROM public.cliente;
*/
INSERT INTO public.cliente VALUES
('54657111086','Cliente 1','Cliente 1 Sobrenome','13165000','0','Não Tem','11/09/81'),
('69105106079','Cliente 2','Cliente 2 Sobrenome','13165200','0','Não Tem','12/09/81'),
('30617197091','Cliente 3','Cliente 3 Sobrenome','13165002','0','Não Tem','13/09/81'),
('40659269040','Cliente 4','Cliente 4 Sobrenome','13165201','0','Não Tem','14/09/81'),
('45336044040','Cliente 5','Cliente 5 Sobrenome','13165003','0','Não Tem','15/09/81');

/* INSERINDO VALORES TABELA DEVOLUÇÃO
Comando para deletar todos os registros da tabela
DELETE FROM public.devolucao;
*/
INSERT INTO public.devolucao (cpfcliente) VALUES
('54657111086'),
('54657111086'),
('54657111086'),
('40659269040'),
('40659269040');


/* INSERINDO VALORES TABELA RECOMENDAÇÃO 
Comando para deletar todos os registros da tabela
DELETE FROM public.recomendacao;
*/
INSERT INTO public.recomendacao VALUES
('Eletrônicos','54657111086'),
('Livros','69105106079'),
('Beleza e Cuidados Pessoais','30617197091'),
('Brinquedos','40659269040'),
('Alimentos e Bebidas','45336044040');

/* INSERINDO VALORES TABELA PRODUTO 
Comando para deletar todos os registros da tabela
DELETE FROM public.produto;
*/
INSERT INTO public.produto (nome, tipo, marca, preco,descricaoProduto, cnpjFornecedor) VALUES
('Notebook','Eletrônicos','Acer','3320,09',
'Notebook Novo em boas condições','90821876000191'),
('Torto Arado','Livros','Todavia','35,60',
'Texto épico e mágico que revela, um poderoso elemento de insubordinação social',
'53791832000130'),
('Revitalift Blur Mágico','Beleza e Cuidados Pessoais','LOréal Paris','38,90',
'Suaviza rugas e linhas, disfarça os poros e o brilho','16158725000199'),
('Hot Wheels Lava Rápido','Brinquedos','Mattel','205,90',
'Hot Wheels Novo em boas condições','64703150000144'),
('Cerveja 600ml','Alimentos e Bebidas','Heineken','9,90',
'Cerveja lager puro malte, refrescante e de cor amarelo-dourado','39435057000159');

/* INSERINDO VALORES TABELA ENTREGA
Comando para deletar todos os registros da tabela
DELETE FROM public.entrega;
*/
INSERT INTO public.entrega(cnpjTransportadora, tempoEstimado) VALUES
('97721467000162','18/02/20'),
('31412001000177','18/02/20'),
('20132504000172','18/02/20'),
('79356942000167','18/02/20'),
('31557518000154','18/02/20');

/* INSERINDO VALORES TABELA CARRINHODECOMPRAS
Comando para deletar todos os registros da tabela
DELETE FROM public.carrinhodecompras;
*/
INSERT INTO public.carrinhodecompras(codProduto, cpfCliente, quantidadeProduto) VALUES
('1','54657111086','2'),
('2','69105106079','1'),
('3','30617197091','3'),
('4','40659269040','2'),
('5','45336044040','5');

/* INSERINDO VALORES TABELA PEDIDO
Comando para deletar todos os registros da tabela
DELETE FROM public.pedido;
*/

INSERT INTO public.pedido(codCarrinho, codProduto, cpfCliente, cnpjTransportadora) VALUES
('1','1','54657111086','97721467000162'),
('2','2','69105106079','31412001000177'),
('3','3','30617197091','20132504000172'),
('4','4','40659269040','79356942000167'),
('5','5','45336044040','31557518000154');

/* INSERINDO VALORES TABELA NOTAFISCAL
Comando para deletar todos os registros da tabela
DELETE FROM public.notafiscal;
*/

INSERT INTO public.notafiscal(ordemPedido, codCarrinho, codProduto, cpfCliente, cnpjTransportadora, dataPedido) VALUES
('1','1','1','54657111086','97721467000162', '18/02/20'),
('2','2','2','69105106079','31412001000177', '18/02/20'),
('3','3','3','30617197091','20132504000172', '18/02/20'),
('4','4','4','40659269040','79356942000167', '18/02/20'),
('5','5','5','45336044040','31557518000154', '18/02/20');