import 'package:album_project/core/models/user_model.dart';
import 'package:album_project/core/repository/user_repo.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepo userRepo;
  UserController({required this.userRepo});

  RxBool isLoading = false.obs;
  RxBool isNetworkError = false.obs;
  RxList<UserModel> users = <UserModel>[].obs;

  Future<void> fetchUsers() async {
    isLoading.value = true;

    try {
      final fetchedUsers = await userRepo.getAllUsers();

      if (fetchedUsers != null) {
        users.value = fetchedUsers;
      } else {
        isNetworkError.value = true;
      }
    } catch (error) {
      isNetworkError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteUser({required int id}) async {
    isLoading.value = true;

    try {
      await userRepo.deleteUser(id: id).then((value) => userRepo.getAllUsers());
    } catch (error) {
      isNetworkError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addUser(
      {required String name,
      required String phone,
      required String email}) async {
    isLoading.value = true;

    try {
      await userRepo
          .addUser(email: email, name: name, phone: phone)
          .then((value) => userRepo.getAllUsers());
    } catch (error) {
      isNetworkError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUser(
      {required int id,
      required String name,
      required String phone,
      required String email}) async {
    isLoading.value = true;

    try {
      await userRepo
          .updateUser(id: id, email: email, name: name, phone: phone)
          .then((value) => userRepo.getAllUsers());
    } catch (error) {
      isNetworkError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
