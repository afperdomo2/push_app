import 'package:flutter/material.dart';
import 'package:push_app/config/services/local_notifications_service.dart';

/// Widget de demostración para probar las notificaciones locales
///
/// Este widget proporciona botones para probar diferentes tipos de notificaciones
/// y sirve como ejemplo de cómo usar el LocalNotificationsService
class LocalNotificationDemo extends StatefulWidget {
  const LocalNotificationDemo({super.key});

  @override
  State<LocalNotificationDemo> createState() => _LocalNotificationDemoState();
}

class _LocalNotificationDemoState extends State<LocalNotificationDemo> {
  int _notificationId = 1;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🔔 Prueba de Notificaciones Locales',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            // Notificación simple
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _showSimpleNotification,
                icon: const Icon(Icons.notifications),
                label: const Text('Notificación Simple'),
              ),
            ),
            const SizedBox(height: 12),

            // Notificación expandida
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _showExpandedNotification,
                icon: const Icon(Icons.expand_more),
                label: const Text('Notificación Expandida'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Notificación con acciones
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _showNotificationWithActions,
                icon: const Icon(Icons.touch_app),
                label: const Text('Notificación con Acciones'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Cancelar todas las notificaciones
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _cancelAllNotifications,
                icon: const Icon(Icons.cancel),
                label: const Text('Cancelar Todas'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Información adicional
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '💡 Información:',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• Las notificaciones aparecerán aunque la app esté en segundo plano\n'
                    '• Puedes interactuar con las notificaciones desde la bandeja\n'
                    '• Los logs aparecen en la consola cuando interactúas con ellas',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Muestra una notificación simple
  void _showSimpleNotification() {
    LocalNotificationsService.showNotification(
      id: _notificationId++,
      title: '¡Hola! 👋',
      body: 'Esta es una notificación simple de prueba.',
      payload: 'simple_notification_${DateTime.now().millisecondsSinceEpoch}',
    );

    _showSnackBar('Notificación simple enviada');
  }

  /// Muestra una notificación expandida
  void _showExpandedNotification() {
    LocalNotificationsService.showExpandedNotification(
      id: _notificationId++,
      title: '📄 Notificación Expandida',
      body: 'Toca para expandir...',
      expandedBody: 'Este es el texto expandido de la notificación. '
          'Aquí puedes ver mucho más contenido cuando expandas la notificación. '
          'Es útil para mostrar detalles adicionales o información más completa '
          'que no cabe en una notificación normal.',
      payload: 'expanded_notification_${DateTime.now().millisecondsSinceEpoch}',
    );

    _showSnackBar('Notificación expandida enviada');
  }

  /// Muestra una notificación con botones de acción
  void _showNotificationWithActions() {
    LocalNotificationsService.showNotificationWithActions(
      id: _notificationId++,
      title: '⚡ Acción Requerida',
      body: '¿Deseas continuar con esta acción?',
      payload: 'action_notification_${DateTime.now().millisecondsSinceEpoch}',
    );

    _showSnackBar('Notificación con acciones enviada');
  }

  /// Cancela todas las notificaciones
  void _cancelAllNotifications() {
    LocalNotificationsService.cancelAllNotifications();
    _showSnackBar('Todas las notificaciones canceladas');
  }

  /// Muestra un SnackBar con un mensaje
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
