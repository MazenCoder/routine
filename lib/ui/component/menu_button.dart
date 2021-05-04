import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:routine/provider/menu_info.dart';

class MenuButton extends HookWidget {
  final MenuInfo currentMenuInfo;

  MenuButton(this.currentMenuInfo);

  @override
  Widget build(BuildContext context) {
    final menuInfoProvider = useProvider<MenuInfo>(currentMenuInfoProvider);
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      // validate current button
      color: currentMenuInfo.menuType == menuInfoProvider.currentTap
          ? Color(0xFF675e35)
          : Colors.transparent,
      onPressed: () {
        // check current tapped menu from provider and create
        // instance of MenuInfo to access the menu_info.dart
        menuInfoProvider.updateMenu(currentMenuInfo);
      },
      child: Column(
        children: <Widget>[
          Image.asset(
            currentMenuInfo.imageSource,
            scale: 1.5,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            currentMenuInfo.title ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
