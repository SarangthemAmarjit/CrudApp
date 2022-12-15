import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController confirmpasscontroller = TextEditingController();
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  void _toggleSignup() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 25, bottom: 10),
                        child: Text('Sign Up',
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
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    'assets/images/register2.jpg',
                    height: 200,
                    width: 200,
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Please Sign Up to your Account to Continue with App.',
                  style: GoogleFonts.kreon(fontSize: 18, color: Colors.black54),
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
                      Icons.mail,
                      color: Color.fromARGB(255, 75, 197, 199),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                        child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        if (!RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                            .hasMatch(value)) {
                          return "Please Enter a Valid Email Address";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: GoogleFonts.kreon(
                            fontSize: 20, color: Colors.black38),
                      ),
                    ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(children: [
                  const Icon(
                    Icons.lock,
                    color: Color.fromARGB(255, 75, 197, 199),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    obscureText: _obscureTextPassword,
                    autocorrect: false,
                    style: const TextStyle(
                        fontFamily: 'WorkSansSemiBold',
                        fontSize: 16.0,
                        color: Colors.black),
                    decoration: InputDecoration(
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
                      hintText: 'Enter Password',
                      hintStyle: GoogleFonts.kreon(
                          fontSize: 20, color: Colors.black38),
                    ),
                  ))
                ]),
              ),
              const SizedBox(
                height: 20,
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
                      obscureText: _obscureTextConfirmPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value != confirmpasscontroller.text) {
                          return 'Password Not Match';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        hintStyle: GoogleFonts.kreon(
                            fontSize: 20, color: Colors.black38),
                        suffixIcon: GestureDetector(
                          onTap: _toggleSignupConfirm,
                          child: Icon(
                            _obscureTextConfirmPassword
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
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromARGB(255, 75, 197, 199),
                  ),
                  height: 55,
                  width: 200,
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style:
                          GoogleFonts.kreon(fontSize: 23, color: Colors.white),
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
                  'Already have an account?',
                  style: GoogleFonts.kreon(fontSize: 18, color: Colors.black),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const RegisterPage())));
                  },
                  child: Text(
                    'SIGN IN',
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
  }
}
