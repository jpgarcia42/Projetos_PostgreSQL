/* Grupo da Disciplina de Tópicos de Banco de Dados
	Nome 										RA
	Juan Pablo Garcia					769203
	João Victor Chiorato Biagioni 				769135
	João Gabriel Morais Costa 			        769208
	Marcelo Henrique Canciano Fratini			760513
*/

-- Códigos para deletar todas as tabelas:
/*
DROP TABLE public.fornecedor CASCADE;
DROP TABLE public.transportadora CASCADE;
DROP TABLE public.cliente CASCADE;
DROP TABLE public.devolucao CASCADE;
DROP TABLE public.recomendacao CASCADE;
DROP TABLE public.produto CASCADE;
DROP TABLE public.entrega CASCADE;
DROP TABLE public.carrinhodecompras CASCADE;
DROP TABLE public.pedido CASCADE;
DROP TABLE public.notafiscal CASCADE;
*/

-- Criando a tabela do fornecedor.
CREATE TABLE IF NOT EXISTS public.fornecedor
(
-- Atributos tabela fornecedor.
    cnpj BIGINT,
    nomefantasia VARCHAR(50) NOT NULL,
    razaosocial VARCHAR(50) NOT NULL,
    cep integer,
    tipoprodutofornecido VARCHAR(50),
    CONSTRAINT fornecedor_pkey PRIMARY KEY (cnpj)
);

-- Criando a tabela do transportadora.
CREATE TABLE IF NOT EXISTS public.transportadora
(
    cnpj BIGINT,
    nomefantasia VARCHAR(50) NOT NULL,
    razaosocial VARCHAR(50) NOT NULL,
    cep integer,
	numero integer,
	complemento VARCHAR(50),
	notaTransporte VARCHAR(50),
    CONSTRAINT transportadora_pkey PRIMARY KEY (cnpj)
);

-- Criando a tabela do cliente.
CREATE TABLE IF NOT EXISTS public.cliente
(
    cpf BIGINT,
    prenome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL,
    cep integer,
	numero integer,
	complemento VARCHAR(50),
	dataNascimento DATE,
	CONSTRAINT cliente_pkey PRIMARY KEY (cpf)
);

-- Criando a tabela da devolução.
CREATE TABLE IF NOT EXISTS public.devolucao
(
    codDev BIGINT GENERATED ALWAYS AS IDENTITY,
	cpfCliente BIGINT NOT NULL,
-- É colocado o cpf do cliente como chave estrangeira da devolução.
    CONSTRAINT dev_fkey FOREIGN KEY (cpfCliente) REFERENCES cliente(cpf),
	CONSTRAINT dev_pkey PRIMARY KEY (codDev,cpfCliente)
);

-- Criando tabela da recomendação.
CREATE TABLE IF NOT EXISTS public.recomendacao
(
    tipoProdutoComprado VARCHAR(50),
	cpfCliente BIGINT NOT NULL,
-- É colocado o cpf do cliente como chave estrangeira da recomendação.
    CONSTRAINT rec_fkey FOREIGN KEY (cpfCliente) REFERENCES cliente(cpf),
	CONSTRAINT rec_pkey PRIMARY KEY (tipoProdutoComprado, cpfCliente)
);

-- Criando tabela do produto.
CREATE TABLE IF NOT EXISTS public.produto
(
-- Atributos da tabela produto.
    cod BIGINT GENERATED ALWAYS AS IDENTITY,
	nome VARCHAR(250) NOT NULL,
	tipo VARCHAR(250) NOT NULL,
	marca VARCHAR(250) NOT NULL,
	preco MONEY NOT NULL,
	descricaoProduto VARCHAR(550) NOT NULL,
	cnpjFornecedor BIGINT NOT NULL,
-- Recebe o atributo do CNPJ do fornecedor denotando sua cardinalidade.
    CONSTRAINT prod_fkey1 FOREIGN KEY (cnpjFornecedor) REFERENCES fornecedor(cnpj),
	CONSTRAINT prod_pkey PRIMARY KEY (cod)
);

-- Criando tabela da entrega.
CREATE TABLE IF NOT EXISTS public.entrega
(
-- Atributos da tabela entrega.
    numeroRastreio BIGINT GENERATED ALWAYS AS IDENTITY,
	cnpjTransportadora BIGINT NOT NULL,
	tempoEstimado DATE NOT NULL,
-- Recebe o atributo cnpj da transportadora como chave estrangeira.
    CONSTRAINT ent_fkey FOREIGN KEY (cnpjTransportadora) REFERENCES transportadora(cnpj),
	CONSTRAINT ent_pkey PRIMARY KEY (numeroRastreio, cnpjTransportadora)
);

-- Criando tabela carrinho de compras.
CREATE TABLE IF NOT EXISTS public.carrinhodecompras
(
-- Atributos da tabela do carrinho de compras.
    cod BIGINT GENERATED ALWAYS AS IDENTITY,
	codProduto integer NOT NULL,
	cpfCliente BIGINT NOT NULL,
	quantidadeProduto integer NOT NULL,
-- Recebe o cpf do cliente como chave estrangeira.
    CONSTRAINT carCpfCliente_fkey FOREIGN KEY (cpfCliente) REFERENCES cliente(cpf),
-- Recebe o código do produto como chave estrangeira.
	CONSTRAINT carCodProduto_fkey FOREIGN KEY (codProduto) REFERENCES produto(cod),
	CONSTRAINT car_pkey PRIMARY KEY (cod, cpfCliente, codProduto)
);

-- Criando tabela do pedido.
CREATE TABLE IF NOT EXISTS public.pedido
(
-- Atributos da tabela do pedido.
    ordemPedido integer GENERATED ALWAYS AS IDENTITY,
	codCarrinho integer NOT NULL,
	codProduto integer NOT NULL,
	cpfCliente BIGINT NOT NULL,
	cnpjTransportadora BIGINT NOT NULL,
-- Atributos do carrinho de compras como chave estrangeira.
	CONSTRAINT ped_fkey3 FOREIGN KEY (codCarrinho, cpfCliente, codProduto) REFERENCES carrinhodecompras(cod, cpfCliente, codProduto),
-- Atributo da transportaora indicando a cardinalidade.	
	CONSTRAINT ped_fkey4 FOREIGN KEY (cnpjTransportadora) REFERENCES transportadora(cnpj),
	CONSTRAINT ped_pkey PRIMARY KEY (ordemPedido, codCarrinho, cpfCliente, codProduto)
);

-- Criando tabela do nota fiscal.
CREATE TABLE IF NOT EXISTS public.notafiscal
(
-- Atributos nota fiscal.
	codAlfanumerico BIGINT GENERATED ALWAYS AS IDENTITY,
    ordemPedido integer NOT NULL,
	codCarrinho integer NOT NULL,
	codProduto integer NOT NULL,
	cpfCliente BIGINT NOT NULL,
	cnpjTransportadora BIGINT NOT NULL,
	dataPedido DATE DEFAULT CURRENT_DATE,
-- Atributos do carrinho de compras como chave estrangeira.
	CONSTRAINT not_fkey4 FOREIGN KEY (ordemPedido, codCarrinho, cpfCliente, codProduto) REFERENCES pedido(ordemPedido, codCarrinho, cpfCliente, codProduto),
-- Atributo da transportadora denotando a cardinalidade 	
	CONSTRAINT not_fkey5 FOREIGN KEY (cnpjTransportadora) REFERENCES transportadora(cnpj),
	CONSTRAINT not_pkey PRIMARY KEY (codAlfanumerico, ordemPedido, codCarrinho, codProduto, cpfCliente, cnpjTransportadora)
);
