import 'package:get/get.dart';
import 'package:refresh_desktop/common/base_controller.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class LocalFolderController extends BaseController {
  late RxString selectedDirectory;
  RxList directoryImagePaths = [].obs;
  RxBool isIncludeSubfolders = false.obs;

  LocalFolderController(String directory) {
    selectedDirectory = directory.obs;
    _setupObservers();
  }

  _setupObservers() {
    selectedDirectory.listen((p0) {
      // directory change
      _getImagesInDirectory(p0);
    });
    isIncludeSubfolders.listen((p0) {
      _getImagesInDirectory(selectedDirectory.value);
    });
  }

  _getImagesInDirectory(String directoryPath) async {
    List<String> imagePaths = [];
    Directory directory;

    // Get the application's temporary directory
    directory = Directory(directoryPath);

    // You can also use getApplicationDocumentsDirectory() or getExternalStorageDirectory()

    if (directory.existsSync()) {
      List<FileSystemEntity> files =
          directory.listSync(recursive: isIncludeSubfolders.value);

      for (FileSystemEntity file in files) {
        if (file is File) {
          String filePath = file.path;
          String extension = path.extension(filePath).toLowerCase();

          // Add only files with image extensions
          if (extension == '.jpg' ||
              extension == '.jpeg' ||
              extension == '.png' ||
              extension == '.gif') {
            imagePaths.add(filePath);
          }
        }
      }
    }
    directoryImagePaths.value = imagePaths;
  }
}
