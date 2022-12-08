import 'dart:developer';

import 'package:crudapp/modal/department_modal.dart';
import 'package:crudapp/modal/designation_modal.dart';
import 'package:crudapp/modal/employee_modal.dart';
import 'package:crudapp/pages/employeedetail.dart';
import 'package:crudapp/refactor/alertbox.dart';
import 'package:crudapp/Services/serviceapi.dart';
import 'package:crudapp/refactor/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  String? dropdownvalue1;
  String? dropdownvalue11;
  String? dropdownvalue22;
  String? dropdownvalue2;

  String? menudrop;

  final TextEditingController _namefieldcontroller = TextEditingController();
  final TextEditingController _designationfieldcontroller =
      TextEditingController();
  final TextEditingController _departmentfieldcontroller =
      TextEditingController();
  String datetime = '';

  final TextEditingController _namefieldcontroller2 = TextEditingController();
  final TextEditingController _designationfieldcontroller2 =
      TextEditingController();
  final TextEditingController _departmentfieldcontroller2 =
      TextEditingController();
  String datetime2 = '';
  String datetime3 = '';
  String datetime4 = '';

  var format = DateFormat("dd-MM-yyyy");

  List<Itemmodal3> newlist = [];
  List<Itemmodal> newlist2 = [];
  List<Itemmodal2> newlist3 = [];
  List<String> all_desid = [];
  List<String> all_depid = [];
  List<String> all_des = [];
  List<String> all_dep = [];

  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata2() async {
    final datafinal = await ServiceApi().Get_employee();

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
      del_statuscode = prefs.getInt('emp_deletecode')!;
    });
    if (del_statuscode == 204) {
      CustomSnackBar(context, const Text('Deleted Successfully'), Colors.green);
    } else {
      CustomSnackBar(context, const Text('Error'), Colors.red);
    }
  }

  getupdate_status() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      update_statuscode = prefs.getInt('emp_updatecode')!;
    });
    if (update_statuscode == 201 || update_statuscode == 200) {
      CustomSnackBar(
          context, const Text('Updated Employee Successfully'), Colors.green);
    } else {
      CustomSnackBar(context, const Text('Error'), Colors.red);
    }
  }

  getcreate_status() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      create_statuscode = prefs.getInt('emp_createcode')!;
      log(create_statuscode.toString());
    });
    if (create_statuscode == 201 || create_statuscode == 200) {
      CustomSnackBar(
          context, const Text('Added Employee Successfully'), Colors.green);
    } else {
      CustomSnackBar(context, const Text('Error'), Colors.red);
    }
  }

  DateTime? initialdate = DateTime(2010);
  Future getdata() async {
    final datafinal = await ServiceApi().Get_employee();
    final datafinal2 = await ServiceApi().Get_designation();
    final datafinal3 = await ServiceApi().Get_department();
    setState(() {
      newlist = datafinal!;
      newlist2 = datafinal2!;
      newlist3 = datafinal3!;
    });
    for (var element in newlist2) {
      all_desid.add(element.id.toString());
    }
    for (var element in newlist3) {
      all_depid.add(element.id.toString());
    }
    for (var element in newlist2) {
      all_des.add(element.name.toString());
    }
    for (var element in newlist3) {
      all_dep.add(element.name.toString());
    }
    log(all_depid.toString());
    log(all_desid.toString());
  }

  bool showloading = false;

  Widget _dataofbirth(String dob) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: DateTimeField(
              controller: TextEditingController(text: dob),
              decoration: const InputDecoration(
                labelText: 'Date of Birth',
              ),
              format: format,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                        context: context,
                        initialDate: initialdate!,
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2025),
                        helpText: "SELECT DATE OF BIRTH",
                        cancelText: "CANCEL",
                        confirmText: "OK",
                        fieldHintText: "DATE/MONTH/YEAR",
                        fieldLabelText: "ENTER YOUR DATE OF BIRTH",
                        errorFormatText: "Enter a Valid Date",
                        errorInvalidText: "Date Out of Range")
                    .then((value) {
                  setState(() {
                    datetime = "${value!.year}-${value.month}-${value.day}";
                    datetime2 = "${value.year}-${value.month}-${value.day}";
                  });

                  return value;
                });
              },
            ),
          ),
        ]);
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
                                    await ServiceApi()
                                        .create_employee(
                                            name: _namefieldcontroller.text,
                                            desId: dropdownvalue11!,
                                            depId: dropdownvalue22!,
                                            dob: datetime)
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
                                    log(create_statuscode.toString());

                                    setState(() {
                                      all_desid = [];
                                      all_depid = [];
                                      all_dep = [];
                                      all_des = [];
                                    });
                                  },
                                  child: const Text("ADD")),
                            )
                          ],
                        ),
                      ],
                      title: const Text("Add new Employee"),
                      content: Form(
                        child: SizedBox(
                          height: 250,
                          child: Column(
                            children: [
                              TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: _namefieldcontroller,
                                  decoration: const InputDecoration(
                                    hintText: 'Name',
                                  )),
                              _dataofbirth(datetime2),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 13),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 240, 237, 237),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 225, 222, 222))),
                                child: Row(
                                  children: [
                                    const Text('Designation :'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        dropdownDirection:
                                            DropdownDirection.left,
                                        dropdownWidth: 200,
                                        hint: const Text('Select'),
                                        value: dropdownvalue1,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: all_des.map((String items) {
                                          log(items);
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items.toString()),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownvalue1 = newValue as String;
                                          });
                                          int ind =
                                              all_des.indexOf(dropdownvalue1!);
                                          dropdownvalue11 = all_desid[ind];
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 13),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 240, 237, 237),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 225, 222, 222))),
                                child: Row(
                                  children: [
                                    const Text("Department :"),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),

                                        alignment: Alignment.center,
                                        dropdownElevation: 10,
                                        dropdownPadding:
                                            const EdgeInsets.only(left: 25),
                                        dropdownDirection:
                                            DropdownDirection.left,
                                        dropdownWidth: 200,
                                        hint: const Text('Select'),
                                        value: dropdownvalue2,
                                        // Initial Value

                                        // Down Arrow Icon
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),

                                        // Array list of items
                                        items: all_dep.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (newValue) {
                                          setState(() {
                                            dropdownvalue2 = newValue!;
                                          });
                                          int ind =
                                              all_dep.indexOf(dropdownvalue2!);
                                          dropdownvalue22 = all_depid[ind];
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
        title: const Text('Employees'),
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
            flex: 17,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                horizontalTitleGap: 10,
                                tileColor: Colors.white,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          datetime3 =
                                              "${newlist[index].dateOfBirth.day}-${newlist[index].dateOfBirth.month}-${newlist[index].dateOfBirth.year}";
                                        });

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    EmployeeDetailPage(
                                                        name:
                                                            newlist[index].name,
                                                        dob: datetime3,
                                                        desingnation_id:
                                                            newlist[index]
                                                                .designationId
                                                                .toString(),
                                                        department_id:
                                                            newlist[index]
                                                                .departmentId
                                                                .toString()))));
                                      },
                                      child: Text(
                                        newlist[index].name,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
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
                                          int ind1 = all_desid.indexOf(
                                              newlist[index]
                                                  .designationId
                                                  .toString());
                                          int ind2 = all_depid.indexOf(
                                              newlist[index]
                                                  .departmentId
                                                  .toString());

                                          setState(() {
                                            _namefieldcontroller2.text =
                                                newlist[index].name;
                                            dropdownvalue1 = all_des[ind1];
                                            dropdownvalue2 = all_dep[ind2];
                                            dropdownvalue11 = newlist[index]
                                                .designationId
                                                .toString();
                                            dropdownvalue22 = newlist[index]
                                                .departmentId
                                                .toString();

                                            datetime2 =
                                                "${newlist[index].dateOfBirth.day}-${newlist[index].dateOfBirth.month}-${newlist[index].dateOfBirth.year}";
                                            datetime4 =
                                                "${newlist[index].dateOfBirth.year}-${newlist[index].dateOfBirth.month}-${newlist[index].dateOfBirth.day}";
                                          });

                                          showDialog(
                                            context: context,
                                            builder: (cnt) {
                                              return StatefulBuilder(builder:
                                                  ((BuildContext context,
                                                      void Function(
                                                              void Function())
                                                          setState) {
                                                return AlertDialog(
                                                    actions: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .grey,
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
                                                            child:
                                                                ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .green),
                                                                    onPressed:
                                                                        () {
                                                                      ServiceApi()
                                                                          .update_employee(
                                                                              id: newlist[index].id.toString(),
                                                                              name: _namefieldcontroller2.text,
                                                                              desId: dropdownvalue11!,
                                                                              depId: dropdownvalue22!,
                                                                              dob: datetime4)
                                                                          .whenComplete(() {
                                                                        Navigator.pop(
                                                                            context);
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            getdata().whenComplete(() =>
                                                                                Navigator.pop(context));
                                                                            return const AlertPage(alertmessage: 'Updating...');
                                                                          },
                                                                        ).whenComplete(() =>
                                                                            getupdate_status());
                                                                      });

                                                                      setState(
                                                                          () {
                                                                        all_desid =
                                                                            [];
                                                                        all_depid =
                                                                            [];
                                                                        all_dep =
                                                                            [];
                                                                        all_des =
                                                                            [];
                                                                      });
                                                                    },
                                                                    child: const Text(
                                                                        "UPDATE")),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                    title: const Text(
                                                        "Update Employee Details"),
                                                    content: Form(
                                                      child: SizedBox(
                                                        height: 250,
                                                        child: Column(
                                                          children: [
                                                            TextFormField(
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                controller:
                                                                    _namefieldcontroller2,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  hintText:
                                                                      'Name',
                                                                )),
                                                            _dataofbirth(
                                                                datetime2),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                    'Designation :'),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                DropdownButtonHideUnderline(
                                                                  child:
                                                                      DropdownButton2<
                                                                          String>(
                                                                    dropdownDecoration:
                                                                        BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10)),
                                                                    dropdownDirection:
                                                                        DropdownDirection
                                                                            .left,
                                                                    dropdownWidth:
                                                                        200,
                                                                    hint: const Text(
                                                                        'Select'),
                                                                    value:
                                                                        dropdownvalue1,
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .keyboard_arrow_down),
                                                                    items: all_des
                                                                        .map((String
                                                                            items) {
                                                                      log(items);
                                                                      return DropdownMenuItem(
                                                                        value:
                                                                            items,
                                                                        child: Text(
                                                                            items.toString()),
                                                                      );
                                                                    }).toList(),
                                                                    onChanged:
                                                                        (String?
                                                                            newValue) {
                                                                      setState(
                                                                          () {
                                                                        dropdownvalue1 =
                                                                            newValue!;
                                                                      });
                                                                      int ind =
                                                                          all_des
                                                                              .indexOf(dropdownvalue1!);
                                                                      dropdownvalue11 =
                                                                          all_desid[
                                                                              ind];
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                    "Department :"),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                DropdownButtonHideUnderline(
                                                                  child:
                                                                      DropdownButton2(
                                                                    dropdownDecoration:
                                                                        BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10)),
                                                                    dropdownDirection:
                                                                        DropdownDirection
                                                                            .left,
                                                                    dropdownWidth:
                                                                        200,
                                                                    hint: const Text(
                                                                        'Select'),
                                                                    value:
                                                                        dropdownvalue2,
                                                                    // Initial Value

                                                                    // Down Arrow Icon
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .keyboard_arrow_down),

                                                                    // Array list of items
                                                                    items: all_dep
                                                                        .map((String
                                                                            items) {
                                                                      return DropdownMenuItem(
                                                                        value:
                                                                            items,
                                                                        child: Text(
                                                                            items),
                                                                      );
                                                                    }).toList(),
                                                                    // After selecting the desired option,it will
                                                                    // change button value to selected value
                                                                    onChanged:
                                                                        (String?
                                                                            newValue) {
                                                                      setState(
                                                                          () {
                                                                        dropdownvalue2 =
                                                                            newValue!;
                                                                      });
                                                                      int ind =
                                                                          all_dep
                                                                              .indexOf(dropdownvalue2!);
                                                                      dropdownvalue22 =
                                                                          all_depid[
                                                                              ind];
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ));
                                              }));
                                            },
                                          );
                                        } else if (value == 2) {
                                          ServiceApi()
                                              .delete_employee(
                                                  id: newlist[index]
                                                      .id
                                                      .toString())
                                              .whenComplete(() {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                getdata().whenComplete(() =>
                                                    Navigator.pop(context));
                                                return const AlertPage(
                                                    alertmessage: 'Deleting..');
                                              },
                                            ).whenComplete(
                                                () => getdel_status());
                                          });
                                          setState(() {
                                            all_desid = [];
                                            all_depid = [];
                                            all_dep = [];
                                            all_des = [];
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }))),
          )
        ],
      ),
    );
  }
}
