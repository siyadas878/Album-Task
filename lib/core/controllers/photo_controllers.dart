import 'package:album_project/core/models/photo_model.dart';
import 'package:album_project/core/repository/photo_repo.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PhotoController extends GetxController {
  final PhotoRepo photoRepo;
  PhotoController({required this.photoRepo});

  RxBool isLoading = false.obs;
  RxBool isNetworkError = false.obs;
  RxList<PhotoModel> photos = <PhotoModel>[].obs;

  Future<void> fetchphotos({required int albumId}) async {
    isLoading.value = true;

    try {
      final fetchedphotos = await photoRepo.getAllPhotos(albumId: albumId);

      if (fetchedphotos != null) {
        photos.value = fetchedphotos;
      } else {
        isNetworkError.value = true;
      }
    } catch (error) {
      isNetworkError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deletePhoto({required int id, required int albumId}) async {
    isLoading.value = true;

    try {
      await photoRepo
          .deletePhoto(id: id)
          .then((value) => photoRepo.getAllPhotos(albumId: albumId));
    } catch (error) {
      isNetworkError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addphoto(
      {required int albumId,
      required String title,
      required XFile image}) async {
    isLoading.value = true;

    try {
      await photoRepo
          .addPhoto(title: title, image: image)
          .then((value) => photoRepo.getAllPhotos(albumId: albumId));
    } catch (error) {
      isNetworkError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatephoto(
      {required int id,
      required int albumId,
      required String title,
      required XFile image}) async {
    isLoading.value = true;

    try {
      await photoRepo
          .updatePhoto(id: id, title: title, image: image)
          .then((value) => photoRepo.getAllPhotos(albumId: albumId));
    } catch (error) {
      isNetworkError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
