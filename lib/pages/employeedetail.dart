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
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bgok.jpg'),
                opacity: 0.5,
                alignment: Alignment.topCenter)),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                        elevation: 10,
                        shadowColor: const Color.fromARGB(255, 253, 245, 221),
                        color: Colors.white,
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/bg3.jpg'),
                                  opacity: 0.5,
                                  fit: BoxFit.cover)),
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 75,
                              ),
                              Text(
                                name,
                                style: GoogleFonts.kreon(fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: ClipOval(
                    child: Image.network(
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
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
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ClipPath(
              clipper: WaveClipperTwo(flip: true),
              child: SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  'http://phpstack-598410-2859373.cloudwaysapps.com/$image',
                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
            ),
            ProfileUpdate(text1: "Employee Name : ", text2: name),
            ProfileUpdate(text1: "Date of Birth : ", text2: dob),
            ProfileUpdate(text1: "Designation : ", text2: desingnation),
            ProfileUpdate(text1: "Department : ", text2: department),
            ProfileUpdate(text1: "Geo Location : ", text2: location),
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
            // ),
          ],
        ),
      ),
    );
  }
}
