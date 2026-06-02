# Projetos_PostgreSQL

# Sistema de E-commerce - Banco de Dados Relacional (PostgreSQL)

## Sobre o Projeto
Este projeto foi desenvolvido como parte da disciplina **Tópicos de Banco de Dados**. Trata-se da modelagem e implementação de um banco de dados relacional para um sistema de e-commerce simplificado, cobrindo desde o cadastro de clientes e fornecedores até o gerenciamento de carrinhos, pedidos, notas fiscais, entregas e devoluções.

O objetivo principal é demonstrar o domínio em modelagem de dados (DDL), manipulação de dados (DML), integridade referencial por meio de chaves estrangeiras complexas e consultas analíticas (DQL) utilizando agregações, subqueries e filtros avançados.

---

## Integrantes do Grupo
* **Juan Pablo Garcia** - RA: 769203
* **João Victor Chiorato Biagioni** - RA: 769135
* **João Gabriel Morais Costa** - RA: 769208
* **Marcelo Henrique Canciano Fratini** - RA: 760513

---

## Estrutura do Banco de Dados (DDL)

O banco é composto por **10 tabelas** fortemente relacionadas para garantir a consistência das regras de negócio do e-commerce:

1. **`fornecedor`**: Registra as empresas que fornecem os produtos.
2. **`transportadora`**: Empresas responsáveis pelas entregas.
3. **`cliente`**: Cadastro de consumidores.
4. **`devolucao`**: Registra o histórico de devoluções iniciadas por clientes.
5. **`recomendacao`**: Associa categorias de interesse ao comportamento de compra do cliente.
6. **`produto`**: Catálogo de itens disponíveis, vinculado a um fornecedor.
7. **`entrega`**: Controle de logística e estimativa de tempo de frete.
8. **`carrinhodecompras`**: Entidade intermediária que gerencia os itens e as quantidades selecionadas pelos clientes.
9. **`pedido`**: Consolidação do carrinho de compras integrado à transportadora responsável.
10. **`notafiscal`**: Faturamento oficial do pedido com data de registro automático.

---

## Tecnologias Utilizadas
* **SGBD:** PostgreSQL (v15+)
* **Linguagem:** SQL (Structured Query Language)

---

## Principais Consultas Analíticas Implementadas (DQL)

O script inclui consultas avançadas prontas para geração de relatórios de BI (Business Intelligence) e auditoria de dados:

###  Indicadores de Devoluções
Identifica os clientes que realizaram devoluções e calcula a frequência de devoluções por CPF.
```sql
SELECT COUNT(*), cpfCliente FROM public.devolucao GROUP BY cpfCliente;
```
# Rastreamento Financeiro e Logístico Completo

Uma consulta multi-join que correlaciona o cliente, o produto comprado, o fornecedor de origem, a transportadora responsável e o montante total transacionado.
SQL

```sql
SELECT SUM(ca.quantidadeProduto * p.preco) as total, c.prenome, p.nome, m.nomefantasia, t.nomefantasia 
FROM public.produto as p, public.fornecedor as m, public.cliente as c, 
     public.transportadora as t, public.pedido as pe, public.carrinhodecompras as ca
WHERE m.cnpj = p.cnpjFornecedor 
  AND pe.codProduto = p.cod 
  AND t.cnpj = pe.cnpjTransportadora
  AND c.cpf = ca.cpfCliente 
  AND ca.codProduto = p.cod
GROUP BY c.prenome, p.nome, m.nomefantasia, t.nomefantasia;
```

# Auditoria de Compras Acima da Média (Cláusula HAVING)

Filtra dinamicamente clientes com carrinhos de alto valor (compras superiores a R$ 100,00), ordenando do maior para o menor gasto.
SQL
```sql
SELECT c.prenome as nomecliente, p.nome as nomeproduto, p.preco, ca.quantidadeProduto,
       SUM((ca.quantidadeProduto * preco)) as total
FROM public.cliente as c, public.carrinhodecompras as ca, public.produto as p 
WHERE c.cpf = ca.cpfCliente AND ca.codProduto = p.cod 
GROUP BY c.prenome, ca.codProduto, p.nome, p.preco, ca.quantidadeProduto
HAVING SUM((ca.quantidadeProduto * preco)) > '100'
ORDER BY total DESC;
```
# Cálculos de Médias Gerais com Subqueries Complexas

Divide o somatório total do dinheiro gasto no site pelo somatório total de volumes de produtos vendidos para extrair o ticket médio por item.
SQL
```sql
SELECT (SELECT SUM(total) FROM (...)) / (SELECT SUM(quantidadeproduto) FROM (...));
```
# Manipulação de Strings e Datas Internas (Temporal Data)

Uso de funções nativas como CONCAT para tratamento visual de endereços/nomes e a função AGE() para calcular a idade exata dos clientes de forma dinâmica com base na data de nascimento.
SQL
```sql
SELECT CONCAT(prenome, ' ', sobrenome), cpf, CONCAT(cep, ' ', numero, ' ', complemento),
       AGE(dataNascimento) 
FROM public.cliente 
WHERE prenome LIKE '%1';
```

# Como Executar o Projeto

    Certifique-se de ter o PostgreSQL instalado e ativo em sua máquina.

    Crie um banco de dados vazio (ex: ecommerce_db).

    Execute o script DDL de criação das tabelas na ordem apresentada no arquivo para garantir que as restrições de FOREIGN KEY sejam criadas sem erros.

    Execute o script DML para popular as tabelas com os dados de teste pré-configurados.

    Execute qualquer uma das consultas analíticas listadas para visualizar os resultados populados.
