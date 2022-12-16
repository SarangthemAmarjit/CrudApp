import 'dart:developer';

import 'package:crudapp/modal/designation_modal.dart';
import 'package:crudapp/refactor/alert.dart';
import 'package:crudapp/refactor/snackbar.dart';
import 'package:crudapp/Services/serviceapi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DesignatioPage extends StatefulWidget {
  const DesignatioPage({super.key});

  @override
  State<DesignatioPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DesignatioPage> {
  final TextEditingController _namefieldcontroller = TextEditingController();
  List<Itemmodal> newlist = [];
  @override
  void initState() {
    super.initState();
    getdata();
  }

  String finaltokken = '';

  Future getdata() async {
    final prefs = await SharedPreferences.getInstance();
    String tokken = prefs.getString('tokken')!;
    final datafinal = await ServiceApi().Get_designation(token: tokken);

    setState(() {
      finaltokken = tokken;
    });

    setState(() {
      newlist = datafinal!;
    });
  }

  int del_statuscode = 0;
  int update_statuscode = 0;
  int create_statuscode = 0;

  getdel_status() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      del_statuscode = prefs.getInt('des_deletecode')!;
    });
  }

  getupdate_status() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      update_statuscode = prefs.getInt('des_updatecode')!;
    });
    if (update_statuscode == 201 || update_statuscode == 200) {
      CustomSnackBar(context, const Text('Updated Designation Successfully'),
          Colors.green);
    } else {
      CustomSnackBar(context, const Text('Error'), Colors.red);
    }
  }

  getcreate_status() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      create_statuscode = prefs.getInt('des_createcode')!;
    });
    if (create_statuscode == 201 || create_statuscode == 200) {
      CustomSnackBar(
          context, const Text('Added Designation Successfully'), Colors.green);
    } else {
      CustomSnackBar(context, const Text('Error'), Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 238, 242),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: Text(
          'Add Designation',
          style: GoogleFonts.kreon(),
        ),
        onPressed: (() {
          showDialog(
            context: context,
            builder: (cnt) {
              return StatefulBuilder(
                builder: (BuildContext context,
                    void Function(void Function()) setState) {
                  return AlertDialog(
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  side: const BorderSide(color: Colors.red)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child:
                                  Text("CANCEL", style: GoogleFonts.kreon())),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                                onPressed: () async {
                                  ServiceApi()
                                      .create_designation(
                                    token: finaltokken,
                                    name: _namefieldcontroller.text,
                                  )
                                      .whenComplete(() {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        getdata().whenComplete(
                                            () => Navigator.pop(context));
                                        return const AlertPage(
                                            alertmessage: 'Adding..');
                                      },
                                    ).whenComplete(() => getcreate_status());
                                  });
                                },
                                child: Text(
                                  "ADD",
                                  style: GoogleFonts.kreon(),
                                )),
                          )
                        ],
                      ),
                    ],
                    title: Text(
                      "Add new Designation",
                      style: GoogleFonts.kreon(),
                    ),
                    content: Form(
                      child: SizedBox(
                        height: 50,
                        child: Column(
                          children: [
                            TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _namefieldcontroller,
                                decoration: InputDecoration(
                                    hintText: 'Name',
                                    hintStyle: GoogleFonts.kreon())),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        }),
      ),
      appBar: AppBar(
        title: Text(
          'Designation',
          style: GoogleFonts.kreon(
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 50,
            ),
          ),
          Expanded(
            flex: 15,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: newlist.isEmpty
                  ? Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: 100,
                        width: 150,
                        child: Column(
                          children: [
                            Text(
                              'Please Wait...',
                              style: GoogleFonts.kreon(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: newlist.length,
                      itemBuilder: ((context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              tileColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(15), //<-- SEE HERE
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    newlist[index].name,
                                    style: GoogleFonts.kreon(
                                      fontSize: 20,
                                    ),
                                  ),
                                  PopupMenuButton<int>(
                                    itemBuilder: (context) => [
                                      // PopupMenuItem 1
                                      PopupMenuItem(
                                        value: 1,
                                        // row with 2 children
                                        child: Row(
                                          children: [
                                            const Icon(Icons.edit),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Update",
                                              style: GoogleFonts.kreon(),
                                            )
                                          ],
                                        ),
                                      ),
                                      // PopupMenuItem 2
                                      PopupMenuItem(
                                        value: 2,
                                        // row with two children
                                        child: Row(
                                          children: [
                                            const Icon(Icons.delete),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Delete",
                                              style: GoogleFonts.kreon(),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                    offset: const Offset(5, 40),

                                    elevation: 2,
                                    // on selected we show the dialog box
                                    onSelected: (value) {
                                      // if value 1 show dialog
                                      if (value == 1) {
                                        setState(() {
                                          _namefieldcontroller.text =
                                              newlist[index].name;
                                        });
                                        showDialog(
                                          context: context,
                                          builder: (cnt) {
                                            return StatefulBuilder(
                                              builder: (BuildContext context,
                                                  void Function(void Function())
                                                      setState) {
                                                return AlertDialog(
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    Colors.grey,
                                                                side: const BorderSide(
                                                                    color: Colors
                                                                        .red)),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "CANCEL")),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .green),
                                                              onPressed:
                                                                  () async {
                                                                ServiceApi()
                                                                    .update_designation(
                                                                        id: newlist[index]
                                                                            .id
                                                                            .toString(),
                                                                        name: _namefieldcontroller
                                                                            .text,
                                                                        token:
                                                                            finaltokken)
                                                                    .whenComplete(
                                                                        () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      getdata().whenComplete(() =>
                                                                          Navigator.pop(
                                                                              context));
                                                                      return const AlertPage(
                                                                          alertmessage:
                                                                              'Updating...');
                                                                    },
                                                                  ).whenComplete(
                                                                      () =>
                                                                          getupdate_status());
                                                                });
                                                              },
                                                              child: const Text(
                                                                  "UPDATE")),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                  title: const Text(
                                                      "Update Designation"),
                                                  content: Form(
                                                    child: SizedBox(
                                                      height: 50,
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              controller:
                                                                  _namefieldcontroller,
                                                              decoration:
                                                                  const InputDecoration(
                                                                hintText:
                                                                    'Name',
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                        // if value 2 show dialog
                                      } else if (value == 2) {
                                        showDialog(
                                            context: context,
                                            builder: ((BuildContext context) {
                                              return StatefulBuilder(builder:
                                                  ((context, setState) {
                                                return AlertDialog(
                                                  title: const Text('Confirm'),
                                                  content: const Text(
                                                      'Are You Sure To Delete?'),
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors.grey,
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "CANCEL")),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .green),
                                                              onPressed:
                                                                  () async {
                                                                ServiceApi()
                                                                    .delete_designation(
                                                                        id: newlist[index]
                                                                            .id
                                                                            .toString(),
                                                                        token:
                                                                            finaltokken)
                                                                    .whenComplete(
                                                                        () {
                                                                  getdel_status();

                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      getdata().whenComplete(() =>
                                                                          Navigator.pop(
                                                                              context));
                                                                      return const AlertPage(
                                                                          alertmessage:
                                                                              'Deleting..');
                                                                    },
                                                                  ).whenComplete(
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    if (del_statuscode ==
                                                                        204) {
                                                                      CustomSnackBar(
                                                                          context,
                                                                          const Text(
                                                                              'Done Deleted'),
                                                                          Colors
                                                                              .green);
                                                                    } else if (del_statuscode ==
                                                                        500) {
                                                                      CustomSnackBar(
                                                                          context,
                                                                          const Text(
                                                                              'Cannot Delete !! Id is Used by Some Employee'),
                                                                          Colors
                                                                              .red);
                                                                    } else {
                                                                      log('Error');
                                                                    }
                                                                  });
                                                                });
                                                              },
                                                              child: const Text(
                                                                  "YES")),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              }));
                                            }));
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
            ),
          )
        ],
      ),
    );
  }
}
