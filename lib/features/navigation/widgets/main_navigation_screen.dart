import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Widget principal con navegación inferior
///
/// Este widget maneja la navegación entre las diferentes pestañas
/// de la aplicación usando un BottomNavigationBar
class MainNavigationScreen extends StatefulWidget {
  /// El widget hijo que se mostrará en el cuerpo
  final Widget child;

  /// El índice actual de la pestaña seleccionada
  final int currentIndex;

  const MainNavigationScreen({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        // Navegar a Home
        context.go('/');
        break;
      case 1:
        // Navegar a Notificaciones Locales
        context.go('/local-notifications');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determinar el título del AppBar basado en el índice actual
    String appBarTitle = 'Home Screen';
    if (widget.currentIndex == 1) {
      appBarTitle = 'Notificaciones Locales';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        backgroundColor:
            widget.currentIndex == 1 ? Theme.of(context).colorScheme.primaryContainer : null,
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home),
            label: 'Home',
            tooltip: 'Pantalla principal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications),
            label: 'Notificaciones',
            tooltip: 'Notificaciones locales',
          ),
        ],
      ),
    );
  }
}
