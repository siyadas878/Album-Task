import 'package:album_project/core/controllers/album_controllers.dart';
import 'package:album_project/core/controllers/user_controllers.dart';
import 'package:album_project/core/repository/album_repo.dart';
import 'package:album_project/core/repository/user_repo.dart';
import 'package:album_project/widgets/custom_button.dart';
import 'package:album_project/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../manager/space_manger.dart';

UserRepo myUserRepo = UserRepo();
final userApiController = Get.put(UserController(userRepo: myUserRepo));

AlbumRepo myAlbumRepo = AlbumRepo();
final albumApiController = Get.put(AlbumController(albumRepo: myAlbumRepo));

class UserAddPopup extends StatefulWidget {
  final int? userId;
  final int? albumId;
  final bool isUser;
  final bool? isUpdate;
  final String? name;
  final String? email;
  final String? phone;
  final String? title;
  const UserAddPopup(
      {super.key,
      this.albumId,
      this.userId,
      this.isUpdate,
      required this.isUser,
      this.email,
      this.name,
      this.phone,
      this.title});

  @override
  State<UserAddPopup> createState() => _UserAddPopupState();
}

class _UserAddPopupState extends State<UserAddPopup> {
  final TextEditingController nameContoller = TextEditingController();
  final TextEditingController titleContoller = TextEditingController();
  final TextEditingController emailContoller = TextEditingController();
  final TextEditingController phoneContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController detailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    nameContoller.text = widget.name ?? '';
    titleContoller.text = widget.title ?? '';
    phoneContoller.text = widget.phone ?? '';
    emailContoller.text = widget.email ?? '';
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.isUser
                  ? Column(children: [
                      CustomTextField(
                        controller: nameContoller,
                        floatingTitle: 'Name',
                        hint: 'Enter the Name',
                        validator: (p0) {
                          return null;
                        },
                      ),
                      appSpaces.spaceForWidth10,
                      CustomTextField(
                        controller: emailContoller,
                        floatingTitle: 'Email',
                        hint: 'Enter the Email',
                        validator: (p0) {
                          return null;
                        },
                      ),
                      appSpaces.spaceForWidth10,
                      CustomTextField(
                        controller: phoneContoller,
                        floatingTitle: 'Phone',
                        hint: 'Enter the Phone',
                        validator: (p0) {
                          return null;
                        },
                      ),
                    ])
                  : CustomTextField(
                      controller: titleContoller,
                      floatingTitle: 'Title',
                      hint: 'Enter the Title',
                      validator: (p0) {
                        return null;
                      },
                    ),
              appSpaces.spaceForHeight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    title: 'Cancel',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Get.back();
                      }
                    },
                  ),
                  CustomButton(
                    title: widget.isUser
                        ? '${widget.isUpdate == true ? 'Update' : 'Add'} User'
                        : '${widget.isUpdate == true ? 'Update' : 'Add'} Album',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Get.back();
                        if (widget.isUpdate == true) {
                          widget.isUser
                              ? userApiController.updateUser(
                                  id: widget.userId ?? 0,
                                  name: nameContoller.text,
                                  phone: phoneContoller.text,
                                  email: emailContoller.text)
                              : albumApiController.updatealbum(
                                  id: widget.albumId ?? 0,
                                  title: titleContoller.text,
                                  userId: widget.userId ?? 0);
                        } else {
                          widget.isUser
                              ? userApiController.addUser(
                                  name: nameContoller.text,
                                  phone: phoneContoller.text,
                                  email: emailContoller.text)
                              : albumApiController.addalbum(
                                  title: titleContoller.text,
                                  userId: widget.userId ?? 0);
                        }
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
