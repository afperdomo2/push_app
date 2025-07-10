import 'package:flutter/material.dart';
import 'package:push_app/config/services/local_notifications_service.dart';

/// Handler para inicializar las notificaciones locales al inicio de la aplicación
///
/// Este widget se encarga de:
/// - Inicializar el servicio de notificaciones locales
/// - Mostrar un indicador de carga mientras se inicializa
/// - Manejar errores durante la inicialización
class LocalNotificationsInitializer extends StatefulWidget {
  final Widget child;

  const LocalNotificationsInitializer({
    super.key,
    required this.child,
  });

  @override
  State<LocalNotificationsInitializer> createState() => _LocalNotificationsInitializerState();
}

class _LocalNotificationsInitializerState extends State<LocalNotificationsInitializer> {
  bool _isInitialized = false;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeLocalNotifications();
  }

  /// Inicializa las notificaciones locales
  Future<void> _initializeLocalNotifications() async {
    try {
      await LocalNotificationsService.initialize();

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }

      debugPrint('✅ Servicio de notificaciones locales inicializado correctamente');
    } catch (error) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = error.toString();
        });
      }

      debugPrint('❌ Error al inicializar notificaciones locales: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text(
                    'Error al inicializar notificaciones',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _errorMessage,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _hasError = false;
                        _errorMessage = '';
                      });
                      _initializeLocalNotifications();
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (!_isInitialized) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(
                  'Inicializando notificaciones...',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return widget.child;
  }
}
