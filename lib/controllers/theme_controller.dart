import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  var isDark = false.obs;
  Map<String, ThemeMode> themeModes = {
    'light': ThemeMode.light,
    'dark': ThemeMode.dark,
  };

  late SharedPreferences prefs;

  static ThemeController get to => Get.find();

  loadThemeMode() async {
    prefs = await SharedPreferences.getInstance();
    String themeText = prefs.getString('theme') ?? 'light';
    print('themeText $themeText');
    isDark.value = themeText == 'dark' ? true : false;
    setMode(themeText);
  }

  Future setMode(String themeText) async {
    ThemeMode themeMode = themeModes[themeText]!;
    Get.changeThemeMode(themeMode);
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', themeText);
  }

  changeTheme() {
    setMode(isDark.value ? 'light' : 'dark');
    isDark.value = !isDark.value;
  }
}
