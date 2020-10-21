create procedure RegistraNacimiento
	@nombre varchar(50),
	@patrimonio money,
	@padre int
as
begin
    declare @idPatriarcaInsertado int
	
	begin tran

	insert into Patriarcas (Nombre, Patrimonio, Padre, Primogenito)
					values (@nombre, @patrimonio, @padre, NULL)

    select top 1 @idPatriarcaInsertado = IdPatriarca --el top 1 es opcional
	from Patriarcas 
	where Nombre = @nombre and Patrimonio = @patrimonio and Padre = @padre

	update Patriarcas
	set Primogenito = @idPatriarcaInsertado
	where IdPatriarca = @padre

	commit tran

end
