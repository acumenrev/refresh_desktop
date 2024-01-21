import 'package:desktop_wallpaper_set/desktop_wallpaper_set.dart';
import 'package:desktop_wallpaper_set/type.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:workmanager/workmanager.dart';

typedef StringCallback = void Function(String);
final _desktopWallpaperSetPlugin = DesktopWallpaperSet();
final Workmanager workManager = Workmanager();

class AppUtils {
  /// Set desktop wallpaper
  /// @param filePath the file path location
  static Future<bool> setDesktopWallpaper(filePath) async {
    String result = await _desktopWallpaperSetPlugin.setWallpaper(
            filePath, WallpaperType.img) ??
        "failed";
    debugPrint('setWallpaper result: $result');
    return Future.value(result != "failed");
  }

  static void callbackDispatcher() {
    workManager.executeTask((task, inputData) {
      // Perform the background task here.
      debugPrint('Background task executed');
      return Future.value(true);
    });
  }
}
