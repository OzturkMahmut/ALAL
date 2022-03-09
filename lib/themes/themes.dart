import 'package:flutter/material.dart';
import 'theme_colors.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;
  static ThemeData currentThemeData = bouquetTheme;

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
        ));
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

  ThemeData get currentThemeDataa {
    return currentThemeData;
  }

  ThemeMode get currentThemeMode =>
      _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  void chooseTheme(int a) {
    if (a == 0) {
      currentThemeData = terraCotaTheme;
    } else if (a == 1) {
      currentThemeData = bouquetTheme;
    }

    notifyListeners();
  }
}
