import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:crudapp/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _DashboardState();
}

class _DashboardState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
        backgroundColor: const Color.fromARGB(255, 215, 238, 242),
        appBar: AppBar(
          title: Text(
            'CrudApp',
            style: GoogleFonts.kreon(fontSize: 22),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
              ),
              child: TextButton.icon(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 250, 250, 249))),
                icon: const Icon(Icons.logout),
                label: Text(
                  'Log Out',
                  style: GoogleFonts.kreon(),
                ),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          title: Text(
                            'Confirm',
                            style: GoogleFonts.kreon(),
                          ),
                          content: Text('Do You Want to Logout?',
                              style: GoogleFonts.kreon()),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("CANCEL",
                                        style: GoogleFonts.kreon())),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green),
                                      onPressed: () async {
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        log('Log Out');
                                        prefs.remove('tokken').whenComplete(() {
                                          context.router
                                              .push(const AuthFlowRoute());
                                        });
                                      },
                                      child: Text("YES",
                                          style: GoogleFonts.kreon())),
                                )
                              ],
                            ),
                          ],
                        );
                      }));
                  final prefs = await SharedPreferences.getInstance();

                  log('Done');
                },
              ),
            )
          ],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                context.router.push(const DesignatioRoute());
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), //<-- SEE HERE
                  ),
                  tileColor: Colors.white,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/designation.jpg',
                        height: 50,
                        width: 50,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'DESIGNATIONS',
                        style: GoogleFonts.luckiestGuy(
                            fontSize: 22,
                            color: const Color.fromARGB(255, 73, 72, 73)),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  context.router.push(const DepartmentRoute());
                },
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), //<-- SEE HERE
                  ),
                  tileColor: Colors.white,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/department.png',
                        height: 50,
                        width: 50,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'DEPARTMENTS',
                        style: GoogleFonts.luckiestGuy(
                            fontSize: 22,
                            color: const Color.fromARGB(255, 72, 73, 72)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  context.router.push(const EmployeesRoute());
                },
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), //<-- SEE HERE
                  ),
                  tileColor: Colors.white,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/employee.jpg',
                        height: 50,
                        width: 50,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'EMPLOYEES',
                        style: GoogleFonts.luckiestGuy(
                            fontSize: 22,
                            color: const Color.fromARGB(255, 72, 73, 72)),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
