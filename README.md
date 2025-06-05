# push_app

## 📩 1. Firebase Messaging

Firebase Cloud Messaging (FCM) es un servicio de Google que permite enviar notificaciones push de forma confiable y eficiente a dispositivos móviles y aplicaciones web.

[![Introducción a Firebase Cloud Messaging](https://img.youtube.com/vi/sioEY4tWmLI/0.jpg)](https://www.youtube.com/watch?v=sioEY4tWmLI)

- Conoce Firebase para Flutter:
<https://firebase.flutter.dev/docs/overview>

- Firebase Cloud Messaging:
<https://firebase.flutter.dev/docs/messaging/overview>

## 🔧 2. Firebase CLI

Firebase Command Line Interface (CLI) es una herramienta que proporciona comandos para administrar y desplegar aplicaciones y recursos de Firebase desde la línea de comandos.

### 2.1 Instalación

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

### 2.2 Configurar Firebase en el proyecto de Flutter

- ☢️Ubicarse en la carpeta del proyecto
- ☢️Se puede crear un proyecto de Firebase o también tener uno ya listo y solo usarlo

```sh
# Instala la CLI si aún no lo has hecho
dart pub global activate flutterfire_cli

# Ejecuta el comando `configure`, selecciona un proyecto de Firebase y las plataformas (Ej: android, ios, etc)
dart pub global run flutterfire_cli:flutterfire configure
```

## 🔔 3. Notificaciones push3. Notificaciones push

Las notificaciones push son mensajes que se envían desde un servidor a dispositivos específicos, permitiendo interactuar con usuarios incluso cuando la aplicación no está abierta.

Plataformas para enviar notificaciones push:

- **Firebase Cloud Messaging (FCM):** Solución gratuita de Google. Permite enviar notificaciones a Android, iOS y web. Ofrece consola visual para envíos manuales o API para automatización

- **OneSignal:** Plataforma especializada en notificaciones
Interfaz amigable y potentes analíticas
Plan gratuito con límites y planes pagos

- **Amazon SNS:** Servicio de AWS para notificaciones. Escalable para aplicaciones grandes. Integración con otros servicios de AWS

- **Pusher:** Plataforma de comunicación en tiempo real. Buena para aplicaciones que requieren interacción inmediata. Para implementar notificaciones push en Flutter, necesitarás:

### 🔥 3.1 Firebase Console

Para enviar notificaciones push a dispositivos Android desde Firebase Console:

1. **Accede a Firebase Console**: Ve a <https://console.firebase.google.com/> e inicia sesión

2. **Selecciona tu proyecto**: Haz clic en el proyecto donde tienes configurada tu app Flutter

3. **Navega a Cloud Messaging**: Selecciona el menú de `Ejecución > Messaging`

4. **Crea una notificación**:

- Haz clic en `Crear tu primera campaña`
- Selecciona `Mensajes de Firebase Notifications` como tipo de campaña

5. **Configura la notificación**:

- Llenar los datos del formulario
- En destinararios, elige "App" para enviar a toda la app. O usa segmentación por temas o tokens específicos
- Configura cuándo enviar la notificación
- Revisa los detalles y haz clic en "Publicar"
- Monitorea los informes de entrega en la sección "Reporting"

## ⛑️ 4. Ayuda

### 🗺️ 4.1 Guías

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

### ⌨️ 4.2 Comandos útiles

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
