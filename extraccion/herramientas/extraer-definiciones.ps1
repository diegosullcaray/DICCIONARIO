<#
.SYNOPSIS
  Descarga el CREATE PROCEDURE de cada SP del catálogo a extraccion/procedimientos/<base>/<esquema>/<SP>.sql.

.DESCRIPTION
  Lee extraccion/sql/01-extraccion/manifiesto.json (lo genera `npm run generar`) y, por cada SP,
  ejecuta OBJECT_DEFINITION con sqlcmd. A diferencia de sp_helptext, no corta líneas
  de más de 255 caracteres. Por defecto solo baja los pendientes. No guarda credenciales: usa autenticación de Windows (-E)
  salvo que se pase -Usuario, en cuyo caso sqlcmd pide la contraseña.

.EXAMPLE
  ./extraccion/herramientas/extraer-definiciones.ps1 -Servidor SRV-REPORTES
  ./extraccion/herramientas/extraer-definiciones.ps1 -Servidor SRV-REPORTES -Base mod_rep            # solo los pendientes de esa base
  ./extraccion/herramientas/extraer-definiciones.ps1 -Servidor SRV-REPORTES -Nombre GSREVA01 -Sobrescribir   # vuelve a bajar uno ya extraído
#>
param(
  [Parameter(Mandatory = $true)] [string] $Servidor,
  [string] $Base,
  [string] $Nombre,
  [string] $Usuario,
  [switch] $Sobrescribir
)

$ErrorActionPreference = 'Stop'
$raiz = Resolve-Path (Join-Path $PSScriptRoot '..\..')
$manifiesto = Get-Content (Join-Path $raiz 'extraccion/sql/01-extraccion/manifiesto.json') -Raw -Encoding UTF8 | ConvertFrom-Json

if (-not (Get-Command sqlcmd -ErrorAction SilentlyContinue)) {
  throw 'No se encontró sqlcmd. Instalarlo (SQL Server Command Line Utilities) o usar los lotes de extraccion/sql/01-extraccion/_lotes/.'
}

$lista = $manifiesto.procedimientos | Where-Object {
  (-not $Base -or $_.base -eq $Base) -and
  (-not $Nombre -or $_.nombre -eq $Nombre) -and
  ($Sobrescribir -or -not $_.extraido)
}

$ok = 0; $faltan = @(); $errores = @()
foreach ($sp in $lista) {
  $destino = Join-Path $raiz $sp.destino
  $consulta = "SET NOCOUNT ON; SELECT OBJECT_DEFINITION(OBJECT_ID(N'[$($sp.esquema)].[$($sp.nombre)]'));"
  $auth = if ($Usuario) { @('-U', $Usuario) } else { @('-E') }
  try {
    # -h -1 sin encabezado · -y 0 sin truncar nvarchar(max) · -f 65001 UTF-8
    $texto = & sqlcmd -S $Servidor @auth -d $sp.base -h -1 -y 0 -f 65001 -Q $consulta 2>&1 | Out-String
    if ($LASTEXITCODE -ne 0) { throw $texto }
    $texto = $texto.Trim()
    if (-not $texto -or $texto -eq 'NULL') { $faltan += "$($sp.base).$($sp.esquema).$($sp.nombre)"; continue }
    New-Item -ItemType Directory -Force -Path (Split-Path $destino) | Out-Null
    $cabecera = "-- Extraído de $Servidor/$($sp.base) el $(Get-Date -Format 'yyyy-MM-dd') con extraer-definiciones.ps1`r`n"
    [System.IO.File]::WriteAllText($destino, $cabecera + $texto + "`r`n", (New-Object System.Text.UTF8Encoding $false))
    $ok++
    Write-Host "  ✓ $($sp.destino)"
  } catch {
    $errores += "$($sp.base).$($sp.esquema).$($sp.nombre): $_"
  }
}

Write-Host ""
Write-Host "Extraídos: $ok de $($lista.Count)"
if ($faltan.Count) { Write-Warning "No existen en el servidor ($($faltan.Count)) — registrar como hallazgo:"; $faltan | ForEach-Object { Write-Host "  · $_" } }
if ($errores.Count) { Write-Warning "Errores ($($errores.Count)):"; $errores | ForEach-Object { Write-Host "  · $_" } }
Write-Host "Siguiente paso: npm run generar"
