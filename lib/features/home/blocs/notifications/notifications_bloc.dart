// ignore_for_file: avoid_print

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/domain/entities/push_message.dart';

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

  /// Maneja los mensajes remotos recibidos mientras la aplicación está en primer plano.
  void _handleRemoteMessage(RemoteMessage message) {
    print('¡Se recibió un mensaje mientras la aplicación estaba en primer plano!');
    print('Datos del mensaje: ${message.data}');

    if (message.notification != null) {
      print('El mensaje también contenía una notificación: ${message.notification}');
    }

    final messageId = message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? 'no-id';

    final notification = PushMessage(
      id: messageId,
      title: message.notification?.title ?? 'Sin título',
      body: message.notification?.body ?? 'Sin cuerpo',
      timestamp: message.sentTime ?? DateTime.now(),
      data: message.data,
      imageUrl: Platform.isAndroid
          ? message.notification?.android?.imageUrl
          : message.notification?.apple?.imageUrl,
    );

    print(notification);
  }

  /// Obtiene el token de FCM (Firebase Cloud Messaging) del dispositivo.
  void _getFCMToken() async {
    final settings = await messaging.getNotificationSettings();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final token = await messaging.getToken();
      print('🔑FCM Token: $token');
    } else {
      print('❌Las notificaciones no están autorizadas.');
    }
  }
}
