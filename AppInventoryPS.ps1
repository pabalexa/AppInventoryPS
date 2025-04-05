# Script para obtener todas las aplicaciones instaladas en el sistema
# El resultado se mostrará en pantalla y se guardará en un archivo de texto

# Definir la ruta donde se guardará el archivo
$outputFile = "$env:USERPROFILE\Desktop\AplicacionesInstaladas.txt"

# Obtener la fecha y hora actuales para incluirlas en el reporte
$fechaActual = Get-Date -Format "dd/MM/yyyy HH:mm:ss"

# Crear el encabezado del informe
$encabezado = @"
==========================================
LISTA DE APLICACIONES INSTALADAS
Fecha de generación: $fechaActual
Equipo: $env:COMPUTERNAME
Usuario: $env:USERNAME
==========================================

"@

# Mostrar el encabezado en la consola
Write-Host $encabezado -ForegroundColor Cyan

# Obtener aplicaciones desde diferentes fuentes para asegurar una lista completa

# 1. Obtener desde el registro (Programas instalados para la máquina)
Write-Host "Obteniendo programas instalados desde el registro..." -ForegroundColor Yellow
$uninstallKeys = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
)

# 2. Incluir aplicaciones instaladas para el usuario actual
if (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*") {
    $uninstallKeys += "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
}

# Obtener todas las aplicaciones del registro
$aplicacionesRegistro = Get-ItemProperty $uninstallKeys | 
    Where-Object { $_.DisplayName -ne $null } | 
    Select-Object DisplayName, DisplayVersion, Publisher, InstallDate |
    Sort-Object DisplayName

# 3. Obtener aplicaciones modernas de Windows (si estamos en Windows 10/11)
try {
    Write-Host "Obteniendo aplicaciones modernas de Windows..." -ForegroundColor Yellow
    $aplicacionesModernas = Get-AppxPackage | 
        Where-Object { $_.IsFramework -eq $false -and $_.SignatureKind -ne "System" } |
        Select-Object @{Name="DisplayName"; Expression={$_.Name}}, 
                      @{Name="DisplayVersion"; Expression={$_.Version}}, 
                      @{Name="Publisher"; Expression={$_.Publisher}},
                      @{Name="InstallDate"; Expression={$_.InstallDate}}
} catch {
    Write-Host "No se pudieron obtener aplicaciones modernas de Windows" -ForegroundColor Red
    $aplicacionesModernas = @()
}

# Combinar todas las aplicaciones
$todasLasAplicaciones = $aplicacionesRegistro + $aplicacionesModernas | Sort-Object DisplayName

# Contar las aplicaciones encontradas
$totalAplicaciones = $todasLasAplicaciones.Count
Write-Host "Se encontraron $totalAplicaciones aplicaciones instaladas." -ForegroundColor Green

# Crear el contenido del archivo
$contenidoArchivo = $encabezado
$contenidoArchivo += "TOTAL DE APLICACIONES ENCONTRADAS: $totalAplicaciones`n`n"
$contenidoArchivo += "NOMBRE`tVERSIÓN`tFABRICANTE`tFECHA DE INSTALACIÓN`n"
$contenidoArchivo += "----------------------------------------------------------------------`n"

# Mostrar las aplicaciones en la consola y agregarlas al contenido del archivo
foreach ($app in $todasLasAplicaciones) {
    $linea = "$($app.DisplayName)`t$($app.DisplayVersion)`t$($app.Publisher)`t$($app.InstallDate)"
    Write-Host $linea
    $contenidoArchivo += "$linea`n"
}

# Guardar el contenido en el archivo
$contenidoArchivo | Out-File -FilePath $outputFile -Encoding utf8

# Mostrar información sobre el archivo guardado
Write-Host "`nLa lista completa ha sido guardada en: $outputFile" -ForegroundColor Green
Write-Host "Puede abrir este archivo con el comando: notepad `"$outputFile`"" -ForegroundColor Cyan

# Opcionalmente, abrir el archivo automáticamente
$respuesta = Read-Host "¿Desea abrir el archivo ahora? (S/N)"
if ($respuesta -eq "S" -or $respuesta -eq "s") {
    Start-Process notepad.exe -ArgumentList $outputFile
}