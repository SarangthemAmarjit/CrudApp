import 'dart:convert';
import 'dart:developer';

import 'package:crudapp/modal/department_modal.dart';
import 'package:crudapp/modal/designation_modal.dart';
import 'package:crudapp/modal/employee_modal.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServiceApi {
  Future<List<Itemmodal>?> Get_designation() async {
    final response = await http.get(Uri.parse(
        'http://phpstack-598410-2859373.cloudwaysapps.com/api/designations'));
    final data = jsonDecode(response.body) as List;
    if (response.statusCode == 200) {
      var users = data.map((e) => Itemmodal.fromJson(e)).toList();
      log('Successfully get Data');
      return users;
    } else {
      log('Failed to Getdata.');
    }
    return null;
  }

  Future<List<Itemmodal2>?> Get_department() async {
    final response = await http.get(Uri.parse(
        'http://phpstack-598410-2859373.cloudwaysapps.com/api/departments'));
    final data = jsonDecode(response.body) as List;
    if (response.statusCode == 200) {
      var users = data.map((e) => Itemmodal2.fromJson(e)).toList();
      log('Successfully get Data');
      return users;
    } else {
      log('Failed to Getdata.');
    }
    return null;
  }

  Future<List<Itemmodal3>?> Get_employee() async {
    final response = await http.get(Uri.parse(
        'http://phpstack-598410-2859373.cloudwaysapps.com/api/employees'));
    final data = jsonDecode(response.body) as List;
    if (response.statusCode == 200) {
      var users = data.map((e) => Itemmodal3.fromJson(e)).toList();
      log('Successfully get Data');
      return users;
    } else {
      log('Failed to Getdata.');
    }
    return null;
  }

  Future create_employee(
      {required String name,
      required String desId,
      required String depId,
      required String dob}) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.post(
        Uri.parse(
            'http://phpstack-598410-2859373.cloudwaysapps.com/api/employees'),
        body: {
          "name": name,
          "designation_id": desId,
          "department_id": depId,
          "date_of_birth": dob
        });
    prefs.setInt('emp_createcode', response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Successfully post Data');
    } else {
      log('Failed to PostData.');
      log(response.statusCode.toString());
    }
    return null;
  }

  Future update_employee(
      {required String id,
      required String name,
      required String desId,
      required String depId,
      required String dob}) async {
    final prefs = await SharedPreferences.getInstance();
    log(id);
    final response = await http.patch(
        Uri.parse(
            'http://phpstack-598410-2859373.cloudwaysapps.com/api/employees/$id'),
        body: {
          "name": name,
          "designation_id": desId,
          "department_id": depId,
          "date_of_birth": dob
        });
    prefs.setInt('emp_updatecode', response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Successfully post Data');
    } else {
      log('Failed to PostData.');
      log(response.statusCode.toString());
    }
    return null;
  }

  Future delete_employee({
    required String id,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.delete(
      Uri.parse(
          'http://phpstack-598410-2859373.cloudwaysapps.com/api/employees/$id'),
    );
    prefs.setInt('emp_deletecode', response.statusCode);
    if (response.statusCode == 204) {
      log('Successfully delete Data');
    } else {
      log('Failed to PostData.');
      log(response.statusCode.toString());
    }
    return null;
  }

  Future create_department({
    required String name,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.post(
        Uri.parse(
            'http://phpstack-598410-2859373.cloudwaysapps.com/api/departments'),
        body: {
          "name": name,
        });
    prefs.setInt('dep_createcode', response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Successfully post Data');
    } else {
      log('Failed to PostData.');
      log(response.statusCode.toString());
    }
    return null;
  }

  Future update_department({
    required String id,
    required String name,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    log(id);
    final response = await http.put(
        Uri.parse(
            'http://phpstack-598410-2859373.cloudwaysapps.com/api/departments/$id'),
        body: {
          "name": name,
        });
    prefs.setInt('dep_updatecode', response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Successfully post Data');
    } else {
      log('Failed to PostData.');
      log(response.statusCode.toString());
    }
    return null;
  }

  Future delete_department({
    required String id,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.delete(
      Uri.parse(
          'http://phpstack-598410-2859373.cloudwaysapps.com/api/departments/$id'),
    );
    prefs.setInt('dep_deletecode', response.statusCode);
    if (response.statusCode == 204) {
      log('Successfully delete Data');
    } else {
      log('Failed to PostData.');
      log(response.statusCode.toString());
    }
    return null;
  }

  Future create_designation({
    required String name,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.post(
        Uri.parse(
            'http://phpstack-598410-2859373.cloudwaysapps.com/api/designations'),
        body: {
          "name": name,
        });
    prefs.setInt('des_createcode', response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Successfully post Data');
    } else {
      log('Failed to PostData.');
      log(response.statusCode.toString());
    }
    return null;
  }

  Future update_designation({
    required String id,
    required String name,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    log(id);
    final response = await http.put(
        Uri.parse(
            'http://phpstack-598410-2859373.cloudwaysapps.com/api/designations/$id'),
        body: {
          "name": name,
        });
    prefs.setInt('des_updatecode', response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Successfully post Data');
    } else {
      log('Failed to PostData.');
      log(response.statusCode.toString());
    }
    return null;
  }

  Future delete_designation({
    required String id,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final response = await http.delete(
      Uri.parse(
          'http://phpstack-598410-2859373.cloudwaysapps.com/api/designations/$id'),
    );
    prefs.setInt('des_deletecode', response.statusCode);
    if (response.statusCode == 204) {
      log('Successfully delete Data');
    } else {
      log('Failed to PostData.');
      log(response.statusCode.toString());
    }
    return null;
  }
}
