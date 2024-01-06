import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LocalFolderItem extends StatelessWidget {
  final String imagePath;
  final bool isNetworkImage;
  final Image placeholderImage;
  const LocalFolderItem(
      {super.key,
      required this.imagePath,
      required this.isNetworkImage,
      required this.placeholderImage});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.white, width: 2.0)),
        child: isNetworkImage
            ? _loadImageFromNetwork(imagePath)
            : _loadImageFromLocal(imagePath));
  }

  _loadImageFromNetwork(String imgUrl) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: imgUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  _loadImageFromLocal(String imgPath) {
    return Image.file(
      File(imgPath),
      fit: BoxFit.cover,
    );
  }
}
