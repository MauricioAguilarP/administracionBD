create procedure RegistraDeshonra
	@idPatriarca int
as
begin
	begin tran
	
	declare @idPadre int
	declare @idHijo int

	select @idPadre = Padre, @idHijo = Primogenito
	from Patriarcas
	where IdPatriarca = @idPatriarca

	delete from Patriarcas where IdPatriarca = @idPatriarca

	if @idPadre is not null  
		begin
			update Patriarcas
			set Primogenito = @idHijo 
			where IdPatriarca = @idPadre
		end

	if @idHijo is not null
		begin
			update Patriarcas
			set Padre = @idPadre
			where IdPatriarca = @idHijo 
		end
	commit tran
end