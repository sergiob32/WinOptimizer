# 🧹 WinOptimizer

**WinOptimizer** es una herramienta avanzada escrita en PowerShell que permite optimizar, limpiar y reforzar la privacidad y seguridad de sistemas operativos Windows 7, 10 y 11.

## 🚀 ¿Qué hace?

- ✅ Elimina bloatware innecesario (apps preinstaladas)
- ✅ Bloquea anuncios y servicios de telemetría
- ✅ Optimiza el rendimiento del sistema
- ✅ Mejora la seguridad del equipo
- ✅ Actualiza Windows y drivers
- ✅ Genera logs detallados y un resumen de cambios
- ✅ Crea un punto de restauración antes de aplicar cambios
- ✅ Detecta automáticamente la versión de Windows
- ✅ Modo interactivo y modo automático

## 🖥️ Requisitos

- Windows 7, 10 u 11
- PowerShell 5.1+
- Ejecutar como administrador

📖 Instrucciones de uso de WinOptimizer
🔹 Opción 1: Ejecutar el script manualmente
Descarga y guarda el archivo WinOptimizer.ps1 en tu equipo.

Haz clic derecho sobre él y selecciona "Ejecutar con PowerShell como administrador".

O bien, abre PowerShell como administrador y ejecuta lo siguiente:


Set-ExecutionPolicy Bypass -Scope Process -Force
.\WinOptimizer.ps1
🔹 Opción 2: Ejecutar desde archivo .exe (si fue compilado)
Haz doble clic sobre WinOptimizer.exe.

Se abrirá automáticamente con permisos de administrador (si usaste -requireAdmin).

Verás el menú interactivo con múltiples opciones.

🧭 Menú principal
markdown
Copiar
Editar
1. Eliminar Bloatware
2. Bloquear Anuncios y Telemetría
3. Optimizar Rendimiento
4. Mejorar Seguridad
5. Actualizar Windows y Drivers
6. Ejecutar todas las opciones (modo automático)
7. Salir
Cada opción solicita confirmación (S/N) antes de ejecutarse, excepto el modo automático.

🛡️ Seguridad
Antes de aplicar cambios importantes, el script crea automáticamente un punto de restauración del sistema.

🧠 Recomendaciones
Ejecuta siempre como administrador.

Cierra aplicaciones importantes antes de ejecutar.

Revisa el resultado final en el log que se genera automáticamente:

Escritorio: Windows_Tuning_Log.txt

Copia adicional: C:\Optimización\Log_<fecha>.txt

