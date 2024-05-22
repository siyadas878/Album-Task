import 'package:album_project/core/models/album_model.dart';
import 'package:album_project/core/models/user_model.dart';
import 'package:album_project/core/repository/album_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AlbumController extends GetxController {
  final AlbumRepo albumRepo;
  AlbumController({required this.albumRepo});

  RxBool isLoading = false.obs;
  RxBool isNetworkError = false.obs;
  RxList<AlbumModel> albums = <AlbumModel>[].obs;

  Future<void> fetchalbums({required int userId}) async {
    isLoading.value = true;

    try {
      final fetchedalbums = await albumRepo.getAllalbums(userId: userId);

      if (fetchedalbums != null) {
        albums.value = fetchedalbums;
      } else {
        isNetworkError.value = true;
      }
    } catch (error) {
      isNetworkError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteAlbum({required int id, required int userId}) async {
    isLoading.value = true;

    try {
      await albumRepo
          .deleteAlbums(id: id)
          .then((value) => albumRepo.getAllalbums(userId: userId));
    } catch (error) {
      isNetworkError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addalbum({required int userId, required String title}) async {
    isLoading.value = true;

    try {
      await albumRepo
          .addAlbum(title: title)
          .then((value) => albumRepo.getAllalbums(userId: userId));
    } catch (error) {
      isNetworkError.value = true;
      if (kDebugMode) {}
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatealbum(
      {required int id, required int userId, required String title}) async {
    isLoading.value = true;

    try {
      await albumRepo
          .updateAlbum(id: id, title: title)
          .then((value) => albumRepo.getAllalbums(userId: userId));
    } catch (error) {
      isNetworkError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
