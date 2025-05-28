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
        title: Text(notificationsState.status.toString()),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              notificationsBloc.requestPermission();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Requesting notification permission...'),
                ),
              );
            },
          ),
        ],
      ),
      body: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (_, index) {
        return ListTile(
          title: Text('Item $index'),
          subtitle: Text('Subtitle $index'),
          leading: const Icon(Icons.list),
          trailing: const Icon(Icons.arrow_forward),
        );
      },
    );
  }
}
