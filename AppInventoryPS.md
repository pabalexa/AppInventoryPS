# Documentación: Script para Listar Aplicaciones Instaladas (AppInventoryPS)

## 1. Objetivo del Código

Este script de PowerShell está diseñado para realizar un inventario completo de todas las aplicaciones y programas instalados en un sistema Windows. Su propósito principal es proporcionar una forma automatizada y exhaustiva de obtener información sobre el software instalado, tanto para fines de auditoría como para la gestión de activos de TI. El script genera un informe completo que incluye detalles como nombres de aplicaciones, versiones, fabricantes y fechas de instalación.

El código está pensado para ser utilizado por administradores de sistemas, personal de soporte técnico o cualquier profesional de TI que necesite documentar el software instalado en un equipo para:

- Inventarios de software
- Auditorías de cumplimiento
- Resolución de problemas de compatibilidad
- Planificación de actualizaciones
- Documentación de sistemas

## 2. Instrucciones de Uso

### Requisitos Previos

- Sistema operativo Windows (Windows 7, Windows 8, Windows 10 o Windows 11)
- PowerShell 3.0 o superior
- Permisos de administrador (recomendado para acceder a toda la información del registro)

### Ejecución del Script

1. **Guardar el script**: Copie el código en un archivo con extensión `.ps1` (por ejemplo, `ListarAplicacionesInstaladas.ps1`).
2. **Ejecutar PowerShell como administrador**:
   - Haga clic derecho en el icono de PowerShell y seleccione "Ejecutar como administrador"
   - O abra PowerShell normalmente si no necesita privilegios elevados.
3. **Configurar la política de ejecución** (si es necesario):
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
   ```
4. **Navegar al directorio** donde guardó el script:
   ```powershell
   cd "C:\ruta\al\directorio\"
   ```
5. **Ejecutar el script**:
   ```powershell
   .\ListarAplicacionesInstaladas.ps1
   ```

### Parámetros y Personalización

El script no requiere parámetros para su ejecución básica. Sin embargo, se puede personalizar modificando las siguientes variables dentro del código:

- `$outputFile = "$env:USERPROFILE\Desktop\AplicacionesInstaladas.txt"`: Cambie esta ruta para modificar la ubicación y nombre del archivo de salida.

## 3. Explicación del Funcionamiento

El script funciona siguiendo estos pasos principales:

1. **Inicialización**:

   - Define la ubicación donde se guardará el archivo de salida (escritorio del usuario por defecto)
   - Genera un encabezado con información del sistema y timestamp

2. **Recopilación de datos**:

   - Obtiene información de aplicaciones instaladas desde múltiples fuentes:
     - Registro de Windows (HKLM) para programas instalados a nivel de sistema
     - Registro de Windows (HKCU) para programas instalados a nivel de usuario
     - AppX/Tienda de Windows para aplicaciones modernas (Windows 10/11)

3. **Procesamiento de datos**:

   - Filtra entradas vacías o del sistema
   - Combina los resultados de las diferentes fuentes
   - Ordena alfabéticamente por nombre de aplicación

4. **Presentación de resultados**:
   - Muestra la información en la consola de PowerShell con formato
   - Genera un archivo de texto con la misma información
   - Ofrece la opción de abrir el archivo generado

El flujo de trabajo está diseñado para ser exhaustivo en la recopilación de datos, capturando tanto aplicaciones tradicionales como modernas, y proporcionando una visualización clara de los resultados.

## 4. Detalles de los Algoritmos

El script implementa varios algoritmos sencillos pero efectivos:

### 4.1. Algoritmo de Recopilación de Aplicaciones

1. **Consulta de registro**: Utiliza cmdlets de PowerShell para acceder a las claves de registro donde Windows almacena la información de desinstalación de programas.

   - Se consultan las rutas HKLM para programas instalados globalmente
   - Se consulta la ruta HKCU para programas instalados por el usuario actual
   - Se aplica un filtro para eliminar entradas sin nombre de visualización

2. **Consulta de aplicaciones modernas**: Utiliza el cmdlet `Get-AppxPackage` para recuperar información sobre aplicaciones modernas instaladas.
   - Se filtran las aplicaciones del framework y del sistema
   - Se transforman los datos para que coincidan con el formato de las aplicaciones tradicionales

### 4.2. Algoritmo de Combinación y Presentación

1. **Unificación de datos**: Combina los conjuntos de datos de diferentes fuentes en una única colección.
2. **Ordenación**: Ordena alfabéticamente las aplicaciones por nombre.
3. **Formateo**: Prepara los datos para presentación tabular tanto en consola como en archivo.

## 5. Explicación Técnica de los Algoritmos

### 5.1. Complejidad y Rendimiento

#### Consulta de Registro

- **Complejidad temporal**: O(n), donde n es el número de entradas en las claves de registro consultadas.
- **Rendimiento**: Eficiente en sistemas con un número moderado de aplicaciones instaladas. En sistemas con muchas aplicaciones, la consulta del registro puede tomar algunos segundos.

#### Consulta de Aplicaciones Modernas

- **Complejidad temporal**: O(m), donde m es el número de aplicaciones modernas instaladas.
- **Rendimiento**: Generalmente rápido, incluso con muchas aplicaciones modernas instaladas.

#### Combinación y Ordenación

- **Complejidad temporal**: O((n+m) log(n+m)) debido al algoritmo de ordenación.
- **Rendimiento**: Eficiente para la cantidad típica de aplicaciones en un sistema.

### 5.2. Ventajas y Desventajas

#### Ventajas

- **Exhaustividad**: El enfoque de múltiples fuentes garantiza la captura de casi todas las aplicaciones instaladas.
- **Simplicidad**: El algoritmo es directo y fácil de entender.
- **Rendimiento**: Suficientemente rápido para uso interactivo en la mayoría de los sistemas.

#### Desventajas

- **Privilegios**: Algunas consultas de registro pueden requerir privilegios elevados para acceso completo.
- **Dependencia de la estructura del sistema**: Cambios en la estructura del registro de Windows o en el sistema de gestión de aplicaciones modernas podrían afectar al funcionamiento.
- **Posibles falsos positivos**: Algunas entradas del registro pueden corresponder a programas no instalados correctamente o residuos de desinstalaciones previas.

## 6. Estructura del Código

El código está organizado en un único script de PowerShell con la siguiente estructura:

1. **Configuración inicial** (líneas 1-17):

   - Definición de variables
   - Creación del encabezado del informe

2. **Recopilación de datos** (líneas 18-47):

   - Definición de rutas de registro
   - Consulta de aplicaciones tradicionales
   - Consulta de aplicaciones modernas
   - Combinación de resultados

3. **Generación de informe** (líneas 48-69):

   - Formateo de datos para salida
   - Impresión en consola
   - Generación de archivo de texto

4. **Interacción con el usuario** (líneas 70-76):
   - Información sobre la ubicación del archivo
   - Opción para abrir el archivo generado

### Funciones Principales:

- No hay funciones definidas explícitamente; el script sigue un flujo secuencial.

### Relación entre Componentes:

- Los datos fluyen linealmente a través del script
- La sección de recopilación alimenta a la sección de generación de informe
- La sección de interacción con el usuario depende de la finalización exitosa de las secciones anteriores

## 7. Ejemplos de Entrada y Salida

### Entrada

El script no requiere entradas directas del usuario durante su ejecución principal, excepto para la decisión final de abrir el archivo generado.

### Salida en Consola

```
==========================================
LISTA DE APLICACIONES INSTALADAS
Fecha de generación: 05/04/2025 15:30:45
Equipo: DESKTOP-ABC123
Usuario: Usuario1
==========================================

Obteniendo programas instalados desde el registro...
Obteniendo aplicaciones modernas de Windows...
Se encontraron 157 aplicaciones instaladas.

7-Zip 22.01	22.01.00.0	Igor Pavlov	20240315
Adobe Acrobat Reader DC	23.003.20201	Adobe Inc.	20240320
Brave	123.1.66.104	Brave Software Inc.	20240401
Firefox	115.8.0	Mozilla	20240325
...

La lista completa ha sido guardada en: C:\Users\Usuario1\Desktop\AplicacionesInstaladas.txt
Puede abrir este archivo con el comando: notepad "C:\Users\Usuario1\Desktop\AplicacionesInstaladas.txt"

¿Desea abrir el archivo ahora? (S/N):
```

### Archivo de Salida (AplicacionesInstaladas.txt)

```
==========================================
LISTA DE APLICACIONES INSTALADAS
Fecha de generación: 05/04/2025 15:30:45
Equipo: DESKTOP-ABC123
Usuario: Usuario1
==========================================

TOTAL DE APLICACIONES ENCONTRADAS: 157

NOMBRE	VERSIÓN	FABRICANTE	FECHA DE INSTALACIÓN
----------------------------------------------------------------------
7-Zip 22.01	22.01.00.0	Igor Pavlov	20240315
Adobe Acrobat Reader DC	23.003.20201	Adobe Inc.	20240320
Brave	123.1.66.104	Brave Software Inc.	20240401
Firefox	115.8.0	Mozilla	20240325
...
```

## 8. Manejo de Errores

El script incorpora las siguientes estrategias de manejo de errores:

1. **Verificación de existencia de rutas**:

   ```powershell
   if (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*") {
       $uninstallKeys += "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
   }
   ```

   Esto evita errores al intentar acceder a rutas que podrían no existir en algunos sistemas.

2. **Bloque try-catch para aplicaciones modernas**:

   ```powershell
   try {
       # Código para obtener aplicaciones modernas
   } catch {
       Write-Host "No se pudieron obtener aplicaciones modernas de Windows" -ForegroundColor Red
       $aplicacionesModernas = @()
   }
   ```

   Esto permite que el script continúe incluso si falla la obtención de aplicaciones modernas (por ejemplo, en versiones anteriores de Windows).

3. **Filtrado de datos nulos**:
   ```powershell
   Where-Object { $_.DisplayName -ne $null }
   ```
   Evita errores al procesar entradas incompletas en el registro.

### Problemas Comunes y Soluciones:

1. **Error de política de ejecución**:

   - **Síntoma**: El mensaje "No se puede cargar el archivo porque la ejecución de scripts está deshabilitada en este sistema"
   - **Solución**: Ejecutar `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process` antes de ejecutar el script

2. **Permisos insuficientes**:

   - **Síntoma**: Resultados incompletos o errores de acceso denegado
   - **Solución**: Ejecutar PowerShell como administrador

3. **Error al obtener aplicaciones modernas**:

   - **Síntoma**: Mensaje "No se pudieron obtener aplicaciones modernas de Windows"
   - **Solución**: El script manejará este error y continuará con las aplicaciones tradicionales; no requiere acción del usuario

4. **Archivo de salida inaccesible**:
   - **Síntoma**: Error "No se puede acceder a la ruta de acceso"
   - **Solución**: Modificar la variable `$outputFile` para usar una ubicación diferente

## 9. Dependencias y Requisitos

### Requisitos del Sistema

- **Sistema operativo**: Windows 7, Windows 8, Windows 10 o Windows 11
- **PowerShell**: Versión 3.0 o superior
  - Verificar versión con: `$PSVersionTable.PSVersion`

### Módulos de PowerShell

- No se requieren módulos adicionales; el script utiliza solo cmdlets integrados en PowerShell:
  - `Get-ItemProperty`: Para consultar el registro
  - `Get-AppxPackage`: Para aplicaciones modernas (disponible en Windows 8 y posteriores)
  - `Out-File`: Para guardar resultados en archivo de texto

### Consideraciones de Compatibilidad

- La funcionalidad para obtener aplicaciones modernas (`Get-AppxPackage`) solo está disponible en Windows 8 y versiones posteriores
- En Windows 7, el script funcionará correctamente pero solo mostrará aplicaciones tradicionales

## 10. Notas sobre Rendimiento y Optimización

### Optimizaciones Implementadas

1. **Consulta Selectiva del Registro**:

   - Se consultan solo las rutas específicas donde se almacena la información de desinstalación
   - Se filtran inmediatamente los resultados para procesar solo entradas relevantes

2. **Minimización de Procesamiento de Datos**:

   - Se seleccionan solo las propiedades necesarias (`Select-Object`) para reducir el consumo de memoria

3. **Manejo Eficiente de Errores**:
   - Los bloques try-catch evitan que el script se detenga ante fallos no críticos

### Consideraciones de Rendimiento

1. **Tiempo de Ejecución**:

   - El script generalmente se ejecuta en segundos, pero puede tardar más en sistemas con muchas aplicaciones instaladas
   - El componente más lento suele ser la consulta `Get-AppxPackage` en sistemas con muchas aplicaciones modernas

2. **Consumo de Recursos**:

   - Memoria: Bajo a moderado, dependiendo del número de aplicaciones
   - CPU: Uso breve durante las consultas de registro y formato de datos
   - Disco: Mínimo, solo para escribir el archivo de salida

3. **Posibles Mejoras Futuras**:
   - Implementar procesamiento paralelo para consultas de diferentes fuentes
   - Agregar opciones de filtrado para reducir el conjunto de datos
   - Crear una función reutilizable en lugar de un script monolítico

## 11. Comentarios dentro del Código

A continuación se describen los comentarios principales en el código y su propósito:

```powershell
# Script para obtener todas las aplicaciones instaladas en el sistema
# El resultado se mostrará en pantalla y se guardará en un archivo de texto
```

- **Propósito**: Introducción general al script para entender su función principal

```powershell
# Definir la ruta donde se guardará el archivo
```

- **Propósito**: Explica el propósito de la variable `$outputFile`

```powershell
# Obtener la fecha y hora actuales para incluirlas en el reporte
```

- **Propósito**: Explica por qué se está capturando la fecha y hora

```powershell
# Crear el encabezado del informe
```

- **Propósito**: Indica el inicio de la sección que genera el formato del encabezado

```powershell
# 1. Obtener desde el registro (Programas instalados para la máquina)
```

- **Propósito**: Indica el inicio de la primera fuente de datos (registro sistema)

```powershell
# 2. Incluir aplicaciones instaladas para el usuario actual
```

- **Propósito**: Indica la segunda fuente de datos (registro usuario)

```powershell
# 3. Obtener aplicaciones modernas de Windows (si estamos en Windows 10/11)
```

- **Propósito**: Indica la tercera fuente de datos (aplicaciones modernas)

Estos comentarios facilitan la comprensión de las diferentes secciones del código y su propósito, ayudando tanto a nuevos usuarios como a desarrolladores que necesiten modificar o mantener el script en el futuro.
