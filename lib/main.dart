import 'package:album_project/manager/color_manager.dart';
import 'package:album_project/manager/route_manager.dart';
import 'package:album_project/presentation/album_list_screen/album_list_screen.dart';
import 'package:album_project/presentation/date_selector_screen/date_selector_screen.dart';
import 'package:album_project/presentation/photo_list_screen/photo_list_screen.dart';
import 'package:album_project/presentation/task_screen.dart/task_screen.dart';
import 'package:album_project/presentation/user_list_screen/user_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Album Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.grey,
        colorScheme: ColorScheme.fromSeed(seedColor: appColors.brandDark),
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.white),
        scaffoldBackgroundColor: Colors.grey[100],
        useMaterial3: true,
      ),
      getPages: appRoute(),
      initialRoute: '/TaskScreen',
    );
  }
}
