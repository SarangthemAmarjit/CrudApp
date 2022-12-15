import 'package:bloc/bloc.dart';
import 'package:crudapp/listener/auth_login_listener.dart';
import 'package:crudapp/repo/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<Status> implements AuthLoginListener {
  final _authRepository = AuthRepository();
  LoginCubit(Status initialState) : super(initialState);

  void loginUser({required String email, required String password}) {
    _authRepository.login(
        authLoginListener: this, password: password, username: email);
  }

  @override
  void error() {
    emit(Status.initial);
  }

  @override
  void loaded() {
    emit(Status.loaded);
  }

  @override
  void loading() {
    emit(Status.loading);
  }
}
