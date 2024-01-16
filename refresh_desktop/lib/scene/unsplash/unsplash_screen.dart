import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refresh_desktop/gen/assets.gen.dart';
import 'package:refresh_desktop/scene/local_folder/local_folder_item.dart';
import 'package:refresh_desktop/scene/unsplash/unsplash_controller.dart';

class UnsplashScreen extends StatelessWidget {
  final UnsplashController controller;
  final _scrollController = ScrollController();
  TextEditingController _txtSearchController = TextEditingController();
  UnsplashScreen({super.key, required this.controller}) {
    _addObservers();
  }

  _addObservers() {
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      controller.query.page += 1;
      controller.fetchPhotos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _setupUI();
  }

  _setupUI() {
    return Column(
      children: [
        TextField(
          controller: _txtSearchController,
          onChanged: (newValue) {
            controller.query.query = newValue;
            controller.fetchPhotos();
          },
          decoration: const InputDecoration(
            hintText: 'Search photos',
            border: OutlineInputBorder(),
          ),
        ),
        Expanded(
          child: Obx(() {
            return GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                controller: _scrollController,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: List.generate(controller.photos.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: LocalFolderItem(
                      imagePath: controller.photos[index].urls.thumb,
                      isNetworkImage: true,
                      placeholderImage: AppAssets.resources.images.folder
                          .image(width: 50, height: 50),
                    ),
                  );
                }));
          }),
        ),
      ],
    );
  }
}
