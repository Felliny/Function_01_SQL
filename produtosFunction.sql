create table produtos(
	codigo			int				not null,
	nome			varchar(40)		not null,
	valor_uni		decimal(7, 2)	not null,
	qtd_estoque		int				not null,
	primary key(codigo)
)


insert into produtos
values (1, 'RTX 4090', 3000.00, 2),
	   (2, 'Biscoito', 4.00, 40),
	   (3, 'Cigarro', 3.00, 150)



create function fn_estoquebaixo(@quantidade	int)
returns int
as
begin
	declare @quant int

	if (@quantidade > 0)
	begin
		select @quant = count(codigo) from produtos where qtd_estoque < @quantidade
	end

	return @quant
end

select dbo.fn_estoquebaixo(30) as total_produtos_baixoestoque


create function fn_quantidadeBaixoTabela(@quantidade int)
returns @tabela table (
	codigo		int,
	nome		varchar(40),
	estoque		int
)
begin
	insert into @tabela (codigo, nome, estoque)
		select codigo, nome, qtd_estoque from produtos where qtd_estoque < @quantidade


	return
end

select * from fn_quantidadeBaixoTabela(100)


