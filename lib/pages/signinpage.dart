import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:crudapp/logic/loginCubit/cubit/login_cubit.dart';
import 'package:crudapp/pages/signupPage.dart';
import 'package:crudapp/refactor/snackbar.dart';
import 'package:crudapp/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  bool _obscureTextPassword = true;

  void _toggleSignup() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, Status>(
      listener: (context, state) {
        switch (state) {
          case Status.initial:
            log('Initial');

            break;

          case Status.loading:
            log('Loading');
            EasyLoading.show(
                maskType: EasyLoadingMaskType.black, status: 'Please Wait..');
            break;

          case Status.loaded:
            EasyLoading.dismiss();

            CustomSnackBar(
                context,
                Text(
                  'Login Successfully',
                  style: GoogleFonts.kreon(fontSize: 18),
                ),
                Colors.green);
            context.router.push(const AuthFlowRoute());
            break;

          case Status.error:
            EasyLoading.dismiss();

            CustomSnackBar(
                context,
                Text(
                  'Invalid Username or Password',
                  style: GoogleFonts.kreon(fontSize: 18),
                ),
                Colors.red);
            break;
        }
      },
      builder: (context, state) {
        Future<bool> showExitPopup() async {
          return await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    'Exit App',
                    style: GoogleFonts.kreon(),
                  ),
                  content: Text('Do you want to exit an App?',
                      style: GoogleFonts.kreon()),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('No', style: GoogleFonts.kreon()),
                    ),
                    ElevatedButton(
                      onPressed: () => SystemNavigator.pop(),
                      child: Text('Yes', style: GoogleFonts.kreon()),
                    ),
                  ],
                ),
              ) ??
              false;
        }

        return WillPopScope(
          onWillPop: showExitPopup,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 30, bottom: 10),
                            child: Text('Sign In',
                                style: GoogleFonts.kreon(
                                    fontSize: 40, fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Container(
                              width: 50,
                              height: 7,
                              color: const Color.fromARGB(255, 75, 197, 199),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            height: 170,
                            width: 170,
                            child: Image.asset(
                              'assets/images/login.jpg',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Please Sign in to your Account to Continue with App.',
                      style: GoogleFonts.kreon(
                          fontSize: 18, color: Colors.black54),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.mail,
                          color: Color.fromARGB(255, 75, 197, 199),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: TextFormField(
                          style: GoogleFonts.kreon(fontSize: 18),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Email is required';
                          //   }
                          //   if (!RegExp(
                          //           r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          //       .hasMatch(value)) {
                          //     return "Please Enter a Valid Email Address";
                          //   }
                          //   return null;
                          // },
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: emailcontroller,
                          decoration: InputDecoration(
                            hintText: 'Username',
                            hintStyle: GoogleFonts.kreon(
                                fontSize: 20, color: Colors.black38),
                          ),
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.lock,
                          color: Color.fromARGB(255, 75, 197, 199),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: TextFormField(
                          style: GoogleFonts.kreon(fontSize: 18),
                          controller: passcontroller,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                          obscureText: _obscureTextPassword,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                            hintStyle: GoogleFonts.kreon(
                                fontSize: 20, color: Colors.black38),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignup,
                              child: Icon(
                                _obscureTextPassword
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Forget Password?',
                        style: GoogleFonts.kreon(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  InkWell(
                    onTap: () {
                      context.read<LoginCubit>().loginUser(
                          email: emailcontroller.text,
                          password: passcontroller.text);

                      //     .whenComplete(() {
                      //   context.router.pop();
                      //   return context.router.push(const AuthFlowRoute());
                      // });
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 75, 197, 199),
                        ),
                        height: 55,
                        width: 200,
                        child: Center(
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.kreon(
                                fontSize: 23, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Don\'t have an account?',
                      style:
                          GoogleFonts.kreon(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const RegisterPage())));
                      },
                      child: Text(
                        'SIGN UP',
                        style: GoogleFonts.kreon(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 75, 197, 199),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
