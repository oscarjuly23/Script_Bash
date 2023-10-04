# Script_Bash
Script básico en Bash [2017]

## Descripción:
El repositorio alberga un script en Bash para la administración de usuarios en sistemas Unix/Linux. Este script permitirá automatizar el proceso de dar de alta a usuarios en un sistema, siguiendo un conjunto de reglas y estructuras de directorios definidas.

## Funcionalidades Destacadas:

- Alta de Usuarios: Utilizando un fichero de texto con datos en un formato específico (Nombre usuario; Apellidos; departamento; num extensión; fecha de nacimiento; DNI), el script creará nuevos usuarios en el sistema. Cada usuario tendrá un nombre de usuario único (nombre_apellido1) y se asignará al grupo correspondiente según su departamento.

- Contraseña Inicial: Se asignará como contraseña inicial el número de DNI de cada usuario, garantizando una contraseña temporal segura.

- Estructura de Directorios: El script organizará automáticamente a los usuarios en tres departamentos distintos, creando una estructura de directorios en el directorio "home" de cada usuario de acuerdo con su departamento.

- Credenciales de Acceso: Para cada usuario, se generará un documento de texto que contendrá sus credenciales de acceso (nombre de usuario y contraseña temporal).

- Listados Organizados: Se generará un documento de texto organizado por departamento y ordenado por apellido1, apellido2 y nombre, que mostrará información detallada de los usuarios, incluyendo departamento, apellidos, nombre, nombre de usuario y DNI.

- Listado de Extensiones: Además, el sistema creará un listado de extensiones telefónicas de los usuarios, mostrando apellidos, nombre, extensión y departamento.

- Este repositorio es una herramienta esencial para simplificar y agilizar el proceso de alta de usuarios en sistemas Unix/Linux, brindando automatización y organización a la administración de cuentas de usuario.

## 
Esta descripción resalta las características clave de tu repositorio y cómo el script en Bash puede ser útil para la administración de usuarios en sistemas Unix/Linux. No dudes en adaptarla según tus preferencias y subirla a tu repositorio en GitHub.





