import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(const NotificationsInitial()) {
    on<NotificationStatusChanged>(_updateNotificationState);

    _initializeNotificationStatus();
    _handleForegroundNotification();
  }

  /// Inicializa el estado de las notificaciones y obtiene el token FCM.
  void _initializeNotificationStatus() async {
    final settings = await messaging.getNotificationSettings();
    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  /// Actualiza el estado de las notificaciones.
  void _updateNotificationState(
    NotificationStatusChanged event,
    Emitter<NotificationsState> emit,
  ) {
    emit(state.copyWith(status: event.status));
    _getFCMToken();
  }

  /// Solicita permiso para enviar notificaciones al usuario.
  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  /// Maneja las notificaciones recibidas mientras la aplicación está en primer plano.
  void _handleForegroundNotification() {
    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
  }

  void _handleRemoteMessage(RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  }

  /// Obtiene el token de FCM (Firebase Cloud Messaging) del dispositivo.
  void _getFCMToken() async {
    final settings = await messaging.getNotificationSettings();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final token = await messaging.getToken();
      // ignore: avoid_print
      print('🔑FCM Token: $token');
    } else {
      // ignore: avoid_print
      print('❌Notifications are not authorized.');
    }
  }
}
