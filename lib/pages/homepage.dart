import 'package:crudapp/pages/department.dart';
import 'package:crudapp/pages/designation.dart';
import 'package:crudapp/pages/employee.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 238, 242),
      appBar: AppBar(
        title: const Text('CrudApp'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const DesignatioPage())));
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), //<-- SEE HERE
                ),
                tileColor: Colors.white,
                title: const Center(
                  child: Text(
                    'DESIGNATIONS',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const DepartmentPage())));
              },
              child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), //<-- SEE HERE
                  ),
                  tileColor: Colors.white,
                  title: const Center(
                    child: Text('DEPARTMENTS',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const EmployeesPage())));
              },
              child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), //<-- SEE HERE
                  ),
                  tileColor: Colors.white,
                  title: const Center(
                    child: Text('EMPLOYEES',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
