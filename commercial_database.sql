 
-- criar a database

drop database if exists shop;
create database shop;

-- database em uso

use shop;

-- criar tabelas
-- primeiro as que nao tem ligacoes

create table client (
id_client int not null primary key auto_increment,
nif_client varchar(9),
name_client varchar(50), 
address_client varchar(100),
phone_client varchar(15),
email_client varchar(30)
);

create table category (
id_category int not null primary key auto_increment,
name_category varchar(50),
description_category varchar(100)
);

create table product (
id_product int not null primary key auto_increment,
name_product varchar(50),
description_product varchar(100),
price_product decimal(10,2),
quantity_product int,
id_category int,

foreign key (id_category) references category(id_category)
);

create table `order` (
id_order int not null primary key auto_increment,
date_order date,
id_client int,

foreign key (id_client) references client(id_client)
);

create table product_order (
id_product_order int not null primary key auto_increment,
quantity_product_order int,
id_product int,
id_order int,

foreign key (id_product) references product(id_product),
foreign key (id_order) references `order`(id_order)
);

-- popular as tabelas com dados

insert into client (nif_client, name_client, address_client, phone_client, email_client)
values
('123456789', 'Ana Silva', 'Rua das Flores 10', '987654321', 'ana@gmail.com'),
('132456789', 'Bruno Costa', 'Rua Principal 5', '897654321', 'bruno@mail.com'),
('124356789', 'Carlos Sousa', 'Rua 5 de Outubro 20', '986754321', 'carlos@mail.com'),
('123465789', 'Diana Martins', 'Avenida da Liberdade 2', '987645321', 'diana@sapo.pt'),
('123456879', 'Paulo Silva', 'Rua das Flores 10', '987894321', 'paulo@gmail.com');

insert into category (name_category, description_category)
values
('Technology', 'Technology Items.'),
('Books', 'Technical Books.'),
('Televisions', 'Various televisions models.'),
('Radios', 'Old radios.');

insert into product (name_product, description_product, price_product, quantity_product, id_category)
VALUES
('Keyboard', 'Sony Keyboard', 59.99, 10, 1),
('Mouse', 'Wireless Mouse', 19.99, 20, 1),
('SQL', 'SQL Book', 14.50, 5, 2),
('TV', 'LG TV', 250.00, 30, 3);


insert into `order` (date_order, id_client)
values
('2026-01-10', 1),
('2025-05-08', 3),
('2026-10-15', 3);

insert into product_order (id_order, id_product, quantity_product_order)
values
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(2, 3, 1);

select * from client;
select * from category;
select * from product;
select * from `order`;
select * from product_order;

select name_client, address_client
from client;

select name_product, price_product
from product
where price_product > 50;

select *
from category
where name_category = "Technology";

-- 4) Seleciona todas as encomendas feitas pelo cliente com id_client = 3.

select * 
from `order`
where id_client=3;

-- 5) Seleciona todos os produtos cuja descrição contenha a palavra “SQL”.
select *
from product
where description_product like "%SQL%";

-- 6) Lista todos os clientes ordenados alfabeticamente pelo nome.
select *
from client
order by name_client ASC;

-- 7) Lista todos os produtos ordenados por preço do mais caro para o mais barato.
select *
from product
order by price_product DESC;

-- 8) Lista todas as encomendas ordenadas da mais recente para a mais antiga.
select *
from `order`
order by date_order desc;

 -- 9) Lista todas as moradas distintas onde existem clientes.
select count(address_client), address_client
from client
group by address_client;

select distinct address_client
from client;
 
-- 10)Seleciona todos os clientes cujo nome começa por “A”.
select *
from client
where name_client like "A%"; 

-- 11)Seleciona todos os clientes cujo nome contenha “ana”, em qualquer local do nome.
select *
from client
where name_client like "%Ana%"; 

-- 12)Seleciona todos os produtos cuja descrição contenha a palavra “Sony”.
select *
from product
where description_product like "%Sony%"; 

-- 13)Seleciona todos os clientes cujo email termine em “@mail.com”.
select *
from client
where email_client like "%@gmail.com";

-- 14)Seleciona todos os produtos pertencentes às categorias com id 1, 2 ou 3.
select *
from product
where id_category = 1 OR 2 OR 3;

SELECT * FROM Product 
WHERE id_category IN (1, 2, 3);

-- 15)Seleciona todos os produtos com preço entre 10€ e 30€.
select *
from product
where price_product between 10 and 30;

-- 16)Seleciona todas as encomendas feitas entre ‘2026-01-01’ e ‘2026-01-31’.
select *
from `order`
where date_order between "2026-01-01" and  "2026-01-31";

-- 17)Conta quantos clientes existem na tabela Client.
select count(*) as total_clientes
from client;

-- 18)Calcula o preço médio de todos os produtos.
select round(avg(price_product))
from product;

-- 19)Qual é o preço do produto mais barato e qual o preço do mais caro?
select min(price_product) as mais_barato, max(price_product) as mais_caro
from product;

-- 20)Calcula o total de quantidade vendida, por produto (usando OrderProduct).
select id_product, sum(quantity_product_order)
from product_order
group by id_product;

-- 21)Qual é o número de encomendas que fez cada cliente?
select id_client, count(id_order)
from `order`
group by id_client;

-- 22)Lista o total de produtos, por categoria?
select id_category, count(name_product)
from product
group by id_category;

-- 23) Qual é a quantidade total vendida, por produto?
select id_product, sum(quantity_product_order) as quantidade
from product_order
group by id_product;

-- 24)Lista as categorias cujo total de produtos seja superior a 5.
SELECT id_category, quantity_product
FROM product
where quantity_product > 5;

-- qual é o numero de encomendas que fez cada cliente?
select id_client, count(id_order)
from `order`
group by id_client; 

-- listar os clientes que fizeram mais de uma encomneda
SELECT id_client, COUNT(id_order) AS total_encomendas
FROM `order`
GROUP BY id_client
HAVING COUNT(id_order) > 1;

-- listar os produtos cuja quantidade total vendida seja superior a 1
select id_product, sum(quantity_product_order) as total_vendido
FROM product_order
GROUP BY id_product
HAVING sum(quantity_product_order)> 1;

-- INNER JOINS
-- lista todas as encomendas com o nome do cliente  associado
select client.name_client, `order`.id_order
from client
inner join `order` on client.id_client = `order`.id_client;

-- lista de todos os produtos com o nome da categoria associado
select product.name_product, category.name_category
from product
join category on product.id_category = category.id_category;

-- lista de todos os produtos incluidos na encomenda com id order = 1
select product.name_product, product_order.id_product_order
from product
join product_order on product.id_product = product_order.id_product 
where product_order.id_product_order = 1;

-- lista de todas as encomendas com os produtos e respectivas quantidades
select product_order.id_order, product.name_product, product_order.quantity_product_order
from product_order
join product on product_order.id_product = product.id_product
order by product_order.id_order;

-- seleciona todos os clientes que tem pelo menos uma encomenda
select client.id_client, client.name_client, `order`.id_order
from client
join `order` on client.id_client = `order`.id_client
where `order`.id_client >= 1;

-- OU
select name_client from client
where exists (
select 1 from `order`
where `order`.id_client = client.id_client
);

-- seleciona todos os clientes que tem pelo menos uma encomenda, soma as encomendas
select client.id_client, client.name_client, COUNT(`order`.id_order) AS total_encomendas
from client
join `order` on client.id_client = `order`.id_client
group by client.id_client, client.name_client;

-- SELECIONA TODOS OS PRODUTOS QUE JA FORAM VENDIDOS PELO MENOS UMA VEZ
select product.name_product, product_order.id_product
from product
join product_order on product.id_product = product_order.id_product;

SELECT product.name_product, product_order.id_product
FROM product
JOIN product_order ON product.id_product = product_order.id_product
GROUP BY product.id_product, product.name_product;

-- qual a quantidade total vendida por produto?
select product.name_product, sum(product_order.quantity_product_order) as total_vendido
from product
join product_order on product.id_product = product_order.id_product
group by product.name_product; -- agarrou nos nomes que sao iguais e depois vai pro resto

-- SELECIONA OS PRODUTOS MAIS CAROS
select name_product, price_product 
from product
order by price_product desc
limit 2;


select * from client;
select * from `order`;
select * from product_order;
select * from product;
select * from category;



 



 
