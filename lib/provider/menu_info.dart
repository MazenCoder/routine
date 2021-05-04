import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:routine/models/enums.dart';

// Provider that passes instance of Menuinfo
final currentMenuInfoProvider = ChangeNotifierProvider<MenuInfo>((ref) {
  return MenuInfo(MenuType.clock);
});

class MenuInfo extends ChangeNotifier {
  MenuType menuType;
  String title;
  String imageSource;

  MenuInfo(this.menuType, {this.title, this.imageSource});

  // getter for menubar color change
  MenuType get currentTap {
    return menuType;
  }

  // method that update the value of menuType, title, and imageSource
  updateMenu(MenuInfo menuInfo) {
    this.menuType = menuInfo.menuType;
    this.title = menuInfo.title;
    this.imageSource = menuInfo.imageSource;

    // Notify since the value changes in this method
    notifyListeners();
  }
}
