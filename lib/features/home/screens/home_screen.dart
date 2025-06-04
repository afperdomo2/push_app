import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/features/home/blocs/notifications/notifications_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationsState = context.watch<NotificationsBloc>().state;
    final notificationsBloc = context.read<NotificationsBloc>();

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
          ],
        ),
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
