import 'package:album_project/core/controllers/photo_controllers.dart';
import 'package:album_project/core/repository/photo_repo.dart';
import 'package:album_project/utils/get_dimension.dart';
import 'package:album_project/utils/image_picking.dart';
import 'package:album_project/widgets/custom_button.dart';
import 'package:album_project/widgets/primary_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../manager/font_manager.dart';
import '../manager/space_manger.dart';

PhotoRepo myPhotoRepo = PhotoRepo();
final photoApiController = Get.put(PhotoController(photoRepo: myPhotoRepo));

class PhotoAddPopUp extends StatefulWidget {
  final int? id;
  final int? albumId;
  final String? title;
  final String? path;
  final bool isUpdate;

  const PhotoAddPopUp(
      {super.key,
      this.title,
      required this.isUpdate,
      this.path,
      this.albumId,
      this.id});

  @override
  State<PhotoAddPopUp> createState() => _PhotoAddPopUpState();
}

class _PhotoAddPopUpState extends State<PhotoAddPopUp> {
  final TextEditingController documentContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController attachmentController = TextEditingController();
  XFile? pickedImage;
  String source = '';

  @override
  Widget build(BuildContext context) {
    documentContoller.text = widget.title ?? '';
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add title',
                            style: appFont.f14w500Black,
                          ),
                          appSpaces.spaceForHeight6,
                          SizedBox(
                            height: 50,
                            child: PrimaryTextFormField(
                              validator: (document) {
                                if (document == null || document == '') {
                                  return "Please enter  title";
                                }
                                return null;
                              },
                              controller: documentContoller,
                            ),
                          )
                        ],
                      ),
                    ),
                    appSpaces.spaceForHeight10,
                    Text(
                      'Attachment if required',
                      style: appFont.f14w500Black,
                    ),
                    appSpaces.spaceForHeight6,
                    SizedBox(
                      height: 50,
                      child: PrimaryTextFormField(
                        validator: (attachment) {
                          if (attachment == null || attachment == '') {
                            return "Please enter attachment";
                          }
                          return null;
                        },
                        controller: attachmentController,
                        suffix: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Please Select Source'),
                                actions: [
                                  CustomButton(
                                    buttonWidth: screenWidth(context) * 0.30,
                                    title: 'Camera',
                                    onTap: () async {
                                      Get.back();
                                      final imageFile = await imagePicking(
                                          ImageSource.camera);
                                      if (imageFile != null) {
                                        setState(() {
                                          pickedImage = imageFile;
                                          attachmentController.text =
                                              imageFile.path.toString();
                                        });
                                      }
                                    },
                                  ),
                                  CustomButton(
                                    buttonWidth: screenWidth(context) * 0.30,
                                    title: 'Gallery',
                                    onTap: () async {
                                      Get.back();
                                      final imageFile = await imagePicking(
                                          ImageSource.gallery);
                                      if (imageFile != null) {
                                        setState(() {
                                          pickedImage = imageFile;
                                          attachmentController.text =
                                              imageFile.path.toString();
                                        });
                                      }
                                    },
                                  )
                                ],
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xffd6d6ee)),
                            child: Center(
                              child: Text(
                                'Upload',
                                style: appFont.f14w500Black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              appSpaces.spaceForHeight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    title: 'Cancel',
                    onTap: () {
                      Get.back();
                    },
                  ),
                  CustomButton(
                    title:
                        '${widget.isUpdate == true ? 'Update' : 'Add'} Photo',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Get.back();
                        widget.isUpdate
                            ? photoApiController.updatephoto(
                                albumId: widget.albumId ?? 0,
                                id: widget.id ?? 0,
                                image: pickedImage!,
                                title: documentContoller.text)
                            : photoApiController.addphoto(
                                albumId: widget.albumId ?? 0,
                                title: documentContoller.text,
                                image: pickedImage!);
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
