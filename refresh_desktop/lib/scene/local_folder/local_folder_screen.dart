import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refresh_desktop/scene/local_folder/local_folder_controller.dart';

class LocalFolderScreen extends StatelessWidget {
  final LocalFolderController controller;
  const LocalFolderScreen({super.key, required this.controller});

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
    return Container();
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
