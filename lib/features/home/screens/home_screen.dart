import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:push_app/domain/entities/push_message.dart';
import 'package:push_app/features/home/blocs/notifications/notifications_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationsState = context.watch<NotificationsBloc>().state;
    final notificationsBloc = context.read<NotificationsBloc>();

    final notificationList = notificationsState.notificationList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),

      // Body
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status card with color based on permission status
            _NotificationsStatus(notificationsState: notificationsState),

            const SizedBox(height: 24),

            _NotificationRequestButton(notificationsBloc: notificationsBloc),

            const SizedBox(height: 24),

            // List of notifications
            _NotificationListView(notificationList: notificationList),
          ],
        ),
      ),
    );
  }
}

class _NotificationListView extends StatelessWidget {
  const _NotificationListView({
    required this.notificationList,
  });

  final List<PushMessage> notificationList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (notificationList.isEmpty)
            const Text(
              'No notifications received yet.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            )
          else
            const Text(
              'Received Notifications:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: notificationList.length,
              itemBuilder: (context, index) {
                final notification = notificationList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(notification.title),
                    subtitle: Text(notification.body),
                    leading: notification.imageUrl != null && notification.imageUrl!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              notification.imageUrl!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, _, __) => const Icon(Icons.notifications),
                            ),
                          )
                        : const Icon(Icons.notifications),
                    trailing: const Icon(Icons.arrow_forward_ios),

                    // Navegar a la pantalla de detalles de la notificación
                    onTap: () => context.push('/notification/${notification.id}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationsStatus extends StatelessWidget {
  const _NotificationsStatus({
    required this.notificationsState,
  });

  final NotificationsState notificationsState;

  @override
  Widget build(BuildContext context) {
    final statusName = notificationsState.status.name;

    return Card(
      color: statusName == 'authorized'
          ? Colors.green.shade100
          : statusName == 'denied'
              ? Colors.red.shade100
              : Colors.orange.shade100,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  statusName == 'authorized'
                      ? Icons.notifications_active
                      : statusName == 'denied'
                          ? Icons.notifications_off
                          : Icons.notifications_none,
                  size: 28,
                  color: statusName == 'authorized'
                      ? Colors.green
                      : statusName == 'denied'
                          ? Colors.red
                          : Colors.orange,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Notification Status',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              statusName.toUpperCase(),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: statusName == 'authorized'
                    ? Colors.green
                    : statusName == 'denied'
                        ? Colors.red
                        : Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationRequestButton extends StatelessWidget {
  const _NotificationRequestButton({
    required this.notificationsBloc,
  });

  final NotificationsBloc notificationsBloc;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        notificationsBloc.requestPermission();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Requesting notification permission...')),
        );
      },
      icon: const Icon(Icons.notifications_active),
      label: const Text('Enable Notifications'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      ),
    );
  }
}
