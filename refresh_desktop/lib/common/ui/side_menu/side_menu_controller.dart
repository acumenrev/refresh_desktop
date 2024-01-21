import 'package:get/get.dart';
import 'package:refresh_desktop/common/base_controller.dart';

enum SideMenuIndex { localFolder, unplash }

enum ShuffleOptions {
  fiveSeconds,
  oneMinute,
  fiveMinutes,
  fifthteenMinutes,
  thirtyMinutes,
  oneHour,
  oneDay
}

final class SideMenuController extends BaseController {
  late Rx<SideMenuIndex> currentSelectedItem;
  late RxList<SideMenuIndex> listIndexes;
  late RxBool isRandom;
  late Rx<ShuffleOptions> shuffleOption;

  SideMenuController(SideMenuIndex selectedItem, List<SideMenuIndex> indexes,
      bool isRandom, ShuffleOptions shuffleOption) {
    currentSelectedItem = selectedItem.obs;
    listIndexes = indexes.obs;
    this.isRandom = isRandom.obs;
    this.shuffleOption = shuffleOption.obs;
  }
}
