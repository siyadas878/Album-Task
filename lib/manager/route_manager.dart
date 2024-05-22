import 'package:album_project/presentation/album_list_screen/album_list_screen.dart';
import 'package:album_project/presentation/date_selector_screen/date_selector_screen.dart';
import 'package:album_project/presentation/photo_list_screen/photo_list_screen.dart';
import 'package:album_project/presentation/task_screen.dart/task_screen.dart';
import 'package:album_project/presentation/user_list_screen/user_list_screen.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>> appRoute() {
  return [
    GetPage(name: '/TaskScreen', page: () => const TaskScreen()),
    GetPage(
        name: '/DateSelectorScreen', page: () => const DateSelectorScreen()),
    GetPage(name: '/UserListScreen', page: () => const UserListScreen()),
    GetPage(
        name: '/AlbumListScreen',
        page: () => AlbumListScreen(
              id: Get.arguments,
            )),
    GetPage(
        name: '/PhotoListScreen',
        page: () => PhotoListScreen(
              albumId: Get.arguments,
            )),
  ];
}
