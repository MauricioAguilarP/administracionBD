alter trigger modificaPatriarcas
on Patriarcas
instead of insert, update, delete
as 
begin
	
	declare @idRegistro int
	declare @idPadre int
	declare @idHijo int	
	declare @nombre varchar(50)
	declare @patrimonio money
	
	declare @numeroRegistrosTablaInserted int
	declare @numeroRegistrosTablaDeleted int

	select @numeroRegistrosTablaInserted = count(*) from inserted
	select @numeroRegistrosTablaDeleted = count(*) from deleted

	if (@numeroRegistrosTablaInserted=0) and (@numeroRegistrosTablaDeleted=0)
		print 'No se afectó ningún registro'
	else if (@numeroRegistrosTablaInserted>1) or (@numeroRegistrosTablaDeleted>1)
		print 'Esta tabla sólo puede modificarse registro por registro'
    else if (@numeroRegistrosTablaInserted>0) and (@numeroRegistrosTablaDeleted>0)
		print 'Esta tabla no se puede hacer update'	
	else if (@numeroRegistrosTablaInserted>0) and (@numeroRegistrosTablaDeleted=0)
		begin
			select top 1 @nombre = Nombre, @patrimonio = Patrimonio, @idPadre = Padre from inserted

			declare @idPatriarcaInsertado int
	
			

			insert into Patriarcas (Nombre, Patrimonio, Padre, Primogenito)
					values (@nombre, @patrimonio, @idPadre, NULL)

			select top 1 @idPatriarcaInsertado = IdPatriarca --el top 1 es opcional
			from Patriarcas 
			where Nombre = @nombre and Patrimonio = @patrimonio and Padre = @idPadre

			update Patriarcas
			set Primogenito = @idPatriarcaInsertado
			where IdPatriarca = @idPadre

			
		end
	else if (@numeroRegistrosTablaInserted=0) and (@numeroRegistrosTablaDeleted>0)
		begin
			select top 1 @idRegistro = IdPatriarca from deleted		

			select @idPadre = Padre, @idHijo = Primogenito
			from Patriarcas
			where IdPatriarca = @idRegistro

			delete from Patriarcas where IdPatriarca = @idRegistro

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
			



		end
		
			

end