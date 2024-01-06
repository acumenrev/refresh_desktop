import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refresh_desktop/gen/assets.gen.dart';
import 'package:refresh_desktop/scene/local_folder/local_folder_controller.dart';

class LocalFolderScreen extends StatelessWidget {
  final LocalFolderController controller;
  LocalFolderScreen({super.key, required this.controller});
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return _setupUI();
  }

  Widget _setupUI() {
    return Column(
      children: [
        // picker
        _buildPickerSection(),
        // grid display all folders
        _buildGridPhotos()
      ],
    );
  }

  _buildPickerSection() {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          const SizedBox(
            width: 16.0,
          ),
          // button select
          ElevatedButton(
              onPressed: _selectFolderHandler,
              child: const Text('Select folder')),
          const SizedBox(
            width: 16,
          ),
          // label to display selected directory path
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black.withOpacity(0.8),
                      width: 1.0,
                      style: BorderStyle.solid)),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() {
                    return Text(controller.selectedDirectory.value);
                  })),
            ),
          ),
          const SizedBox(
            width: 24.0,
          )
        ],
      ),
    );
  }

  _buildGridPhotos() {
    return Expanded(
        child: SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(20, (index) {
                return Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Container(
                    child: AppAssets.resources.images.unsplash
                        .image(width: 50, height: 50),
                    padding: EdgeInsets.all(20.0),
                    height: 135.0,
                    width: 135.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                        color: Color(0xFFF9AD16),
                      ),
                    ),
                  ),
                );
              }))),
    ));
  }

  _selectFolderHandler() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory == null) {
      // User canceled the picker
    } else {
      controller.selectedDirectory.value = selectedDirectory;
    }
    debugPrint('selected directory $selectedDirectory');
  }
}
