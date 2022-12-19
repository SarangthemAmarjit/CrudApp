import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:crudapp/modal/department_modal.dart';
import 'package:crudapp/modal/designation_modal.dart';
import 'package:crudapp/modal/employee_modal.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServiceApi {
  Future<List<Itemmodal>?> Get_designation({required String token}) async {
    final response = await http.get(
      Uri.parse(
          'http://phpstack-598410-2859373.cloudwaysapps.com/api/designations'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
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

  Future<List<Itemmodal2>?> Get_department({required String token}) async {
    final response = await http.get(
      Uri.parse(
          'http://phpstack-598410-2859373.cloudwaysapps.com/api/departments'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
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

  Future<List<Itemmodal3>?> Get_employee({required String token}) async {
    final response = await http.get(
      Uri.parse(
          'http://phpstack-598410-2859373.cloudwaysapps.com/api/employees'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
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

  Future create_employee({
    required String name,
    required String desId,
    required String depId,
    required String dob,
    required String token,
    required String image,
    required String location,
  }) async {
    var na = DateTime.now().millisecondsSinceEpoch;
    final prefs = await SharedPreferences.getInstance();
    String filename = '$na.jpg';

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://phpstack-598410-2859373.cloudwaysapps.com/api/employees'));
    request.fields['name'] = name;
    request.fields['designation_id'] = desId;
    request.fields['department_id'] = depId;
    request.fields['date_of_birth'] = dob;
    request.fields['geo_location'] = location;
    request.files.add(http.MultipartFile.fromBytes(
        'image', File(image).readAsBytesSync(),
        filename: filename));
    request.headers['Authorization'] = 'Bearer $token';
    var response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Successfully post Data');
      prefs.setInt('emp_createcode', response.statusCode);
    } else {
      log('Failed to PostData.');
    }
    return null;
  }

  Future update_employee({
    required String id,
    required String name,
    required String desId,
    required String depId,
    required String dob,
    required String token,
    required String image,
    required String location,
  }) async {
    var na = DateTime.now().millisecondsSinceEpoch;
    final prefs = await SharedPreferences.getInstance();
    String filename = '$na.jpg';

    var request = http.MultipartRequest(
        'PUT',
        Uri.parse(
            'http://phpstack-598410-2859373.cloudwaysapps.com/api/employees/$id'));
    request.fields['name'] = name;
    request.fields['designation_id'] = desId;
    request.fields['department_id'] = depId;
    request.fields['date_of_birth'] = dob;
    request.fields['geo_location'] = location;
    request.files.add(http.MultipartFile.fromBytes(
        'image', File(image).readAsBytesSync(),
        filename: filename));
    request.headers['Authorization'] = 'Bearer $token';
    var response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Successfully post Data');
      prefs.setInt('emp_updatecode', response.statusCode);
    } else {
      log('Failed to PostData.');
    }
    return null;
  }

  Future delete_employee({required String id, required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.delete(
      Uri.parse(
          'http://phpstack-598410-2859373.cloudwaysapps.com/api/employees/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
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

  Future create_department(
      {required String name, required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.post(
        Uri.parse(
            'http://phpstack-598410-2859373.cloudwaysapps.com/api/departments'),
        headers: {
          'Authorization': 'Bearer $token',
        },
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

  Future update_department(
      {required String id, required String name, required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    log(id);
    final response = await http.put(
        Uri.parse(
            'http://phpstack-598410-2859373.cloudwaysapps.com/api/departments/$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
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

  Future delete_department({required String id, required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.delete(
      Uri.parse(
          'http://phpstack-598410-2859373.cloudwaysapps.com/api/departments/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
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

  Future create_designation(
      {required String name, required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.post(
        Uri.parse(
            'http://phpstack-598410-2859373.cloudwaysapps.com/api/designations'),
        headers: {
          'Authorization': 'Bearer $token',
        },
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

  Future update_designation(
      {required String id, required String name, required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    log(id);
    final response = await http.put(
        Uri.parse(
            'http://phpstack-598410-2859373.cloudwaysapps.com/api/designations/$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
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

  Future delete_designation({required String id, required String token}) async {
    final prefs = await SharedPreferences.getInstance();

    final response = await http.delete(
      Uri.parse(
          'http://phpstack-598410-2859373.cloudwaysapps.com/api/designations/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
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
