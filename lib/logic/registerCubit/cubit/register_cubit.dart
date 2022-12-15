import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<SignUpState> {
  RegisterCubit() : super(const SignUpState(status: Status2.initial));
}
