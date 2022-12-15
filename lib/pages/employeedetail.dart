import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmployeeDetailPage extends StatelessWidget {
  final String name;
  final String dob;
  final String desingnation;
  final String department;

  const EmployeeDetailPage(
      {super.key,
      required this.name,
      required this.dob,
      required this.desingnation,
      required this.department});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 238, 242),
      appBar: AppBar(
        title: Text(
          "$name's Details",
          style: GoogleFonts.kreon(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              "Employee Name : $name",
              style: GoogleFonts.kreon(fontSize: 22),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Date of Birth : $dob",
              style: GoogleFonts.kreon(fontSize: 22),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Designation : $desingnation",
              style: GoogleFonts.kreon(fontSize: 22),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Department : $department",
              style: GoogleFonts.kreon(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
