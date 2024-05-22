import 'package:album_project/manager/font_manager.dart';
import 'package:album_project/manager/space_manger.dart';
import 'package:album_project/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'My Tasks',
              style: appFont.f18w700Black,
            ),
            appSpaces.spaceForHeight15,
            CustomButton(
                onTap: () {
                  Get.toNamed('/UserListScreen');
                },
                title: 'Task 1'),
            appSpaces.spaceForHeight10,
            CustomButton(
                onTap: () {
                  Get.toNamed('/DateSelectorScreen');
                },
                title: 'Task 2')
          ],
        ),
      )),
    );
  }
}
