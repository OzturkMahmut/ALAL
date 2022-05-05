import 'package:flutter/material.dart';
import 'theme_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;
  static ThemeData currentThemeData = bouquetTheme;
  static int currentThemeIndex = 0;

  Future<void> storePref(int themeIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('ThemePref')) {
      prefs.setInt('ThemePref', 0);
    } else {
      prefs.setInt('ThemePref', themeIndex);
    }
  }

    Future<int> getPref() async {
    late  int themeIndex;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('ThemePref')) {
      prefs.setInt('ThemePref', 0);
    } else {
      themeIndex = prefs.getInt('ThemePref')!;
    }
    return themeIndex;
  }
  
  

  static ThemeData get terraCotaTheme {
    return ThemeData(
      primarySwatch: ColorPalettes
          .terraCotaPalette, // defining colors for widgets like AppBar, FAB, etc.
      brightness: Brightness.light,
      //colorScheme: ColorScheme(secondary: Colors.black,brightness: Brightness.light,) ,
      scaffoldBackgroundColor: CustomColors.eggshell,
      fontFamily: 'Helvetica',
      cardColor: CustomColors.independence,
      buttonTheme: ButtonThemeData(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: CustomColors.lightPurple,
      ),
    );
  }

  static ThemeData get bouquetTheme {
    return ThemeData(
      primarySwatch: ColorPalettes
          .bouquetPalette, // defining colors for widgets like AppBar, FAB, etc.
      brightness: Brightness.light,
      //colorScheme: ColorScheme(secondary: Colors.black,brightness: Brightness.light,) ,
      scaffoldBackgroundColor: CustomColors.eggshell,
      fontFamily: 'Helvetica',
      cardColor: CustomColors.independence,
      buttonTheme: ButtonThemeData(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: CustomColors.lightPurple,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: ColorPalettes.bouquetPalette,
      brightness: Brightness.dark,
      //scaffoldBackgroundColor: CustomColors.independence,
      fontFamily: 'Helvetica',
      textTheme: ThemeData.dark().textTheme,
      buttonTheme: ButtonThemeData(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: CustomColors.lightPurple,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: ColorPalettes.bouquetPalette,
          foregroundColor: Colors.white),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: ColorPalettes.bouquetPalette,
        unselectedItemColor: CustomColors.eggshell,
      ),
    );
  }

  ThemeData get getCurrentThemeData {
    return currentThemeData;
  }

  ThemeMode get currentThemeMode {
    return _isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  }

  int get currentThemeIndexData {
    return currentThemeIndex;
  }

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  void chooseTheme(int a) {
    if (a == 0) {
      currentThemeData = terraCotaTheme;
      currentThemeIndex = 0;
      storePref(a);
    } else if (a == 1) {
      currentThemeData = bouquetTheme;
      currentThemeIndex = 1;
      storePref(a);
    }
    notifyListeners();
  }
}
