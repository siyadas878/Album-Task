import 'package:album_project/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../manager/color_manager.dart';
import '../manager/font_manager.dart';

class SimpleScaffold extends StatelessWidget {
  final bool? floatingButton;
  final String title;
  final Widget body;
  final Widget? bottomWidget;
  final Widget? bottomNavBar;
  final bool? hideBack;
  final Function()? onBack;
  final Function()? add;
  const SimpleScaffold(
      {super.key,
      this.floatingButton,
      required this.title,
      required this.body,
      this.bottomWidget,
      this.bottomNavBar,
      this.onBack,
      this.add,
      this.hideBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        surfaceTintColor: Colors.grey[100],
        //elevation: 5,
        shadowColor: Colors.grey,
        leading: hideBack ?? false
            ? const SizedBox()
            : CustomBackButton(
                onTap: () {
                  if (onBack != null) {
                    onBack!();
                  } else {
                    Get.back();
                  }
                },
              ),
        title: Text(
          title,
          style: appFont.f16w600Black,
        ),
        centerTitle: true,
      ),
      body: body,
      bottomSheet: bottomWidget,
      bottomNavigationBar: bottomNavBar,
      floatingActionButton: floatingButton == false
          ? null
          : FloatingActionButton(
              onPressed: () {
                add!();
              },
              child: const Icon(Icons.add),
            ),
    );
  }
}

class CustomBackButton extends StatelessWidget {
  final double? kwidth;
  final double? kheight;
  final Function() onTap;
  const CustomBackButton(
      {super.key, required this.onTap, this.kheight, this.kwidth});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: kheight ?? 10,
        width: kwidth ?? 10,
        margin: const EdgeInsets.all(14),
        padding: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: appColors.appGrey!)),
        child: Icon(
          Icons.arrow_back_ios,
          color: appColors.brandDark,
          size: 18,
        ),
      ),
    );
  }
}
