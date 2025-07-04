import 'package:go_router/go_router.dart';
import 'package:push_app/features/home/screens/home_screen.dart';
import 'package:push_app/features/home/screens/notification_details_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
    ),
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
