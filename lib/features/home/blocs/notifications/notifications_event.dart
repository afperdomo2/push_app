part of 'notifications_bloc.dart';

// Evento base para las notificaciones
class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

// Evento para cambiar el estado de las notificaciones
class NotificationStatusChanged extends NotificationsEvent {
  final AuthorizationStatus status;

  const NotificationStatusChanged(this.status);
}

// Evento para recibir una notificación
class NotificationReceived extends NotificationsEvent {
  final PushMessage message;

  const NotificationReceived(this.message);
}
