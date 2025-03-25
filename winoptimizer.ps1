# Script PowerShell avanzado para limpiar Windows, desactivar telemetría, bloquear anuncios, optimizar rendimiento y mejorar seguridad

# Verificar ejecución como administrador
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Este script debe ejecutarse como administrador. Cerrando..."
    Pause
    Exit
}

# Crear punto de restauración
Function Create-RestorePoint {
    Try {
        Log "Creando punto de restauración del sistema..."
        Checkpoint-Computer -Description "Optimización Windows Script" -RestorePointType "MODIFY_SETTINGS"
    } Catch {
        Log "No se pudo crear el punto de restauración: $_"
    }
}

# Detectar si está en una máquina virtual
Function Detect-VM {
    $model = (Get-CimInstance Win32_ComputerSystem).Model
    return ($model -match "Virtual|VMware|Hyper-V")
}

# Definir log
$logFile = "$env:USERPROFILE\Desktop\Windows_Tuning_Log.txt"
Function Log {
    Param ([string]$Message)
    $logEntry = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] $Message"
    Write-Host $logEntry -ForegroundColor Green
    Add-Content -Path $logFile -Value $logEntry
}

# Función para mostrar resumen al finalizar
Function Show-Summary {
    Write-Host "`n===== RESUMEN DE OPTIMIZACIÓN =====" -ForegroundColor Cyan
    Get-Content $logFile | Select-String "\[.*\]" | ForEach-Object { Write-Host $_.Line }
    Copy-Item $logFile -Destination "C:\Optimización\Log_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt" -Force -ErrorAction SilentlyContinue
}

# Detectar versión de Windows
Function Detect-WindowsVersion {
    $build = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").CurrentBuild
    switch ($build) {
        {$_ -lt 8000} { return "Windows 7" }
        {$_ -lt 22000} { return "Windows 10" }
        default { return "Windows 11" }
    }
}

# Mostrar menú principal según la versión
Function Show-Menu {
    $windowsVersion = Detect-WindowsVersion
    Log "Versión detectada: $windowsVersion"

    Clear-Host
    Write-Host "=================================" -ForegroundColor Cyan
    Write-Host "   Optimización para $windowsVersion" -ForegroundColor Green
    Write-Host "=================================" -ForegroundColor Cyan
    Write-Host "1. Eliminar Bloatware" -ForegroundColor Yellow
    Write-Host "2. Bloquear Anuncios y Telemetría" -ForegroundColor Yellow
    Write-Host "3. Optimizar Rendimiento" -ForegroundColor Yellow
    Write-Host "4. Mejorar Seguridad" -ForegroundColor Yellow
    Write-Host "5. Actualizar Windows y Drivers" -ForegroundColor Yellow
    Write-Host "6. Ejecutar todas las opciones (modo automático)" -ForegroundColor Yellow
    Write-Host "7. Salir" -ForegroundColor Red

    $choice = Read-Host "Seleccione una opción (1-7)"
    Switch ($choice) {
        "1" { if ((Read-Host "¿Eliminar bloatware? (S/N)").ToUpper() -eq "S") { Log "===[ Ejecutando: Eliminar Bloatware ]==="; Create-RestorePoint; Remove-Bloatware $windowsVersion } }
        "2" { if ((Read-Host "¿Bloquear anuncios y telemetría? (S/N)").ToUpper() -eq "S") { Log "===[ Ejecutando: Bloquear Anuncios y Telemetría ]==="; Create-RestorePoint; Block-Ads-Telemetry $windowsVersion } }
        "3" { if ((Read-Host "¿Optimizar rendimiento? (S/N)").ToUpper() -eq "S") { Log "===[ Ejecutando: Optimizar Rendimiento ]==="; Create-RestorePoint; Optimize-Performance $windowsVersion } }
        "4" { if ((Read-Host "¿Mejorar seguridad? (S/N)").ToUpper() -eq "S") { Log "===[ Ejecutando: Mejorar Seguridad ]==="; Create-RestorePoint; Improve-Security $windowsVersion } }
        "5" { if ((Read-Host "¿Actualizar Windows y drivers? (S/N)").ToUpper() -eq "S") { Log "===[ Ejecutando: Actualizar Windows y Drivers ]==="; Create-RestorePoint; Update-System $windowsVersion } }
        "6" {
            Log "===[ Ejecutando: Todos los módulos en modo automático ]==="
            Create-RestorePoint
            Remove-Bloatware $windowsVersion
            Block-Ads-Telemetry $windowsVersion
            Optimize-Performance $windowsVersion
            Improve-Security $windowsVersion
            Update-System $windowsVersion
            Show-Summary
            Exit
        }
        "7" { Exit }
        default { Write-Host "Selección inválida." -ForegroundColor Red; Start-Sleep 2; Show-Menu }
    }
    Show-Menu
}

# Iniciar log y mostrar menú
if (!(Test-Path $logFile)) {
    New-Item -ItemType File -Path $logFile -Force | Out-Null
    Log "Creando log de ejecución en: $logFile"
}

Show-Menu
