import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/route_manager.dart';
import 'package:refresh_desktop/common/managers/app_utils.dart';
import 'package:refresh_desktop/common/ui/side_menu/side_menu_controller.dart';
import 'package:refresh_desktop/scene/main/main_screen.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1200, 800),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    WindowManager.instance.setMinimumSize(const Size(800, 600));
  }

  workManager.initialize(AppUtils.callbackDispatcher);
  workManager.registerPeriodicTask(
    'myTask',
    'myTaskName',
    frequency: const Duration(seconds: 5),
  );
  await dotenv.load(fileName: ".env");

  runApp(GetMaterialApp(
    home: MainScreen(
      sideMenuController: SideMenuController(SideMenuIndex.localFolder,
          SideMenuIndex.values, false, ShuffleOptions.fiveSeconds),
    ),
  ));
}
