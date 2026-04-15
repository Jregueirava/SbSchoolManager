# SbSchoolManager

Sistema de gestión para una escuela de skate, compuesto por una **API REST** desarrollada con Spring Boot y una **aplicación multiplataforma** desarrollada con Flutter.

***

## Tabla de contenidos

- [Requisitos previos](#requisitos-previos)
- [Estructura del proyecto](#estructura-del-proyecto)
- [Clonar el repositorio](#clonar-el-repositorio)
- [Configurar variables de entorno](#configurar-variables-de-entorno)
- [Configurar y levantar la base de datos con Docker](#configurar-y-levantar-la-base-de-datos-con-docker)
- [Configurar el backend (Spring Boot)](#configurar-el-backend-spring-boot)
- [Ejecutar el backend](#ejecutar-el-backend)
- [Configurar y ejecutar el frontend (Flutter)](#configurar-y-ejecutar-el-frontend-flutter)
- [Endpoints disponibles](#endpoints-disponibles)
- [Tecnologías utilizadas](#tecnologías-utilizadas)

***

## Requisitos previos

Antes de comenzar, asegúrate de tener instalado en tu máquina:

| Herramienta | Versión recomendada 
|---|---
| **Java JDK** | 25 
| **Maven** | 3.9+ 
| **Docker Desktop** | Última estable 
| **Flutter SDK** | 3.x 
| **Git** | Última estable
| **IntelliJ IDEA** | Última estable 
| **Android Studio** | Última estable 

> **Nota:** Docker Desktop debe estar ejecutándose antes de levantar la base de datos.

***

## Estructura del proyecto
### Actualmente
```
SbSchoolManager/
├── sbschoolmanager-api/        ← Backend Spring Boot
│   ├── src/
│   │   └── main/
│   │       ├── java/com/sbschoolmanager/
│   │       │   ├── controller/
│   │       │   ├── service/
│   │       │   ├── repository/
│   │       │   └── model/
│   │       └── resources/
│   │           ├── application.properties
│   │           └── application-local.properties   ← NO incluido en el repo
│   ├── docker-compose.yml                         ← NO incluido en el repo
│   ├── docker-compose.example.yml                 ← Plantilla de referencia
│   └── pom.xml
└── sbschoolmanager-app/        ← Frontend Flutter
    ├── lib/
    └── pubspec.yaml
```

***

## Clonar el repositorio

Abre una terminal y ejecuta:

```bash
git clone https://github.com/tu-usuario/SbSchoolManager.git
cd SbSchoolManager
```

> Sustituye `tu-usuario` por tu nombre de usuario real de GitHub.

***

## Configurar variables de entorno

Los archivos con credenciales **no están incluidos en el repositorio** por seguridad. Debes crearlos manualmente siguiendo los pasos a continuación.

### Archivos que debes crear tú (no están en el repo)

```
sbschoolmanager-api/docker-compose.yml
sbschoolmanager-api/src/main/resources/application-local.properties
```

> Estos archivos están listados en el `.gitignore` del proyecto para que nunca se suban accidentalmente.

***

## Configurar y levantar la base de datos con Docker

### Paso 1 — Crear el archivo `docker-compose.yml`

Dentro de la carpeta `sbschoolmanager-api/`, crea un archivo llamado `docker-compose.yml`.

Puedes usar el archivo de plantilla `docker-compose.example.yml` incluido en el repositorio como referencia:

```bash
cp docker-compose.example.yml docker-compose.yml
```

A continuación, edita `docker-compose.yml` con tus propios valores de configuración (nombre de base de datos, usuario y contraseña).

### Paso 2 — Levantar el contenedor

Desde la carpeta `sbschoolmanager-api/`, ejecuta:

```bash
docker compose up -d
```

El flag `-d` lo ejecuta en segundo plano. Para comprobar que el contenedor está activo:

```bash
docker ps
```

Deberías ver el contenedor de la base de datos con estado `Up`.

### Paso 3 — Detener el contenedor (cuando termines)

```bash
docker compose down
```

> **Importante:** Los datos persisten gracias al volumen de Docker. Al volver a ejecutar `docker compose up -d`, la base de datos conservará todos los registros anteriores.

***

## Configurar el backend (Spring Boot)

### Paso 1 — Crear `application-local.properties`

El proyecto usa un perfil `local` para el entorno de desarrollo. Crea el archivo en:

```
sbschoolmanager-api/src/main/resources/application-local.properties
```

El contenido debe coincidir con los valores que hayas definido en tu `docker-compose.yml`:

```properties
spring.datasource.url=jdbc:mysql://localhost:PUERTO/NOMBRE_BASE_DE_DATOS
spring.datasource.username=TU_USUARIO
spring.datasource.password=TU_CONTRASEÑA
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

> Sustituye `PUERTO`, `NOMBRE_BASE_DE_DATOS`, `TU_USUARIO` y `TU_CONTRASEÑA` por los valores reales de tu entorno.

### Paso 2 — Revisar `application.properties`

El archivo principal ya está incluido en el repositorio y activa el perfil `local` automáticamente:

```properties
spring.application.name=sbschoolmanager-api
spring.profiles.active=local
```

***

## Ejecutar el backend

### — Desde IntelliJ IDEA

1. Abre IntelliJ IDEA y selecciona **File → Open** → carpeta `sbschoolmanager-api/`
2. Espera a que Maven descargue todas las dependencias
3. Localiza la clase principal `SbschoolmanagerApiApplication.java`
4. Haz clic en el botón **Run** (o pulsa `Shift + F10`)

### Verificar que arrancó correctamente

En los logs deberías ver:

```
Started SbschoolmanagerApiApplication in X.XXX seconds
Tomcat started on port 8080
```

La API estará disponible en: **`http://localhost:8080`**

> **Nota:** La base de datos Docker debe estar levantada **antes** de arrancar Spring Boot, de lo contrario obtendrás un error de conexión `Communications link failure`.

***

## Configurar y ejecutar el frontend (Flutter)

### Proximamente

***

## Endpoints disponibles

Una vez arrancado el backend, puedes probar los endpoints desde **Postman** o el navegador:

| Entidad | Base URL | Métodos |
|---|---|---|
| Alumnos | `http://localhost:8080/api/alumnos` | GET, POST, PUT, DELETE |
| Profesores | `http://localhost:8080/api/profesores` | GET, POST, PUT, DELETE |
| Clases de skate | `http://localhost:8080/api/clases` | GET, POST, PUT, DELETE |
| Grupos | `http://localhost:8080/api/grupos` | GET, POST, PUT, DELETE |
| Horarios | `http://localhost:8080/api/horarios` | GET, POST, PUT, DELETE |
| Materiales | `http://localhost:8080/api/materiales` | GET, POST, PUT, DELETE |
| Alquilar | `http://localhost:8080/api/alquilar` | POST, DELETE |
| Contratar | `http://localhost:8080/api/contratar` | POST, DELETE |

### Endpoints de búsqueda adicionales

```
GET /api/clases/profesor/{codProfesor}
GET /api/grupos/alumno/{codAlumno}
GET /api/horarios/clase/{codClase}
GET /api/materiales/alumno/{codAlumno}
```

***

## Tecnologías utilizadas

### Backend
- **Java 25**
- **Spring Boot 4.x** — framework principal
- **Spring Data JPA + Hibernate** — capa de persistencia
- **MySQL 8** — base de datos relacional
- **Docker + Docker Compose** — contenerización de la base de datos
- **HikariCP** — pool de conexiones
- **Maven** — gestión de dependencias

### Frontend
- **Flutter SDK 3.x**
- **Dart**
- **Paquete `http`** — comunicación con la API REST

***

## Autor

Desarrollado por **JESÚS REGUEIRA VÁZQUEZ** como proyecto final del ciclo de Desarrollo de Aplicaciones Multiplataforma (DAM).
