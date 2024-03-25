create database produtoClientes

use produtoClientes


create table cliente(
	codigo		int			not null,
	nome		varchar(40) not null
	primary key (codigo)
)
go
create table produto(
	codigo		int				not null,
	nome		varchar(40)		not null,
	valor		decimal(7, 2)	not null
	primary key (codigo)
)
go 
create table venda(
	codigo			int				not null,
	codigo_cli		int				not null,
	codigo_prod		int				not null,
	quantidade		int				not null,
	valor_total		decimal(7, 2)	not null,
	dt				date			not null
	primary key (codigo)
)


insert into produto
values (1, 'RTX 4090', 3000.00),
	   (2, 'Biscoito', 4.00),
	   (3, 'Cigarro', 3.00)

insert into cliente 
values (1, 'Luan'),
	   (2, 'Matheus'),
	   (3, 'Luiz')

insert into venda
values (1, 1, 1, 2, 6000.00, getdate()),
	   (2, 2, 2, 1, 4.00, getdate()),
	   (3, 3, 3, 3, 9.00, GETDATE())


create function fn_clienteProduto()
returns @tabela table (
	nome_cli	varchar(40),
	nome_proud	varchar(40),
	quantidade	int,
	valor_total	decimal(7, 2),
	data_hoje	date
)
begin
	insert into @tabela (nome_cli, nome_proud, quantidade, valor_total, data_hoje)
		select cliente.nome,
			   produto.nome,
			   venda.quantidade,
			   venda.valor_total,
			   venda.dt
		from cliente, produto, venda 
		where cliente.codigo = venda.codigo_cli 
		and produto.codigo = venda.codigo_prod

	return
end

select * from fn_clienteProduto()
