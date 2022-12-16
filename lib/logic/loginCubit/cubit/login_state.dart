part of 'login_cubit.dart';

enum Status { initial, loading, loaded, error }

class LoginState extends Equatable {
  final Status status;
  const LoginState({required this.status});

  

  @override
  List get props => [status];
}
