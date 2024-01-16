import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refresh_desktop/common/base_controller.dart';
import 'package:refresh_desktop/common/managers/unsplash_manager.dart';
import 'package:refresh_desktop/models/photo_model.dart';

class UnsplashController extends BaseController {
  late UnsplashManager unsplashManager;
  final Duration debounceDuration = const Duration(milliseconds: 500);
  final _photos = <UnsplashPhoto>[].obs;
  final int limit = 20;
  late UnsplashQuery query;
  List<UnsplashPhoto> get photos => _photos.toList();
  UnsplashController({required this.unsplashManager}) {
    query = UnsplashQuery(page: 1, perPage: limit, query: '');
    _setupObservers();
  }

  _setupObservers() {
    _photos.stream.listen((event) {
      debugPrint('new photos emitted: ${event.length}');
    });
  }

  fetchPhotos() {
    EasyDebounce.debounce('debounce-fetch-photos', debounceDuration, () {
      debugPrint("fetch photos");
      unsplashManager.queryImages(query: query).then((value) {
        if (value != null) {
          if (query.page == 0) {
            // refresh
            _photos.clear();
          }
          _photos.addAll(value.results);
        }
      });
    });
  }
}
