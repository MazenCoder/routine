import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:routine/home.dart';
import 'package:routine/provider/background_color_provider.dart';

import 'constant/apptheme_color.dart';


class RoutineApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final appBackgroundColor = useProvider(darkmodeProvider);

    return MaterialApp(
      title: 'Morning Routine',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appBackgroundColor.isDarkModeEnabled
          ? ThemeMode.dark
          : ThemeMode.light,
      home: Home(),
    );
  }
}
