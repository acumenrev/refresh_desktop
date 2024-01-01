import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:refresh_desktop/common/ui/side_menu/side_menu_controller.dart';
import 'package:refresh_desktop/scene/main/main_screen.dart';

void main() {
  runApp(GetMaterialApp(
    home: MainScreen(
      sideMenuController:
          SideMenuController(SideMenuIndex.localFolder, SideMenuIndex.values),
    ),
  ));
}
