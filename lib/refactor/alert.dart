import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  final String alertmessage;
  const AlertPage({super.key, required this.alertmessage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 100),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      elevation: 6,
      content: SizedBox(
        width: 30,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const CircularProgressIndicator(
                  backgroundColor: Color.fromARGB(255, 252, 251, 250),
                )),
            Text(
              alertmessage,
              style: const TextStyle(color: Color.fromARGB(255, 6, 0, 0)),
            )
          ],
        ),
      ),
    );
  }
}
