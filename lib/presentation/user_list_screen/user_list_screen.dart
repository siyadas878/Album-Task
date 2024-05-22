import 'package:album_project/core/controllers/user_controllers.dart';
import 'package:album_project/core/repository/user_repo.dart';
import 'package:album_project/utils/delete_popup.dart';
import 'package:album_project/widgets/empty_widget.dart';
import 'package:album_project/widgets/error_widget.dart';
import 'package:album_project/widgets/simple_scaffold.dart';
import 'package:album_project/widgets/user_add_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  UserRepo? userRepo;

  @override
  void initState() {
    userRepo = UserRepo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final apiController = Get.put(UserController(userRepo: userRepo!));
    apiController.fetchUsers();

    String name = '';
    String email = '';
    String phone = '';

    return SimpleScaffold(
      add: () {
        showDialog(
            context: context,
            builder: (context) => UserAddPopup(
                  email: email,
                  name: name,
                  phone: phone,
                  isUser: true,
                ));
      },
      title: 'Users',
      hideBack: false,
      body: SafeArea(
        child: Obx(
          () => apiController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : (apiController.isNetworkError.value
                  ? const ErrorShowingWidget()
                  : apiController.users.isEmpty
                      ? const EmptyWidget()
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemBuilder: (context, index) {
                            final user = apiController.users[index];
                            return InkWell(
                              onTap: () {
                                Get.toNamed('/AlbumListScreen',
                                    arguments: user.id);
                              },
                              child: Card(
                                child: ListTile(
                                  leading: const CircleAvatar(
                                    child: Icon(Icons.person),
                                  ),
                                  title: Text(user.name ?? 'No Name'),
                                  subtitle:
                                      Text(user.email?.toString() ?? 'No ID'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              name = user.name ?? '';
                                              email = user.email ?? '';
                                              phone = user.phone ?? '';
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    UserAddPopup(
                                                      userId: user.id ?? 0,
                                                      isUpdate: true,
                                                      email: email,
                                                      name: name,
                                                      phone: phone,
                                                      isUser: true,
                                                    ));
                                          },
                                          icon: const Icon(Icons.edit)),
                                      IconButton(
                                          onPressed: () {
                                            deletePopup(
                                                context: context,
                                                onTap: () {
                                                  apiController.deleteUser(
                                                      id: user.id ?? 0);
                                                });
                                          },
                                          icon: const Icon(Icons.delete)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: apiController.users.length,
                        )),
        ),
      ),
    );
  }
}
