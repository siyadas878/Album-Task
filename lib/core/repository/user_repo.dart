import 'dart:convert';
import 'dart:developer';

import 'package:album_project/core/models/user_model.dart';
import 'package:album_project/manager/url_manager.dart';
import 'package:album_project/widgets/custom_snackBar.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class UserRepo {
  //get all users
  Future<List<UserModel>?> getAllUsers() async {
    try {
      final response = await get(
          baseUrl(
            endPoint: 'users',
          ),
          headers: getHeaders());
      if (kDebugMode) {
        print('response==========${response.body}');
      }
      if (response.statusCode == 200) {
        final List<UserModel> allUsers =
            UserModel.fromList(jsonDecode(response.body));
        if (kDebugMode) {
          print(response.body);
        }
        return allUsers;
      } else {
        if (kDebugMode) {
          print('Error ------------${response.body}');
        }
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  //delete user
  Future<void> deleteUser({required int id}) async {
    try {
      final response = await delete(
          baseUrl(
            endPoint: 'users/$id',
          ),
          headers: getHeaders());
      if (response.statusCode == 200) {
        customSnackBar(
            title: 'Successfull', message: 'User deleted successfully');
      } else {
        customSnackBar(title: 'failed', message: 'User deleted failed');
        if (kDebugMode) {
          print('Error ------------${response.body}');
        }
        return;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  // add user
  Future<void> addUser(
      {required String name,
      required String phone,
      required String email}) async {
    try {
      final response = await post(
          baseUrl(
            endPoint: 'users',
          ),
          body: jsonEncode({
            {"name": name, "phone": phone, "email": email}
          }),
          headers: getHeaders());
      if (response.statusCode == 200 || response.statusCode == 201) {
        customSnackBar(title: 'Successfull', message: 'User addd successfully');
      } else {
        customSnackBar(title: 'failed', message: 'User addd failed');
        if (kDebugMode) {
          print('Error ------------${response.body}');
        }
        return;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  // update user
  Future<void> updateUser(
      {required int id,
      required String name,
      required String phone,
      required String email}) async {
    try {
      final response = await patch(
          baseUrl(
            endPoint: 'users/$id',
          ),
          body: jsonEncode({
            {"name": name, "phone": phone, "email": email}
          }),
          headers: getHeaders());
      if (response.statusCode == 200 || response.statusCode == 201) {
        customSnackBar(
            title: 'Successfull', message: 'User update successfully');
      } else {
        customSnackBar(title: 'failed', message: 'User update failed');
        if (kDebugMode) {
          print('Error ------------${response.body}');
        }
        return;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
