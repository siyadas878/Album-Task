import 'dart:convert';
import 'package:album_project/core/models/photo_model.dart';
import 'package:album_project/manager/url_manager.dart';
import 'package:album_project/widgets/custom_snackBar.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PhotoRepo {
  //get all photos
  Future<List<PhotoModel>?> getAllPhotos({required int albumId}) async {
    try {
      final response = await get(
          baseUrl(
            endPoint: 'photos',
          ),
          headers: getHeaders());
      if (response.statusCode == 200) {
        final List<PhotoModel> allPhotos =
            PhotoModel.fromList(jsonDecode(response.body));

        List<PhotoModel> sortedPhotos = [];
        for (var element in allPhotos) {
          if (element.albumId == albumId) {
            sortedPhotos.add(element);
          }
        }
        if (kDebugMode) {
          print(response.body);
        }
        return sortedPhotos;
      } else {
        if (kDebugMode) {
          print('Error ------------${response.body}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return [];
  }

  //delete photo
  Future<void> deletePhoto({required int id}) async {
    try {
      final response = await delete(
          baseUrl(
            endPoint: 'photos/$id',
          ),
          headers: getHeaders());
      if (response.statusCode == 200) {
        customSnackBar(
            title: 'Successfull', message: 'Photo deleted successfully');
      } else {
        customSnackBar(title: 'failed', message: 'Photo deleted failed');
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

  //add photo
  Future<void> addPhoto({required String title, required XFile image}) async {
    try {
      var request = http.MultipartRequest('POST', baseUrl(endPoint: 'photos'));
      request.fields["title"] = title;
      request.files.add(await http.MultipartFile.fromPath("image", image.path));
      var response = await request.send();
      var responseData = await http.Response.fromStream(response);
      getHeaders();
      if (responseData.statusCode == 200 || responseData.statusCode == 201) {
        customSnackBar(
            title: 'Successfull', message: 'photo addd successfully');
      } else {
        customSnackBar(title: 'failed', message: 'photo addd failed');
        if (kDebugMode) {
          print('Error ------------${responseData.body}');
        }
        return;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  //update photo
  Future<void> updatePhoto(
      {required int id, required String title, required XFile image}) async {
    try {
      var request =
          http.MultipartRequest('PATCH', baseUrl(endPoint: 'photos/$id'));
      request.fields["title"] = title;
      request.files.add(await http.MultipartFile.fromPath("image", image.path));
      var response = await request.send();
      var responseData = await http.Response.fromStream(response);
      getHeaders();
      if (responseData.statusCode == 200 || responseData.statusCode == 201) {
        customSnackBar(
            title: 'Successfull', message: 'photo addd successfully');
      } else {
        customSnackBar(title: 'failed', message: 'photo addd failed');
        if (kDebugMode) {
          print('Error ------------${responseData.body}');
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
