import 'dart:developer';

import 'package:crudapp/modal/department_modal.dart';
import 'package:crudapp/refactor/alertbox.dart';
import 'package:crudapp/refactor/snackbar.dart';
import 'package:crudapp/Services/serviceapi.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DepartmentPage extends StatefulWidget {
  const DepartmentPage({super.key});

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  final TextEditingController _namefieldcontroller = TextEditingController();
  List<Itemmodal2> newlist = [];
  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future getdata() async {
    final datafinal = await ServiceApi().Get_department();
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
      del_statuscode = prefs.getInt('dep_deletecode')!;
    });
  }

  getupdate_status() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      update_statuscode = prefs.getInt('dep_updatecode')!;
    });
    if (update_statuscode == 201 || update_statuscode == 200) {
      CustomSnackBar(
          context, const Text('Updated Department Successfully'), Colors.green);
    } else {
      CustomSnackBar(context, const Text('Error'), Colors.red);
    }
  }

  getcreate_status() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      create_statuscode = prefs.getInt('dep_createcode')!;
    });
    if (create_statuscode == 201 || create_statuscode == 200) {
      CustomSnackBar(
          context, const Text('Added Department Successfully'), Colors.green);
    } else {
      CustomSnackBar(context, const Text('Error'), Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 238, 242),
      floatingActionButton: FloatingActionButton(
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
                                child: const Text("CANCEL")),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  onPressed: () async {
                                    ServiceApi()
                                        .create_department(
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
                                  child: const Text("ADD")),
                            )
                          ],
                        ),
                      ],
                      title: const Text("Add new Department"),
                      content: Form(
                        child: SizedBox(
                          height: 50,
                          child: Column(
                            children: [
                              TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: _namefieldcontroller,
                                  decoration: const InputDecoration(
                                    hintText: 'Name',
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
          }),
          child: const Icon(Icons.add)),
      appBar: AppBar(
        title: const Text('Departments'),
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
                          children: const [
                            Text(
                              'Please Wait...',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CircularProgressIndicator(),
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
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(15), //<-- SEE HERE
                              ),
                              tileColor: Colors.white,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(newlist[index].name),
                                  PopupMenuButton<int>(
                                    itemBuilder: (context) => [
                                      // PopupMenuItem 1
                                      PopupMenuItem(
                                        value: 1,
                                        // row with 2 children
                                        child: Row(
                                          children: const [
                                            Icon(Icons.edit),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("Update")
                                          ],
                                        ),
                                      ),
                                      // PopupMenuItem 2
                                      PopupMenuItem(
                                        value: 2,
                                        // row with two children
                                        child: Row(
                                          children: const [
                                            Icon(Icons.delete),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("Delete")
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
                                                                    .update_department(
                                                                        id: newlist[index]
                                                                            .id
                                                                            .toString(),
                                                                        name: _namefieldcontroller
                                                                            .text)
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
                                                      "Update Department"),
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
                                        ServiceApi()
                                            .delete_department(
                                                id: newlist[index]
                                                    .id
                                                    .toString())
                                            .whenComplete(() {
                                          getdel_status();
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              getdata().whenComplete(
                                                  () => Navigator.pop(context));
                                              return const AlertPage(
                                                  alertmessage: 'Deleting..');
                                            },
                                          ).whenComplete(() {
                                            if (del_statuscode == 204) {
                                              CustomSnackBar(
                                                  context,
                                                  const Text('Done Deleted'),
                                                  Colors.green);
                                            } else if (del_statuscode == 500) {
                                              CustomSnackBar(
                                                  context,
                                                  const Text(
                                                      'Cannot Delete !! Id is Used by Some Employee'),
                                                  Colors.red);
                                            } else {
                                              log('Error');
                                            }
                                          });
                                        });
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
