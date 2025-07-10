import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Servicio para manejar notificaciones locales usando flutter_local_notifications
///
/// Este servicio se encarga de:
/// - Inicializar el plugin de notificaciones locales
/// - Configurar las notificaciones para Android e iOS
/// - Proporcionar métodos para mostrar diferentes tipos de notificaciones
class LocalNotificationsService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static bool _isInitialized = false;

  /// Inicializa el servicio de notificaciones locales
  static Future<void> initialize() async {
    if (_isInitialized) return;

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializationSettings = InitializationSettings(
      android: androidSettings,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );

    _isInitialized = true;
  }

  /// Callback cuando el usuario interactúa con una notificación
  static void _onNotificationResponse(NotificationResponse response) {
    final payload = response.payload;
    debugPrint('🔔 Usuario interactuó con notificación: ${response.id}');
    debugPrint('📦 Payload: $payload');

    // Aquí puedes agregar navegación o lógica específica
    // Por ejemplo, navegar a una pantalla específica basada en el payload
  }

  /// Muestra una notificación simple
  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    await _ensureInitialized();

    const androidDetails = AndroidNotificationDetails(
      'basic_channel',
      'Notificaciones Básicas',
      channelDescription: 'Canal para notificaciones básicas de la aplicación',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  /// Muestra una notificación con texto expandido
  static Future<void> showExpandedNotification({
    required int id,
    required String title,
    required String body,
    required String expandedBody,
    String? payload,
  }) async {
    await _ensureInitialized();

    final androidDetails = AndroidNotificationDetails(
      'expanded_channel',
      'Notificaciones Expandidas',
      channelDescription: 'Canal para notificaciones con texto expandido',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(
        expandedBody,
        htmlFormatBigText: true,
        contentTitle: title,
        htmlFormatContentTitle: true,
        summaryText: body,
        htmlFormatSummaryText: true,
      ),
      showWhen: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  /// Muestra una notificación con botones de acción
  static Future<void> showNotificationWithActions({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    await _ensureInitialized();

    const androidDetails = AndroidNotificationDetails(
      'action_channel',
      'Notificaciones con Acciones',
      channelDescription: 'Canal para notificaciones con botones de acción',
      importance: Importance.high,
      priority: Priority.high,
      actions: [
        AndroidNotificationAction('accept_action', 'Aceptar', showsUserInterface: true),
        AndroidNotificationAction('decline_action', 'Rechazar', showsUserInterface: true),
      ],
      showWhen: true,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  /// Cancela una notificación específica
  static Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  /// Cancela todas las notificaciones
  static Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  /// Obtiene las notificaciones pendientes
  static Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notificationsPlugin.pendingNotificationRequests();
  }

  /// Verifica si las notificaciones están habilitadas (solo Android)
  static Future<bool?> areNotificationsEnabled() async {
    if (Platform.isAndroid) {
      return await _notificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.areNotificationsEnabled();
    }
    return null;
  }

  /// Asegura que el servicio esté inicializado antes de usar
  static Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await initialize();
    }
  }
}
