import 'package:flutter/material.dart';
import 'package:refresh_desktop/common/ui/side_menu/side_menu_controller.dart';
import 'package:refresh_desktop/gen/assets.gen.dart';

class SideMenuItem extends StatelessWidget {
  final SideMenuIndex index;
  final bool isItemSelected;
  final VoidCallback selectedHandler;
  const SideMenuItem(
      {super.key,
      required this.index,
      required this.isItemSelected,
      required this.selectedHandler});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selectedHandler,
      child: Container(
        color:
            isItemSelected ? Colors.green.withOpacity(0.3) : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // icon
              _buildIcon(index, const Size(30, 30), isItemSelected),
              const SizedBox(
                width: 10.0,
              ),
              // text
              _buildText(index, isItemSelected)
            ],
          ),
        ),
      ),
    );
  }

  _buildIcon(SideMenuIndex index, Size size, bool isSelected) {
    switch (index) {
      case SideMenuIndex.localFolder:
        return AppAssets.resources.images.folder
            .image(width: size.width, height: size.height);
      case SideMenuIndex.unplash:
        return AppAssets.resources.images.unsplash
            .image(width: size.width, height: size.height);
      default:
        return AppAssets.resources.images.folder
            .image(width: size.width, height: size.height);
    }
  }

  _buildText(SideMenuIndex index, bool isSelected) {
    String content = "";
    switch (index) {
      case SideMenuIndex.localFolder:
        content = "Disk";
      case SideMenuIndex.unplash:
        content = "Unplash";
      default:
        break;
    }
    FontWeight fontWeight = isSelected ? FontWeight.w800 : FontWeight.w400;
    return Text(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.black, fontSize: 16.0, fontWeight: fontWeight),
    );
  }
}
