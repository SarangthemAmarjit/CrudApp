import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 25, bottom: 10),
            child: Text('Sign In', style: GoogleFonts.kreon(fontSize: 40)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Container(
              width: 50,
              height: 7,
              color: const Color.fromARGB(255, 143, 219, 246),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Please Sign in to your Account to Continue with App.',
              style: GoogleFonts.kreon(fontSize: 18, color: Colors.black54),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                const Icon(
                  Icons.mail,
                  color: Color.fromARGB(255, 143, 219, 246),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle:
                        GoogleFonts.kreon(fontSize: 20, color: Colors.black38),
                  ),
                ))
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                const Icon(
                  Icons.lock,
                  color: Color.fromARGB(255, 143, 219, 246),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    hintStyle:
                        GoogleFonts.kreon(fontSize: 20, color: Colors.black38),
                  ),
                ))
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Forget Password?',
            style: GoogleFonts.kreon(fontSize: 20, color: Colors.black54),
          )
        ],
      ),
    );
  }
}
