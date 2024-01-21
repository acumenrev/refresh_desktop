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
      return Column(
        children: [
          Expanded(
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              children: _buildListContent(
                  controller.listIndexes, controller.currentSelectedItem.value),
            ),
          ),
          _buildControlMenu()
        ],
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

  _buildControlMenu() {
    return SizedBox(
      height: 200,
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            // shuffle
            _buildShuffleMenu(),
            // content fit
            _buildContentFitMenu()
          ],
        ),
      ),
    );
  }

  _buildShuffleMenu() {
    return Obx(() {
      return SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Row(
            children: [
              // label
              const Text('Shuffle'),
              const SizedBox(
                width: 20,
              ),
              DropdownButton<ShuffleOptions>(
                value: controller.shuffleOption.value,
                onChanged: (newValue) {
                  if (newValue != null) {
                    controller.shuffleOption.value = newValue;
                  }
                },
                items: ShuffleOptions.values.map((ShuffleOptions value) {
                  return DropdownMenuItem<ShuffleOptions>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _getShuffleOptionText(value),
                        style: const TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.normal),
                      ),
                    ),
                  );
                }).toList(),
                hint: const Text('Select an option'),
              )
            ],
          ),
        ),
      );
    });
  }

  String _getShuffleOptionText(ShuffleOptions option) {
    String result = "Every ";
    String time = "";
    switch (option) {
      case ShuffleOptions.fiveSeconds:
        time = "5 seconds ";
      case ShuffleOptions.oneMinute:
        time = "Minute";
      case ShuffleOptions.fiveMinutes:
        time = "5 Minutes";
      case ShuffleOptions.fifthteenMinutes:
        time = "15 Minutes";
      case ShuffleOptions.thirtyMinutes:
        time = "30 Minutes";
      case ShuffleOptions.oneHour:
        time = "Hour";
      case ShuffleOptions.oneDay:
        time = "Day";
    }

    result += time;

    return result;
  }

  _buildContentFitMenu() {
    return Obx(() {
      return SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: Row(
            children: [
              Checkbox(
                value: controller.isRandom.value,
                onChanged: (bool? value) {
                  if (value != null) {
                    controller.isRandom.value = value;
                  }
                },
              ),
              const Text('Randomly')
            ],
          ),
        ),
      );
    });
  }
}
