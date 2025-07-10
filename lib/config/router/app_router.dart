import 'package:go_router/go_router.dart';
import 'package:push_app/features/home/screens/home_screen.dart';
import 'package:push_app/features/home/screens/notification_details_screen.dart';
import 'package:push_app/features/local_notifications/screens/local_notifications_screen.dart';
import 'package:push_app/features/navigation/widgets/main_navigation_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        // Determinar el índice basado en la ruta actual
        int currentIndex = 0;
        final location = state.fullPath;

        if (location?.startsWith('/local-notifications') == true) {
          currentIndex = 1;
        } else {
          currentIndex = 0;
        }

        return MainNavigationScreen(currentIndex: currentIndex, child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          name: HomeScreen.routeName,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/local-notifications',
          name: LocalNotificationsScreen.routeName,
          builder: (context, state) => const LocalNotificationsScreen(),
        ),
      ],
    ),
    // Ruta independiente para detalles de notificación (sin bottom navigation)
    GoRoute(
      path: '/notification/:messageId',
      name: NotificationDetailsScreen.routeName,
      builder: (context, state) {
        final messageId = state.pathParameters['messageId'] ?? '';
        return NotificationDetailsScreen(messageId: messageId);
      },
    ),
  ],
);
