import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/config/router/app_router.dart';
import 'package:push_app/config/theme/app_theme.dart';
import 'package:push_app/features/home/blocs/notifications/notifications_bloc.dart';
import 'package:push_app/firebase_options.dart';

/// Este manejador se ejecuta cuando la aplicación está en segundo plano o cerrada
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Si vas a utilizar otros servicios de Firebase en segundo plano, como Firestore,
  // asegúrate de llamar a `initializeApp` antes de usar otros servicios de Firebase.
  await Firebase.initializeApp();

  // ignore: avoid_print
  print('Manejando un mensaje en segundo plano: ${message.messageId}');
}

void main() async {
  /// Inicializa el binding de Flutter y Firebase antes de ejecutar la aplicación.
  ///
  /// [WidgetsFlutterBinding.ensureInitialized] se llama para establecer el binding
  /// entre el framework de Flutter y la plataforma host. Esto debe llamarse antes
  /// de utilizar cualquier canal de plataforma.
  ///
  /// [Firebase.initializeApp] inicializa el SDK de Firebase con las opciones
  /// específicas de la plataforma apropiadas, permitiendo que la aplicación use
  /// servicios de Firebase como autenticación, Firestore, analytics, etc.
  ///
  /// Esta inicialización debe completarse antes de que la aplicación inicie, de ahí el uso de 'await'.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Configurar Firebase Messaging para manejar mensajes en segundo plano
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NotificationsBloc()),
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
    );
  }
}
