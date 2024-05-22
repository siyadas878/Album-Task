import 'package:album_project/manager/font_manager.dart';
import 'package:album_project/manager/space_manger.dart';
import 'package:album_project/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

deletePopup({required BuildContext context, required Function onTap}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 50,
        child: Center(
            child: SizedBox(
                width: 150,
                child: Center(
                  child: SizedBox(
                      child: Text(
                    'Are you sure to Delete',
                    textAlign: TextAlign.center,
                    style: appFont.f16w600Black,
                  )),
                ))),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              title: 'Back',
              onTap: () async {
                Get.back();
              },
            ),
            appSpaces.spaceForWidth5,
            CustomButton(
                delete: true,
                title: 'Detete',
                onTap: () async {
                  Get.back();
                  onTap();
                }),
          ],
        )
      ],
    ),
  );
}
