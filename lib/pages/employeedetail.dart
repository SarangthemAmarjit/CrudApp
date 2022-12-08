import 'package:flutter/material.dart';

class EmployeeDetailPage extends StatelessWidget {
  final String name;
  final String dob;
  final String desingnation_id;
  final String department_id;

  const EmployeeDetailPage(
      {super.key,
      required this.name,
      required this.dob,
      required this.desingnation_id,
      required this.department_id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 238, 242),
      appBar: AppBar(
        title: Text("$name's Details"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              "Employee Name : $name",
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 10,
            ),
            Text("Date of Birth : $dob", style: const TextStyle(fontSize: 22)),
            const SizedBox(
              height: 10,
            ),
            Text("Designation Id : $desingnation_id",
                style: const TextStyle(fontSize: 22)),
            const SizedBox(
              height: 10,
            ),
            Text("Department Id : $department_id",
                style: const TextStyle(fontSize: 22)),
          ],
        ),
      ),
    );
  }
}
