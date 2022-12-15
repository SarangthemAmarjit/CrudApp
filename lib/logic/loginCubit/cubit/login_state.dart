part of 'login_cubit.dart';

enum Status { initial, loading, loaded, error }

class LoginState extends Equatable {
  const LoginState({required this.status});

  final Status status;

  @override
  List get props => [status];
}
