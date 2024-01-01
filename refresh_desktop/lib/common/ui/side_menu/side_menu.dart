import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:refresh_desktop/common/ui/side_menu/side_menu_controller.dart';
import 'package:refresh_desktop/common/ui/side_menu/side_menu_item.dart';

class SideMenu extends StatelessWidget {
  final SideMenuController controller;
  SideMenu({super.key, required this.controller});
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        children: _buildListContent(
            controller.listIndexes, controller.currentSelectedItem.value),
      );
    });
  }

  /// Return list content
  ///
  /// [items] items for
  List<Widget> _buildListContent(
      List<SideMenuIndex> items, SideMenuIndex selectedItem) {
    List<Widget> result = items.map((e) {
      return SideMenuItem(
        index: e,
        isItemSelected: e == selectedItem,
        selectedHandler: () {
          controller.currentSelectedItem.value = e;
        },
      );
    }).toList();
    return result;
  }
}
