import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/config/helpers/message_utils.dart';
import 'package:push_app/config/router/app_router.dart';
import 'package:push_app/config/theme/app_theme.dart';
import 'package:push_app/features/home/blocs/notifications/notifications_bloc.dart';
import 'package:push_app/features/home/screens/notification_details_screen.dart';
import 'package:push_app/firebase_options.dart';

/// Este manejador se ejecuta cuando la aplicación está en segundo plano o cerrada
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Si vas a utilizar otros servicios de Firebase en segundo plano, como Firestore,
  // asegúrate de llamar a `initializeApp` antes de usar otros servicios de Firebase.
  await Firebase.initializeApp();

  // ignore: avoid_print
  print('Manejando un mensaje en segundo plano: ${MessageUtils.cleanMessageId(message.messageId)}');
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
      builder: (context, child) => NotificationInteractionHandler(child: child!),
    );
  }
}

class NotificationInteractionHandler extends StatefulWidget {
  final Widget child;
  const NotificationInteractionHandler({super.key, required this.child});

  @override
  State<NotificationInteractionHandler> createState() => _NotificationInteractionHandlerState();
}

class _NotificationInteractionHandlerState extends State<NotificationInteractionHandler> {
  // Se asume que todos los mensajes contienen un campo de datos con la clave 'type'
  Future<void> setupInteractedMessage() async {
    // Obtener cualquier mensaje que haya causado que la aplicación se abriera desde
    // un estado terminado.
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    // Si el mensaje también contiene una propiedad de datos con un "type" de "chat",
    // navegar a una pantalla de chat
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // También manejar cualquier interacción cuando la aplicación está en segundo plano
    // a través de un listener de Stream
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    // Agregar el mensaje al Bloc de notificaciones
    context.read<NotificationsBloc>().handleRemoteMessage(message);

    // Navegar a la pantalla de detalles de la notificación
    final messageId = MessageUtils.cleanMessageId(message.messageId);
    appRouter.pushNamed(
      NotificationDetailsScreen.routeName,
      pathParameters: {'messageId': messageId},
    );
  }

  @override
  void initState() {
    super.initState();

    // Ejecutar código requerido para manejar mensajes interactuados en una función asíncrona
    // ya que initState() no debe ser asíncrono
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
