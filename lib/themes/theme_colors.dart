import 'package:flutter/material.dart';



class CustomColors {
  static const Color lightPurple = Color(0xFFBB86FA);
  static const Color purple = Color(0xFF6002EE);
  static const Color deepPurple = Color(0xFF3900B1);
  static const Color grey = Color(0xFF848484);
  static const Color darkGrey = Color(0xFF222222);
  static const Color black = Color(0xFF141414);

  //https://coolors.co/f4f1de-e07a5f-3d405b-81b29a-f2cc8f
  static const Color eggshell = Color.fromARGB(255, 244, 241, 222);
  static const Color terraCota = Color.fromARGB(255, 224, 122, 95);
  static const Color independence = Color.fromARGB(255, 61, 64, 91);
  static const Color greenSheen = Color.fromARGB(255, 129, 178, 154);
  static const Color deepChampagne = Color.fromARGB(255, 242, 204, 143);
  static const Color bouquet = Color(0xffb2819a);
}


class ColorPalettes { 
  //https://maketintsandshades.com/#E07A5F
  
  static const MaterialColor terraCotaPalette = MaterialColor( 
    0xffe07a5f, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
    <int, Color>{ 
      50:   Color(0xffca6e56 ),//10% 
      100:  Color(0xffb3624c),//20% 
      200:  Color(0xff9d5543),//30% 
      300:  Color(0xff864939),//40% 
      400:  Color(0xff703d30),//50% 
      500:  Color(0xff5a3126),//60% 
      600:  Color(0xff43251c),//70% 
      700:  Color(0xff2d1813),//80% 
      800:  Color(0xff160c09),//90% 
      900:  Color(0xff000000),//100% 
    }, 
  );

  static const MaterialColor bouquetPalette = MaterialColor( 
    0xffb2819a, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
    <int, Color>{ 
      50:   Color(0xffa0748b ),//10% 
      100:  Color(0xff8e677b),//20% 
      200:  Color(0xff7d5a6c),//30% 
      300:  Color(0xff6b4d5c),//40% 
      400:  Color(0xff59414d),//50% 
      500:  Color(0xff47343e),//60% 
      600:  Color(0xff35272e),//70% 
      700:  Color(0xff241a1f),//80% 
      800:  Color(0xff120d0f),//90% 
      900:  Color(0xff000000),//100% 
    }, 
  );  
}