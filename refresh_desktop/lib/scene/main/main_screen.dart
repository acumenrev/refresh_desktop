import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refresh_desktop/common/managers/unsplash_manager.dart';
import 'package:refresh_desktop/common/ui/side_menu/side_menu.dart';
import 'package:refresh_desktop/common/ui/side_menu/side_menu_controller.dart';
import 'package:refresh_desktop/scene/local_folder/local_folder_controller.dart';
import 'package:refresh_desktop/scene/local_folder/local_folder_screen.dart';
import 'package:refresh_desktop/scene/unsplash/unsplash_controller.dart';
import 'package:refresh_desktop/scene/unsplash/unsplash_screen.dart';

class MainScreen extends StatelessWidget {
  final SideMenuController sideMenuController;
  const MainScreen({super.key, required this.sideMenuController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Code'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
              child: Row(
            children: [_buildSideMenu(), _buildMainContent()],
          ))
        ],
      ),
    );
  }

  _buildSideMenu() {
    return SizedBox(
        width: 300, child: SideMenu(controller: sideMenuController));
  }

  _buildMainContent() {
    return Expanded(
      child: Container(color: Colors.green, child: _buildContent()),
    );
  }

  _buildContent() {
    //
    return Obx(() {
      switch (sideMenuController.currentSelectedItem.value) {
        case SideMenuIndex.localFolder:
          return LocalFolderScreen(
              controller: Get.put(LocalFolderController("")));
        case SideMenuIndex.unplash:
          return UnsplashScreen(
              controller: Get.put(
                  UnsplashController(unsplashManager: UnsplashManager())));
      }
    });
  }
}
