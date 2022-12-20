import 'package:crudapp/refactor/profilelist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';

class EmployeeDetailPage extends StatelessWidget {
  final String name;
  final String dob;
  final String desingnation;
  final String department;
  final String image;
  final String location;

  const EmployeeDetailPage(
      {super.key,
      required this.name,
      required this.dob,
      required this.desingnation,
      required this.department,
      required this.image,
      required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "$name's Details",
            style: GoogleFonts.kreon(fontSize: 18),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                Column(
                  children: [
                    ClipPath(
                      clipper: WaveClipperTwo(flip: true),
                      child: Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 251, 201, 218),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'http://phpstack-598410-2859373.cloudwaysapps.com/$image'),
                                opacity: 0.5,
                                fit: BoxFit.cover)),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: ClipOval(
                          child: Image.network(
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            'http://phpstack-598410-2859373.cloudwaysapps.com/$image',
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 2,
                width: MediaQuery.of(context).size.width,
                color: const Color.fromARGB(255, 244, 171, 196),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ProfileUpdate(
              text1: "Employee Name : ",
              text2: name,
              icon: Icons.person,
            ),
            ProfileUpdate(
              text1: "Date of Birth : ",
              text2: dob,
              icon: Icons.calendar_month_rounded,
            ),
            ProfileUpdate(
              text1: "Designation : ",
              text2: desingnation,
              icon: Icons.design_services_sharp,
            ),
            ProfileUpdate(
              text1: "Department : ",
              text2: department,
              icon: Icons.local_fire_department,
            ),
            ProfileUpdate(
              text1: "Geo Location : ",
              text2: location,
              icon: Icons.location_on,
            ),
          ],
        )

        // Row(
        //   children: [
        //     Text(
        //       "Employee Name : ",
        //       style: GoogleFonts.kreon(
        //           fontSize: 20, fontWeight: FontWeight.bold),
        //     ),
        //     Text(
        //       name,
        //       style: GoogleFonts.kreon(fontSize: 20),
        //     ),
        //   ],
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        // Row(
        //   children: [
        //     Text(
        //       "Date of Birth : ",
        //       style: GoogleFonts.kreon(
        //           fontSize: 20, fontWeight: FontWeight.bold),
        //     ),
        //     Text(
        //       dob,
        //       style: GoogleFonts.kreon(fontSize: 20),
        //     ),
        //   ],
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        // Row(
        //   children: [
        //     Text(
        //       "Designation : ",
        //       style: GoogleFonts.kreon(
        //           fontSize: 20, fontWeight: FontWeight.bold),
        //     ),
        //     Text(
        //       desingnation,
        //       style: GoogleFonts.kreon(fontSize: 20),
        //     ),
        //   ],
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        // Row(
        //   children: [
        //     Text(
        //       "Department : ",
        //       style: GoogleFonts.kreon(
        //           fontSize: 20, fontWeight: FontWeight.bold),
        //     ),
        //     Text(
        //       department,
        //       style: GoogleFonts.kreon(fontSize: 20),
        //     ),
        //   ],
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        // Row(
        //   children: [
        //     Text(
        //       "Geo Location : ",
        //       style: GoogleFonts.kreon(
        //           fontSize: 20, fontWeight: FontWeight.bold),
        //     ),
        //     Text(
        //       location,
        //       style: GoogleFonts.kreon(fontSize: 20),
        //     ),
        //   ],

        );
  }
}
