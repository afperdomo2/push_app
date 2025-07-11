import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/config/handlers/firebase_messaging_handler.dart';
import 'package:push_app/config/handlers/notification_interaction_handler.dart';
import 'package:push_app/config/router/app_router.dart';
import 'package:push_app/config/services/local_notifications_service.dart';
import 'package:push_app/config/theme/app_theme.dart';
import 'package:push_app/features/home/blocs/notifications/notifications_bloc.dart';
import 'package:push_app/firebase_options.dart';

void main() async {
  /// Prepara la aplicación para su ejecución:
  /// 1. Inicializa el binding de Flutter (conecta framework con plataforma)
  /// 2. Configura Firebase con las opciones predeterminadas de la plataforma actual
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// 3. Configurar Firebase Messaging para manejar mensajes en segundo plano
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  /// 4. Inicializar el servicio de notificaciones locales
  await LocalNotificationsService.initialize();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NotificationsBloc(
            showLocalNotification: LocalNotificationsService.showNotification,
          ),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,

      /// 5. Configurar el manejador de interacciones con notificaciones push
      builder: (context, child) => NotificationInteractionHandler(child: child!),
    );
  }
}
