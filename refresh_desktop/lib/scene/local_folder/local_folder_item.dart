import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:refresh_desktop/common/managers/app_utils.dart';
import 'package:refresh_desktop/gen/assets.gen.dart';

class LocalFolderItem extends StatelessWidget {
  final String imagePath;
  final bool isNetworkImage;
  final Image placeholderImage;
  final StringCallback onTap;
  const LocalFolderItem(
      {super.key,
      required this.imagePath,
      required this.isNetworkImage,
      required this.placeholderImage,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint('selected image path: $imagePath');
        onTap(imagePath);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.white, width: 2.0)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          clipBehavior: Clip.hardEdge,
          child: Container(
              child: isNetworkImage
                  ? _loadImageFromNetwork(imagePath)
                  : _loadImageFromLocal(imagePath)),
        ),
      ),
    );
  }

  _loadImageFromNetwork(String imgUrl) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: imgUrl,
      placeholder: (context, url) {
        return AppAssets.resources.images.placeholderImage
            .image(width: 100, height: 100);
      },
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  _loadImageFromLocal(String imgPath) {
    return FadeInImage(
        placeholderFit: BoxFit.cover,
        placeholder: const AssetImage("resources/images/placeholder_image.png"),
        fit: BoxFit.cover,
        image: FileImage(File(imgPath)));
  }
}
