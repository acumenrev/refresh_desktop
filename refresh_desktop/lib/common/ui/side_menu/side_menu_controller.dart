import 'package:get/get.dart';
import 'package:refresh_desktop/common/base_controller.dart';

enum SideMenuIndex { localFolder, unplash }

final class SideMenuController extends BaseController {
  late Rx<SideMenuIndex> currentSelectedItem;
  late RxList<SideMenuIndex> listIndexes;

  SideMenuController(SideMenuIndex selectedItem, List<SideMenuIndex> indexes) {
    currentSelectedItem = selectedItem.obs;
    listIndexes = indexes.obs;
  }
}
