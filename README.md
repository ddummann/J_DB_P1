# PROYECTO #1 BASES DE DATOS 


## Fundamentos de Bases de Datos, Pontificia Universidad Javeriana 

> `Se tiene la información de artículos científicos que son publicados en revistas científicas.  De estos artículos se tiene la siguiente información:`

- Area (CodigoArea, NombreArea)

- Artículo (CodigoArtículo, NombreArtículo, FechaPublicacion).

- ArtículoXArea(CodigoArea, CodigoArtículo)

- Autor (CodigoAutor, NombresAutor, ApellidosAutor, FechaNacimientoAutor, email)  

> (Para el campo email Solo se deben permitir formatos de correo electrónico válidos. (AYUDA: Le podría servir la sentencia REGEXP_LIKE de Oracle https://docs.oracle.com/database/121/SUTIL/GUID-95DE4B18-3094-46AA-BC0A-A53E8AE56263.htm))

- AutoresXArticulo(CodigoAutor, CodigoArticulo, Rol) . (Referencias a Autor y Artículo). El rol solo puede ser P principal y C Coautor.

- Referencias (CodigoArtículoRef1, CodigoArticuloRef2) (Referencias a Artículo y Artículo)

- Revista (CodigoRevista, FechaCreacion, NombreRevista, Categoria) . Los únicos valores permitidos en Categoría deben ser A1, A2, B, C

- Publicacion (CodigoRevista, CodigoArticulo, Fechapublicacion)

`Additional information:`

    Un artículo puede ser publicado en varias revistas.
    Un artículo se puede publicar en el misma revista en fechas diferentes.

    **Los valores de categoria de revistas solo pueden ser A1, A2, B, C
    **Todas las restricciones de llave foranea deben llamarse FK_CAMPO_TABLAORIGEN_CAMPO_TABLADESTINO (Si sobrepasa el máximo permitido en caracteres puede recortarlos como considere)
    **El único campo que no es obligatorio es FechaNacimientoAutor.

`Additional Cases:`
- Se puede dar el caso que existan Autores que aún no han publicado ningún artículo.
- Se puede dar el caso de Areas sin publicaciones.
- Se puede dar el caso de Revistas que aun no han publicado ningún artículo
- Un ejemplo de tipos de áreas lo encuentra en :
- https://minciencias.gov.co/sites/default/files/upload/convocatoria/m304pr03an01_modelo_de_clasificacion_de_revistas_-_publindex_v02.pdf  (Anexo a)

PROBLEMS!!
In case you got an error in line 225 from query number 5, please in the last select, change 'Año' to Anio and 'NumeroArtÍculosPublicadosEnRevistas' to NumeroArticulosPublicadosEnRevistas without the accent mark and the 'ñ'.
