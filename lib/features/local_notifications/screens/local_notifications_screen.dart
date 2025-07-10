import 'package:flutter/material.dart';
import 'package:push_app/features/local_notifications/widgets/local_notification_demo.dart';

/// Pantalla dedicada para las notificaciones locales
///
/// Esta pantalla contiene todas las funcionalidades relacionadas con
/// las notificaciones locales, separada del home para una mejor organización
class LocalNotificationsScreen extends StatelessWidget {
  static const String routeName = 'local-notifications';

  const LocalNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Información introductoria
          _MessageCardDetails(),

          // Widget de demostración de notificaciones locales
          LocalNotificationDemo(),
        ],
      ),
    );
  }
}

class _MessageCardDetails extends StatelessWidget {
  const _MessageCardDetails();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notificaciones Locales',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Aquí puedes gestionar y probar las notificaciones locales '
              'de la aplicación. Estas notificaciones se generan desde '
              'el dispositivo y no requieren conexión a internet.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
