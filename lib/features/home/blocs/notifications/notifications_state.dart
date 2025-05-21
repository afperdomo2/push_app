part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final AuthorizationStatus status;
  final List<dynamic> notifications;

  const NotificationsState(this.status, this.notifications);

  @override
  List<Object> get props => [status, notifications];

  NotificationsState copyWith({
    AuthorizationStatus? status,
    List<dynamic>? notifications,
  }) {
    return NotificationsState(
      status ?? this.status,
      notifications ?? this.notifications,
    );
  }
}

final class NotificationsInitial extends NotificationsState {
  const NotificationsInitial() : super(AuthorizationStatus.notDetermined, const []);
}
