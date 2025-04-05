# AppInventoryPS

## Inventario Completo de Aplicaciones Instaladas en Windows

![PowerShell Version](https://img.shields.io/badge/PowerShell-v3.0+-blue.svg)
![Platform](https://img.shields.io/badge/platform-Windows-brightgreen.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

**AppInventoryPS** es una herramienta de inventario de software escrita en PowerShell que genera informes detallados de todas las aplicaciones instaladas en sistemas Windows, facilitando la documentación, auditoría y gestión de activos de TI.

## 🚀 Características

- **Inventario Exhaustivo**: Detecta aplicaciones tradicionales y modernas (UWP/Store) desde múltiples fuentes
- **Sin Dependencias**: No requiere módulos adicionales ni software de terceros
- **Formato Dual**: Presenta resultados tanto en consola como en archivo de texto
- **Interfaz Amigable**: Proporciona información clara con códigos de color y formateo estructurado
- **Gestión de Errores**: Maneja fallos comunes sin interrumpir la ejecución
- **Compatible**: Funciona en Windows 7, 8, 10 y 11

## 📋 Información Recopilada

Para cada aplicación instalada, el script registra:

- Nombre completo del programa/aplicación
- Número de versión
- Editor/Fabricante
- Fecha de instalación (cuando está disponible)

## 📥 Instalación

No se requiere instalación. Simplemente:

1. Descargue el archivo `AppInventoryPS.ps1`
2. Opcionalmente, verifique la firma digital o los hashes si se proporcionan
3. Ejecute el script como se describe en la sección de uso

## 🔧 Uso

### Método Básico

1. Abra PowerShell como administrador (recomendado para resultados más completos)
2. Navegue al directorio donde guardó el script
3. Ejecute:

```powershell
.\AppInventoryPS.ps1
```

### Ejecución con Política Restringida

Si la política de ejecución de PowerShell lo impide:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
.\AppInventoryPS.ps1
```

### Uso Avanzado

Para personalizar la ubicación del archivo de salida, modifique esta línea en el script:

```powershell
$outputFile = "$env:USERPROFILE\Desktop\AplicacionesInstaladas.txt"
```

## 📊 Ejemplo de Salida

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

## ⚠️ Requisitos

- Sistema operativo Windows (7, 8, 10 o 11)
- PowerShell 3.0 o superior
- Permisos de administrador (recomendado pero no obligatorio)

## 🔍 Cómo Funciona

El script consulta múltiples fuentes de información:

1. **Registro de Windows (HKLM)**: Para aplicaciones instaladas a nivel de sistema
2. **Registro de Usuario (HKCU)**: Para aplicaciones instaladas para el usuario actual
3. **API de AppX**: Para aplicaciones modernas de Windows (UWP/Store)

Luego combina, filtra y formatea estos datos para proporcionar un inventario completo y legible.

## 🛠️ Solución de Problemas

### Resultados Incompletos

Si no obtiene todas las aplicaciones esperadas:

- Asegúrese de ejecutar como administrador
- Verifique que está utilizando una versión reciente de PowerShell

### El Script Falla al Ejecutar

Si encuentra errores de ejecución:

- Verifique la política de ejecución con `Get-ExecutionPolicy`
- Intente usar `Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process`

### Aplicaciones Modernas No Detectadas

En Windows 7 o sistemas antiguos:

- Este es un comportamiento esperado, ya que `Get-AppxPackage` no está disponible

## 📄 Licencia

Este proyecto está licenciado bajo la [Licencia MIT](LICENSE).

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Siéntase libre de:

1. Bifurcar el repositorio
2. Crear una rama (`git checkout -b feature/amazing-improvement`)
3. Hacer sus cambios
4. Confirmar cambios (`git commit -m 'Add amazing improvement'`)
5. Empujar a la rama (`git push origin feature/amazing-improvement`)
6. Abrir un Pull Request

## 📌 Notas de Versión

### v1.0.0 (Inicial)

- Lanzamiento inicial con funcionalidad básica
- Soporte para Windows 7-11
- Generación de informes en consola y texto

---

_Este proyecto no está afiliado con Microsoft. Windows es una marca registrada de Microsoft Corporation._
