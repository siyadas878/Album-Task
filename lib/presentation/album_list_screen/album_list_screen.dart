import 'package:album_project/core/controllers/album_controllers.dart';
import 'package:album_project/core/repository/album_repo.dart';
import 'package:album_project/utils/delete_popup.dart';
import 'package:album_project/widgets/empty_widget.dart';
import 'package:album_project/widgets/error_widget.dart';
import 'package:album_project/widgets/photo_update_popup.dart';
import 'package:album_project/widgets/simple_scaffold.dart';
import 'package:album_project/widgets/user_add_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlbumListScreen extends StatefulWidget {
  final int id;
  const AlbumListScreen({super.key, required this.id});

  @override
  State<AlbumListScreen> createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  AlbumRepo? albumRepo;

  @override
  void initState() {
    albumRepo = AlbumRepo();
    super.initState();
  }

  String title = '';

  @override
  Widget build(BuildContext context) {
    final apiController = Get.put(AlbumController(albumRepo: albumRepo!));
    apiController.fetchalbums(userId: widget.id);

    return SimpleScaffold(
      title: 'Albums',
      hideBack: false,
      body: SafeArea(
        child: Obx(
          () => apiController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : (apiController.isNetworkError.value
                  ? const ErrorShowingWidget()
                  : apiController.albums.isEmpty
                      ? const EmptyWidget()
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemBuilder: (context, index) {
                            final album = apiController.albums[index];
                            return InkWell(
                              onTap: () {
                                Get.toNamed('/PhotoListScreen',
                                    arguments: album.id);
                              },
                              child: Card(
                                child: ListTile(
                                  leading: const CircleAvatar(
                                    child: Icon(Icons.photo_album),
                                  ),
                                  title: Text(
                                    album.title ?? 'No Name',
                                    maxLines: 2,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              title = album.title ?? '';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    UserAddPopup(
                                                      isUser: false,
                                                      title: title,
                                                      albumId: album.id ?? 0,
                                                    ));
                                          },
                                          icon: const Icon(Icons.edit)),
                                      IconButton(
                                          onPressed: () {
                                            deletePopup(
                                                context: context,
                                                onTap: () {
                                                  apiController.deleteAlbum(
                                                      id: album.id ?? 0,
                                                      userId:
                                                          album.userId ?? 0);
                                                });
                                          },
                                          icon: const Icon(Icons.delete)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: apiController.albums.length,
                        )),
        ),
      ),
      add: () {
        showDialog(
            context: context,
            builder: (context) => UserAddPopup(
                  title: title,
                  isUser: false,
                ));
      },
    );
  }
}
