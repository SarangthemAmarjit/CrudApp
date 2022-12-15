import 'package:crudapp/logic/Authflow/auth_flow_cubit.dart';
import 'package:crudapp/logic/loginCubit/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiproviderWrapper extends StatelessWidget {
  final Widget child;
  const MultiproviderWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => LoginCubit(Status.initial)),
      BlocProvider(
        create: (context) => AuthFlowCubit(),
      ),
    ], child: child);
  }
}
