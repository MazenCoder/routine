import 'package:flutter/material.dart';
import 'package:routine/provider/background_color_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class DarkModeSwitcher extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final darkModeStatusProvider = useProvider(darkmodeProvider);
    return Switch(
      value: darkModeStatusProvider.isDarkModeEnabled,
      onChanged: (enabled) {
        if (enabled) {
          darkModeStatusProvider.setDarkTheme();
        } else {
          darkModeStatusProvider.setLightTheme();
        }
      },
    );
  }
}
