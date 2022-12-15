part of 'register_cubit.dart';

enum Status2 { initial, loading, success, weakpassword, userexist, error }

class SignUpState extends Equatable {
  const SignUpState({required this.status});

  final Status2 status;

  @override
  List<Object?> get props => [status];
}
