create database funcionariosFunction
go
use funcionariosFunction

create table funcionario(
	codigo		int				not null,
	nome		varchar(40)		not null,
	salario		decimal(7, 2)	not null
	primary key (codigo)
)
go
create table dependente(
	codigo_dep			int				not null,
	codigo_fun			int				not null,
	nome_den			varchar(40)		not null,
	salario_dependente	decimal(7, 2)	not null
	primary key (codigo_dep)
	foreign key (codigo_fun) references funcionario (codigo)
)


insert into funcionario
values (1, 'Luan', 1300.00),
	   (2, 'Thiago', 2000.00),
	   (3, 'Jonas', 3000.00)	
	   

insert into dependente
values (1, 1, 'Matheus', 1200.00),
	   (2, 2, 'Luiz', 1200.00),
	   (3, 3, 'Leandro', 2000.00)


create function fn_FuncDepSalario()
returns @tabela table (
	nome_func		varchar(40),
	nome_dep		varchar(40),
	salario_func	decimal(7, 2),
	salario_dep		decimal(7, 2)
)
begin
	declare @nome_func varchar(40),
			@nome_dep  varchar(40),
			@salario_func   decimal(7, 2),
			@salario_dep	decimal(7, 2)
	
	
	insert into @tabela (nome_func, nome_dep, salario_func, salario_dep)
		select funcionario.nome, 
			   dependente.nome_den,
			   funcionario.salario,
			   dependente.salario_dependente
			   from funcionario, dependente 
			   where funcionario.codigo = dependente.codigo_fun

	return

end

select * from fn_FuncDepSalario()


create function fn_somasalario()
returns decimal(7, 2)
as 
begin
	declare @soma		decimal(7, 2),
			@sal_dep	decimal(7, 2),
			@sal_func	decimal(7, 2)

	select @sal_dep = sum(salario_dep) from fn_FuncDepSalario()
	select @sal_func = sum(salario_func) from fn_FuncDepSalario()

	set @soma = @sal_dep + @sal_func

	return @soma
end


select fn_somasalario() as soma_salario
