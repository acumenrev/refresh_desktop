import 'package:get/get.dart';
import 'package:refresh_desktop/common/base_controller.dart';

class LocalFolderController extends BaseController {
  late RxString selectedDirectory;
  LocalFolderController(String directory) {
    selectedDirectory = directory.obs;
  }
}
