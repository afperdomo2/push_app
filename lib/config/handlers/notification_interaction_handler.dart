import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/config/helpers/message_utils.dart';
import 'package:push_app/config/router/app_router.dart';
import 'package:push_app/features/home/blocs/notifications/notifications_bloc.dart';
import 'package:push_app/features/home/screens/notification_details_screen.dart';

/// Handler para manejar las interacciones con notificaciones push
///
/// Este widget se encarga de configurar los listeners para detectar cuando
/// el usuario interactúa con una notificación push, ya sea desde un estado
/// terminado o desde segundo plano de la aplicación.
class NotificationInteractionHandler extends StatefulWidget {
  final Widget child;

  const NotificationInteractionHandler({
    super.key,
    required this.child,
  });

  @override
  State<NotificationInteractionHandler> createState() => _NotificationInteractionHandlerState();
}

class _NotificationInteractionHandlerState extends State<NotificationInteractionHandler> {
  /// Configura el manejo de mensajes que causan interacción con la app
  Future<void> setupInteractedMessage() async {
    // Obtener cualquier mensaje que haya causado que la aplicación se abriera desde
    // un estado terminado.
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    // Si hay un mensaje inicial, manejarlo
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // También manejar cualquier interacción cuando la aplicación está en segundo plano
    // a través de un listener de Stream
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  /// Maneja el mensaje de notificación y navega a la pantalla de detalles
  void _handleMessage(RemoteMessage message) {
    // Agregar el mensaje al Bloc de notificaciones
    context.read<NotificationsBloc>().handleRemoteMessage(message);

    // Generar un ID limpio para la navegación
    final messageId = MessageUtils.cleanMessageId(message.messageId);

    // Navegar a la pantalla de detalles de la notificación
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
