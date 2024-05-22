import 'dart:convert';

import 'package:album_project/core/models/album_model.dart';
import 'package:album_project/manager/url_manager.dart';
import 'package:album_project/widgets/custom_snackBar.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class AlbumRepo {
  //List all albums
  Future<List<AlbumModel>?> getAllalbums({required int userId}) async {
    try {
      final response = await get(
          baseUrl(
            endPoint: 'albums',
          ),
          headers: getHeaders());
      if (response.statusCode == 200) {
        final List<AlbumModel> allAlbums =
            AlbumModel.fromList(jsonDecode(response.body));

        List<AlbumModel> sortedAlbums = [];
        for (var element in allAlbums) {
          if (element.userId == userId) {
            sortedAlbums.add(element);
          }
        }
        if (kDebugMode) {
          print(response.body);
        }
        return sortedAlbums;
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

  //delete album
  Future<void> deleteAlbums({required int id}) async {
    try {
      final response = await delete(
          baseUrl(
            endPoint: 'albums/$id',
          ),
          headers: getHeaders());
      if (response.statusCode == 200) {
        customSnackBar(
            title: 'Successfull', message: 'Album deleted successfully');
      } else {
        customSnackBar(title: 'failed', message: 'Album deleted failed');
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

  //add album
  Future<void> addAlbum({required String title}) async {
    try {
      final response = await post(
          baseUrl(
            endPoint: 'albums',
          ),
          body: jsonEncode({
            {"title": title}
          }),
          headers: getHeaders());
      if (response.statusCode == 200 || response.statusCode == 201) {
        customSnackBar(
            title: 'Successfull', message: 'Album addd successfully');
      } else {
        customSnackBar(title: 'failed', message: 'Album addd failed');
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

  //update album
  Future<void> updateAlbum({required int id, required String title}) async {
    try {
      final response = await patch(
          baseUrl(
            endPoint: 'albums/$id',
          ),
          body: jsonEncode({
            {"title": title}
          }),
          headers: getHeaders());
      if (kDebugMode) {
        print('response ------------${response.body}');
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        customSnackBar(
            title: 'Successfull', message: 'Album update successfully');
      } else {
        customSnackBar(title: 'failed', message: 'Album update failed');
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
