import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:crudapp/modal/department_modal.dart';
import 'package:crudapp/modal/designation_modal.dart';
import 'package:crudapp/modal/employee_modal.dart';
import 'package:crudapp/refactor/alert.dart';
import 'package:crudapp/Services/serviceapi.dart';
import 'package:crudapp/refactor/imagepicker.dart';
import 'package:crudapp/refactor/imagepicker2.dart';
import 'package:crudapp/refactor/snackbar.dart';
import 'package:crudapp/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
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

  final TextEditingController _namefieldcontroller = TextEditingController();

  String datetime = '';

  final TextEditingController _namefieldcontroller2 = TextEditingController();

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

  int del_statuscode = 0;
  int update_statuscode = 0;
  int create_statuscode = 0;

  String? latitude;
  String? longitude;
  String finallocation = '';

  String profileimage = '';

  Position? _position;
  void _getCurrentLocation(void Function(void Function()) setState) async {
    Position position = await _determinePosition();
    final prefs = await SharedPreferences.getInstance();
    String image = prefs.getString('profileimage')!;

    setState(() {
      profileimage = image;
      _position = position;
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
      finallocation = "$latitude,$longitude";
    });

    log(profileimage.toString());
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
// When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

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

  final GlobalKey<FormFieldState> _keydep = GlobalKey();
  final GlobalKey<FormFieldState> _keydes = GlobalKey();

  String finaltoken = '';
  DateTime? initialdate = DateTime(2010);
  Future getdata() async {
    final prefs = await SharedPreferences.getInstance();
    String tokken = prefs.getString('tokken')!;
    final datafinal = await ServiceApi().Get_employee(token: tokken);
    final datafinal2 = await ServiceApi().Get_designation(token: tokken);
    final datafinal3 = await ServiceApi().Get_department(token: tokken);
    setState(() {
      newlist = datafinal!;
      newlist2 = datafinal2!;
      newlist3 = datafinal3!;
      finaltoken = tokken;
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
              decoration: InputDecoration(
                labelStyle: GoogleFonts.kreon(),
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
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'Add Employee',
          style: GoogleFonts.kreon(),
        ),
        icon: const Icon(Icons.add),
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
                                setState(() {
                                  _namefieldcontroller.clear();
                                  datetime2 = '';

                                  dropdownvalue1 = null;
                                  dropdownvalue2 = null;
                                });
                              },
                              child: const Text("CANCEL")),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                                onPressed: () async {
                                  Navigator.pop(context);
                                  EasyLoading.show(status: 'Adding..');
                                  await ServiceApi()
                                      .create_employee(
                                          name: _namefieldcontroller.text,
                                          desId: dropdownvalue11!,
                                          depId: dropdownvalue22!,
                                          dob: datetime,
                                          token: finaltoken,
                                          image: profileimage,
                                          location: finallocation)
                                      .whenComplete(() {
                                    getdata().whenComplete(() {
                                      EasyLoading.dismiss();
                                      getcreate_status();
                                    });
                                  });
                                  log(create_statuscode.toString());

                                  setState(() {
                                    all_desid = [];
                                    all_depid = [];
                                    all_dep = [];
                                    all_des = [];
                                    _namefieldcontroller.clear();
                                    datetime2 = '';

                                    dropdownvalue1 = null;
                                    dropdownvalue2 = null;
                                  });
                                },
                                child: const Text("ADD")),
                          )
                        ],
                      ),
                    ],
                    title: Text(
                      "Add new Employee",
                      style: GoogleFonts.kreon(),
                    ),
                    content: SingleChildScrollView(
                      child: Form(
                        child: SizedBox(
                          height: 460,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Profile Photo :',
                                    style: GoogleFonts.kreon(),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  const ProfileImagepicker(),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: _namefieldcontroller,
                                  decoration: InputDecoration(
                                      hintText: 'Name',
                                      hintStyle: GoogleFonts.kreon())),
                              _dataofbirth(datetime2),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 13),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 240, 237, 237),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 225, 222, 222))),
                                child: FittedBox(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Designation :',
                                        style: GoogleFonts.kreon(fontSize: 16),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                            dropdownPadding:
                                                const EdgeInsets.only(left: 25),
                                            dropdownDecoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            dropdownDirection:
                                                DropdownDirection.left,
                                            dropdownWidth: 250,
                                            hint: Text(
                                              'Select',
                                              style: GoogleFonts.kreon(
                                                  fontSize: 16),
                                            ),
                                            value: dropdownvalue1,
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            items: all_des.map((String items) {
                                              log(items);
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(
                                                  items,
                                                  style: GoogleFonts.kreon(
                                                      fontSize: 16),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownvalue1 =
                                                    newValue as String;
                                              });
                                              int ind = all_des
                                                  .indexOf(dropdownvalue1!);
                                              dropdownvalue11 = all_desid[ind];
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Department :",
                                      style: GoogleFonts.kreon(fontSize: 16),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          dropdownDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),

                                          dropdownPadding:
                                              const EdgeInsets.only(left: 25),
                                          dropdownDirection:
                                              DropdownDirection.left,
                                          dropdownWidth: 250,
                                          hint: Text(
                                            'Select',
                                            style: GoogleFonts.kreon(),
                                          ),
                                          value: dropdownvalue2,
                                          // Initial Value

                                          // Down Arrow Icon
                                          icon: const Padding(
                                            padding: EdgeInsets.only(left: 25),
                                            child:
                                                Icon(Icons.keyboard_arrow_down),
                                          ),

                                          // Array list of items
                                          items: all_dep.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(
                                                items,
                                                style: GoogleFonts.kreon(
                                                    fontSize: 16),
                                              ),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (newValue) {
                                            setState(() {
                                              dropdownvalue2 = newValue!;
                                            });
                                            int ind = all_dep
                                                .indexOf(dropdownvalue2!);
                                            dropdownvalue22 = all_depid[ind];
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextButton.icon(
                                      onPressed: () {
                                        _getCurrentLocation(setState);
                                      },
                                      icon: const Icon(Icons.fmd_good_sharp),
                                      label: Text(
                                        'Get Location',
                                        style: GoogleFonts.kreon(),
                                      )),
                                  _position != null
                                      ? Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Latitude : ",
                                                      style: GoogleFonts.kreon(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      latitude!,
                                                      style:
                                                          GoogleFonts.kreon(),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Longitude : ',
                                                      style: GoogleFonts.kreon(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      longitude!,
                                                      style:
                                                          GoogleFonts.kreon(),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : Text(
                                          'No location data',
                                          style: GoogleFonts.kreon(),
                                        ),
                                ],
                              ),
                            ],
                          ),
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
          'Employees',
          style: GoogleFonts.kreon(fontSize: 20),
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
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(15), //<-- SEE HERE
                                ),
                                horizontalTitleGap: 10,
                                tileColor:
                                    const Color.fromARGB(255, 250, 250, 250),
                                title: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                    onPressed: () {
                                      int depind = all_depid.indexOf(
                                          newlist[index]
                                              .departmentId
                                              .toString());
                                      int desind = all_desid.indexOf(
                                          newlist[index]
                                              .designationId
                                              .toString());

                                      setState(() {
                                        datetime3 =
                                            "${newlist[index].dateOfBirth.day}-${newlist[index].dateOfBirth.month}-${newlist[index].dateOfBirth.year}";
                                      });

                                      context.router.push(EmployeeDetailRoute(
                                          name: newlist[index].name,
                                          dob: datetime3,
                                          desingnation:
                                              all_des[desind].toString(),
                                          department:
                                              all_dep[depind].toString(),
                                          image: newlist[index].image,
                                          location:
                                              newlist[index].geoLocation));
                                    },
                                    child: Text(
                                      newlist[index].name,
                                      style: GoogleFonts.kreon(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                trailing: PopupMenuButton<int>(
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
                                      int ind1 = all_desid.indexOf(
                                          newlist[index]
                                              .designationId
                                              .toString());
                                      int ind2 = all_depid.indexOf(
                                          newlist[index]
                                              .departmentId
                                              .toString());
                                      List locationsplit =
                                          newlist[index].geoLocation.split(',');
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
                                        latitude = locationsplit[0];
                                        longitude = locationsplit[1];
                                        finallocation =
                                            newlist[index].geoLocation;
                                        profileimage =
                                            "http://phpstack-598410-2859373.cloudwaysapps.com/${newlist[index].image}";
                                      });

                                      showDialog(
                                        context: context,
                                        builder: (cnt) {
                                          return StatefulBuilder(builder:
                                              ((BuildContext context,
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
                                                            setState(() {
                                                              _namefieldcontroller
                                                                  .clear();
                                                              datetime2 = '';

                                                              dropdownvalue1 =
                                                                  null;
                                                              dropdownvalue2 =
                                                                  null;
                                                            });
                                                          },
                                                          child: const Text(
                                                              "CANCEL")),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .green),
                                                            onPressed: () {
                                                              ServiceApi()
                                                                  .update_employee(
                                                                      id: newlist[index]
                                                                          .id
                                                                          .toString(),
                                                                      name: _namefieldcontroller2
                                                                          .text,
                                                                      desId:
                                                                          dropdownvalue11!,
                                                                      depId:
                                                                          dropdownvalue22!,
                                                                      dob:
                                                                          datetime4,
                                                                      token:
                                                                          finaltoken,
                                                                      image:
                                                                          profileimage,
                                                                      location:
                                                                          finallocation)
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
                                                                ).whenComplete(() =>
                                                                    getupdate_status());
                                                              });

                                                              setState(() {
                                                                all_desid = [];
                                                                all_depid = [];
                                                                all_dep = [];
                                                                all_des = [];
                                                                _namefieldcontroller2
                                                                    .clear();
                                                                datetime2 = '';

                                                                dropdownvalue1 =
                                                                    null;
                                                                dropdownvalue2 =
                                                                    null;
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
                                                content: SingleChildScrollView(
                                                  child: Form(
                                                    child: SizedBox(
                                                      height: 465,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Profile Photo :',
                                                                style:
                                                                    GoogleFonts
                                                                        .kreon(),
                                                              ),
                                                              const SizedBox(
                                                                width: 30,
                                                              ),
                                                              ProfileImagepickerupdate(
                                                                image: newlist[
                                                                        index]
                                                                    .image,
                                                              ),
                                                            ],
                                                          ),
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
                                                                  key: _keydes,
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
                                                                          items
                                                                              .toString()),
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
                                                                    int ind = all_des
                                                                        .indexOf(
                                                                            dropdownvalue1!);
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
                                                                  key: _keydep,
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
                                                                    int ind = all_dep
                                                                        .indexOf(
                                                                            dropdownvalue2!);
                                                                    dropdownvalue22 =
                                                                        all_depid[
                                                                            ind];
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              TextButton.icon(
                                                                  onPressed:
                                                                      () {
                                                                    _getCurrentLocation(
                                                                        setState);
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .fmd_good_sharp),
                                                                  label: Text(
                                                                    'Get Location',
                                                                    style: GoogleFonts
                                                                        .kreon(),
                                                                  )),
                                                              latitude != null
                                                                  ? Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Container(
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Text(
                                                                                  "Latitude : ",
                                                                                  style: GoogleFonts.kreon(fontSize: 18, fontWeight: FontWeight.bold),
                                                                                ),
                                                                                Text(
                                                                                  latitude!,
                                                                                  style: GoogleFonts.kreon(),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Text(
                                                                                  'Longitude : ',
                                                                                  style: GoogleFonts.kreon(fontSize: 18, fontWeight: FontWeight.bold),
                                                                                ),
                                                                                Text(
                                                                                  longitude!,
                                                                                  style: GoogleFonts.kreon(),
                                                                                )
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Text(
                                                                      'No location data',
                                                                      style: GoogleFonts
                                                                          .kreon(),
                                                                    ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ));
                                          }));
                                        },
                                      );
                                    } else if (value == 2) {
                                      showDialog(
                                          context: context,
                                          builder: ((BuildContext context) {
                                            return StatefulBuilder(
                                                builder: ((context, setState) {
                                              return AlertDialog(
                                                title: Text('Confirm',
                                                    style: GoogleFonts.kreon()),
                                                content: Text(
                                                    'Are You Sure to Delete?',
                                                    style: GoogleFonts.kreon()),
                                                actions: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.grey,
                                                            side:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .red),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "CANCEL",
                                                            style: GoogleFonts
                                                                .kreon(),
                                                          )),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .green),
                                                            onPressed: () {
                                                              ServiceApi()
                                                                  .delete_employee(
                                                                      id: newlist[
                                                                              index]
                                                                          .id
                                                                          .toString(),
                                                                      token:
                                                                          finaltoken)
                                                                  .whenComplete(
                                                                      () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();

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
                                                                ).whenComplete(() =>
                                                                    getdel_status());
                                                              });
                                                              setState(() {
                                                                all_desid = [];
                                                                all_depid = [];
                                                                all_dep = [];
                                                                all_des = [];
                                                              });
                                                            },
                                                            child: Text("YES",
                                                                style: GoogleFonts
                                                                    .kreon())),
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
