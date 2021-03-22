import 'package:flutter/material.dart';

import 'AppColors.dart';
import 'AppFontsSize.dart';

abstract class AppTextStyle {
// -------------------- white



  static final largeWhiteBold = TextStyle(
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.large_font_size),
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  );

  static String segoePrint = 'Segoe Print';
  static String cairo = 'Cairo';
  static String segoeUI = 'Segoe UI';


  static final normalWhite = TextStyle(
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
    color: AppColors.white,
  );
  static final normalWhiteBold = TextStyle(
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  );

  static final mediumWhite = TextStyle(
    color: AppColors.white,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
  );

  static final mediumWhiteBold = TextStyle(
    color: AppColors.white,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
    fontWeight: FontWeight.bold,
  );

  static final smallWhite = TextStyle(
    color: AppColors.white,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
  );
  static final smallWhiteBold = TextStyle(
    color: AppColors.white,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
    fontWeight: FontWeight.bold
  );

  static final xSmallWhite = TextStyle(
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
    color: Colors.white,
  );

  static final xSmallWhiteBold = TextStyle(
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
    color: Colors.white,
    fontWeight: FontWeight.bold
  );

  static final xxSmallWhiteBold = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    fontSize: AppFontsSize.getScaledFontSize(
        AppFontsSize.xx_small_font_size),
  );

//------------------------  yellow
  static final smallYellowBold = TextStyle(
    color: AppColors.deepYellow,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
    fontWeight: FontWeight.bold,
  );


//------------------------ DeepGray
  static final smallDeepGray = TextStyle(
    color: AppColors.deepGray,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
  );


  static final xSmallDeepGray = TextStyle(
    color: AppColors.deepGray,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
  );

  static final xxSmallDeepGray = TextStyle(
    color: AppColors.deepGray,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.xx_small_font_size),
  );


  static final mediumDeepGrayBold = TextStyle(
    color: AppColors.deepGray,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
    fontWeight: FontWeight.bold,
  );

  static final mediumDeepGray = TextStyle(
    color: AppColors.deepGray,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
  );

//  ---------------------- black


  static final largeBlackBold = TextStyle(
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.large_font_size),
    color: AppColors.black,
    fontWeight: FontWeight.bold,
  );

  static final largeBlack = TextStyle(
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.large_font_size),
    color: AppColors.black,
  );


  static final normalBlackBold = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
    fontWeight: FontWeight.bold,
  );

  static final normalBlack = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
  );
  static final mediumBlack = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
  );

  static final mediumBlackBold = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
    fontWeight: FontWeight.bold,
  );

  static final smallBlack = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
  );
  static final smallBlackThin = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
    fontWeight: FontWeight.w500
  );
  static final smallBlackBold = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
    fontWeight: FontWeight.bold,
  );
//  static final smallBlackThin = TextStyle(
//    color: AppColors.black,
//    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
//    fontWeight: FontWeight.w500,
//  );

  static final xSmallBlackBold = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
    fontWeight: FontWeight.bold,
  );

  static final xSmallBlack = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
  );

  static final xSmallBlackUnderLine = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
    decoration: TextDecoration.underline
  );

  static final xxSmallBlack = TextStyle(
    color: AppColors.black,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.xx_small_font_size),
  );


//------------------ red

  static final normalRedBold = TextStyle(
      color: AppColors.red,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
      fontWeight: FontWeight.bold
  );

  static final mediumRedBold = TextStyle(
    color: AppColors.red,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
    fontWeight: FontWeight.bold
  );
  static final mediumRed = TextStyle(
    color: AppColors.red,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
  );

  static final smallRed = TextStyle(
    color: AppColors.red,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
  );

  static final smallRedBold = TextStyle(
    color: AppColors.red,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
    fontWeight: FontWeight.bold
  );

  static final xSmallRed = TextStyle(
    color: AppColors.red,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
  );

  static final xSmallRedBold = TextStyle(
    color: AppColors.red,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
    fontWeight: FontWeight.bold
  );

  static final xxSmallRed = TextStyle(
    color: AppColors.red,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.xx_small_font_size),
  );

  ////////////////////// green
  static final smallGreen = TextStyle(
    color: AppColors.green,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
  );
  static final xSmallGreen = TextStyle(
    color: AppColors.green,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
    fontWeight: FontWeight.bold
  );
  ///////////////////////// Orange
  static final smallOrange = TextStyle(
    color: AppColors.orange,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
  );
  static final xSmallOrange = TextStyle(
      color: AppColors.orange,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.x_small_font_size),
      fontWeight: FontWeight.bold
  );



  static final errorStyle = TextStyle(
    color: AppColors.red,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.xx_small_font_size),
  );


  ////////////////////// blue


  static final smallBlue = TextStyle(
    color: AppColors.blue,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
  );

  static final smallBlueBold = TextStyle(
      color: AppColors.blue,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
      fontWeight: FontWeight.bold
  );

  static final normalBlue = TextStyle(
      color: AppColors.blue,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
  );
  static final normalBlueBold = TextStyle(
      color: AppColors.blue,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
      fontWeight: FontWeight.bold
  );

  static final mediumBlueBold = TextStyle(
      color: AppColors.blue,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
      fontWeight: FontWeight.bold
  );
  static final mediumBlue = TextStyle(
    color: AppColors.blue,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
  );
  static final largeBlueBold = TextStyle(
      color: AppColors.blue,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.large_font_size),
      fontWeight: FontWeight.bold
  );
  static final largeBlue = TextStyle(
    color: AppColors.blue,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.large_font_size),
  );
  /////////////////////////////////// cyan

  static final smallCyan = TextStyle(
    color: AppColors.cyan,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
  );

  static final smallCyanBold = TextStyle(
      color: AppColors.cyan,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.small_font_size),
      fontWeight: FontWeight.bold
  );

  static final normalCyanBold = TextStyle(
      color: AppColors.cyan,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.normal_font_size),
      fontWeight: FontWeight.bold
  );

  static final mediumCyanBold = TextStyle(
      color: AppColors.cyan,
      fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
      fontWeight: FontWeight.bold
  );
  static final mediumCyan = TextStyle(
    color: AppColors.cyan,
    fontSize: AppFontsSize.getScaledFontSize(AppFontsSize.medium_font_size),
  );

  static final Shadow appShadow =  Shadow(color: AppColors.black.withOpacity(0.35), blurRadius: 6 , offset: Offset(0, 6));
}
