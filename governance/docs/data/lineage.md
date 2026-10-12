# Linaje

El recorrido de una cifra, de la tabla a la pantalla, y qué artefacto de este repositorio documenta cada tramo.

```text
tabla (storage, strategos, …)            diccionario/tablas/<base>/<esquema>/<tabla>.md
   │ columnas que lee                     ▲ columnas usadas + quién las usa
   ▼                                      │
procedimiento (mod_rep.com.GSELREP001)   diccionario/procedimientos/<base>/<esquema>/<SP>.md
   │ parámetros en orden                  ▲ firma, tablas, salida
   ▼                                      │
reporte (RCODREP = SEL_EFEC_01)          fuente/reportes.json → diccionario/reportes.md
   │ cod_rep por Winder/Ant               ▲
   ▼                                      │
pantalla de MIS-angular-front            fuente/consumo-front.json (npm run trazar:front)
```

## Cómo rastrear una cifra

1. **Desde la pantalla**: buscar el `cod_rep` en las constantes del módulo del front, y ese código en
   [reportes.md](../../../diccionario/reportes.md).
2. **Del reporte al SP**: la columna *Procedimiento* lleva a la ficha.
3. **Del SP a la tabla**: la ficha lista tablas y columnas; la columna de salida del SP (sección
   *Columnas que devuelve*) es el nombre que llega al front.
4. **De la tabla hacia arriba**: la ficha de tabla lista todos los SP —y por ende los reportes— que la usan.
   Es el análisis de impacto antes de cambiar una tabla.

## Cortes conocidos del linaje

- **SQL dinámico** (`EXEC(@sql)`, `sp_executesql`): las tablas armadas en texto no se ven. La ficha lo marca.
- **SP invocados** (`EXEC otro_sp`): el linaje sigue en la ficha del invocado si está en el catálogo;
  si no lo está (como `FTHEACOLS01`), se corta y se registra.
- **Tablas temporales**: el linaje pasa por `#tmp` sin documentarse como tabla: lo que importa es la
  tabla real que la llenó.
