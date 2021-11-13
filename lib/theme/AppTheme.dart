import 'package:fad_shee/theme/AppColors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(
      fontFamily: 'Overlock',
      primaryColor: AppColors.red,
      scaffoldBackgroundColor: Colors.white,
      textTheme: ThemeData.light().textTheme.copyWith(
            headline1: TextStyle(fontSize: 26, fontFamily: 'Overlock', fontWeight: FontWeight.w700),
            headline2: TextStyle(fontSize: 20, fontFamily: 'Overlock', fontWeight: FontWeight.w700),
            headline3: TextStyle(fontSize: 20, fontFamily: 'Overlock', fontWeight: FontWeight.w900),
            headline4: TextStyle(fontSize: 17, fontFamily: 'Overlock', fontWeight: FontWeight.w900),
            headline5: TextStyle(fontSize: 16, fontFamily: 'Overlock', fontWeight: FontWeight.w700),
            headline6: TextStyle(fontSize: 14, fontFamily: 'Overlock', fontWeight: FontWeight.w600),
            button: TextStyle(fontSize: 15, fontFamily: 'Overlock', fontWeight: FontWeight.w600),
            bodyText1: TextStyle(fontSize: 16, fontFamily: 'Overlock'),
            bodyText2: TextStyle(fontSize: 14, fontFamily: 'Overlock'),
            subtitle1: TextStyle(fontSize: 13, fontFamily: 'Overlock'),
            subtitle2: TextStyle(fontSize: 11, fontFamily: 'Overlock'),
          ),
    );
  }
}
