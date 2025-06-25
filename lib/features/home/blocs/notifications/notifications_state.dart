part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final AuthorizationStatus status;
  final List<PushMessage> notificationList;

  const NotificationsState(this.status, this.notificationList);

  @override
  List<Object> get props => [status, notificationList];

  NotificationsState copyWith({
    AuthorizationStatus? status,
    List<PushMessage>? notificationList,
  }) {
    return NotificationsState(
      status ?? this.status,
      notificationList ?? this.notificationList,
    );
  }
}

final class NotificationsInitial extends NotificationsState {
  const NotificationsInitial() : super(AuthorizationStatus.notDetermined, const []);
}
