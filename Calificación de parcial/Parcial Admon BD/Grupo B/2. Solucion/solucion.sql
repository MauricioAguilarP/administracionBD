select distinct Emisoras.Nombre
from Emisoras inner join Canales on Emisoras.IdEmisora=Canales.IdEmisora
			  inner join Transmisiones on Canales.IdCanal = Transmisiones.IdCanal
			  inner join Programas on Transmisiones.IdPrograma = Programas.IdPrograma
where Programas.Nombre = 'Sábado Gigante'	

select top 3 Canales.Nombre, sum(Contrataciones.PrecioPagado) as IngresosAnuncios
from Canales inner join Emisiones on Canales.IdCanal = Emisiones.IdCanal	  
			 inner join Anuncios on Emisiones.IdAnuncio = Anuncios.IdAnuncio 
			 inner join Contrataciones on Anuncios.IdAnuncio = Contrataciones.IdAnuncio
group by Canales.IdCanal, Canales.Nombre
order by IngresosAnuncios desc

select Clientes.*
from Clientes left outer join Contrataciones on Clientes.IdCliente = Contrataciones.IdCliente
where Contrataciones.IdContratacion is null