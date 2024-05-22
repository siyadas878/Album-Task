import 'package:album_project/core/controllers/photo_controllers.dart';
import 'package:album_project/core/repository/photo_repo.dart';
import 'package:album_project/utils/delete_popup.dart';
import 'package:album_project/widgets/custom_cached_image.dart';
import 'package:album_project/widgets/photo_update_popup.dart';
import 'package:album_project/widgets/empty_widget.dart';
import 'package:album_project/widgets/error_widget.dart';
import 'package:album_project/widgets/simple_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PhotoListScreen extends StatefulWidget {
  final int albumId;
  const PhotoListScreen({super.key, required this.albumId});

  @override
  State<PhotoListScreen> createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  PhotoRepo? photoRepo;

  @override
  void initState() {
    photoRepo = PhotoRepo();
    super.initState();
  }

  String title = '';

  @override
  Widget build(BuildContext context) {
    final apiController = Get.put(PhotoController(photoRepo: photoRepo!));
    apiController.fetchphotos(albumId: widget.albumId);

    return SimpleScaffold(
      add: () {
        showDialog(
            context: context,
            builder: (context) => PhotoAddPopUp(
                  isUpdate: false,
                  albumId: widget.albumId,
                ));
      },
      title: 'Photos',
      hideBack: false,
      body: SafeArea(
        child: Obx(() => apiController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : (apiController.isNetworkError.value
                ? const ErrorShowingWidget()
                : apiController.photos.isEmpty
                    ? const EmptyWidget()
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: apiController.photos.length,
                        itemBuilder: (context, index) {
                          var photo = apiController.photos[index];
                          return InkWell(
                            onTap: () {},
                            child: Card(
                              child: ListTile(
                                leading: CustomNetworkImage(
                                    width: 50,
                                    height: 50,
                                    borderRadius: 30,
                                    imageName: photo.url.toString()),
                                title: Text(
                                  photo.title ?? 'No Name',
                                  maxLines: 2,
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            title = photo.title ?? '';
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  PhotoAddPopUp(
                                                    title: title,
                                                    isUpdate: true,
                                                    albumId: widget.albumId,
                                                    id: photo.id ?? 0,
                                                    path: photo.url,
                                                  ));
                                        },
                                        icon: const Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {
                                          deletePopup(
                                              context: context,
                                              onTap: () {
                                                apiController.deletePhoto(
                                                    id: photo.id ?? 0,
                                                    albumId:
                                                        photo.albumId ?? 0);
                                              });
                                        },
                                        icon: const Icon(Icons.delete)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ))),
      ),
    );
  }
}
