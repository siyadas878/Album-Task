import 'package:album_project/manager/color_manager.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: appColors.appGrey,
    );
  }
}
