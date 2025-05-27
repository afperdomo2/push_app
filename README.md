# push_app

## 📩 Firebase Messaging

Firebase Cloud Messaging (FCM) es un servicio de Google que permite enviar notificaciones push de forma confiable y eficiente a dispositivos móviles y aplicaciones web.

[![Introducción a Firebase Cloud Messaging](https://img.youtube.com/vi/sioEY4tWmLI/0.jpg)](https://www.youtube.com/watch?v=sioEY4tWmLI)

- Conoce Firebase para Flutter:
<https://firebase.flutter.dev/docs/overview>

- Firebase Cloud Messaging:
<https://firebase.flutter.dev/docs/messaging/overview>

## 🔧 Firebase CLI

Firebase Command Line Interface (CLI) es una herramienta que proporciona comandos para administrar y desplegar aplicaciones y recursos de Firebase desde la línea de comandos.

### Instalación

Documentación: <https://firebase.google.com/docs/cli?hl=es-419>

```bash
# Instalar con node
npm install -g firebase-tools

# Iniciar sesión en Firebase
firebase login

# Inicializar Firebase en tu proyecto
firebase init

# Listar tus proyectos de Firebase
firebase projects:list

# Desplegar tu aplicación
firebase deploy
```

### Configurar Firebase en proyecto de Flutter

- ☢️Ubicarse en la carpeta del proyecto
- ☢️Se puede crear un proyecto de Firebase o también tener uno ya listo y solo usarlo

```sh
# Instala la CLI si aún no lo has hecho
dart pub global activate flutterfire_cli

# Ejecuta el comando `configure`, selecciona un proyecto de Firebase y las plataformas
dart pub global run flutterfire_cli:flutterfire configure
```

## ⛑️ Ayuda

### 🗺️ Guías

**Comillas simples en vez de dobles:**

Abrir el archivo de `analysis_options.yaml` y establecer la siguiente configuración:

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    prefer_single_quotes: true # Aquí se habilita
```

Para aplicar y verificar:

```bash
# Analizar el código y ver los problemas encontrados por el linter
flutter analyze

# Corregir automáticamente las correcciones sugeridas (ej: Comillas simples por dobles)
dart fix --apply
```

### ⌨️ Comandos útiles

```bash
# Instalar los paquetes o dependencias
flutter pub get

# Compilar y ejecutar la aplicación en un dispositivo conectado o emulador
flutter run
```

```bash
# Limpiar temporales
flutter clean

# Ejecutar el doctor para validar si todo está correcto
flutter doctor
```
