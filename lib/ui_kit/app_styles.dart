import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppStyles {

  static TextStyle gilroySemiBoldGreen(double fontSize) {
    return TextStyle(
      fontFamily: 'Gilroy',
      height: 1.1,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: AppColors.green
    );
  }

  static TextStyle gilroySemiBoldWhite(double fontSize) {
    return TextStyle(
        fontFamily: 'Gilroy',
        height: 1.1,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: AppColors.white
    );
  }

  static TextStyle gilroySemiBoldBlack(double fontSize) {
    return TextStyle(
        fontFamily: 'Gilroy',
        height: 1.1,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: AppColors.black
    );
  }

  static TextStyle gilroyMediumWhite(double fontSize) {
    return TextStyle(
        fontFamily: 'Gilroy',
        height: 1.1,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: AppColors.white
    );
  }

  static TextStyle gilroyMediumGrey1(double fontSize) {
    return TextStyle(
        fontFamily: 'Gilroy',
        height: 1.1,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: AppColors.grey1
    );
  }

  static TextStyle gilroyMediumBlack(double fontSize) {
    return TextStyle(
        fontFamily: 'Gilroy',
        height: 1.1,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: AppColors.black
    );
  }

  static TextStyle gilroyMediumGreen(double fontSize) {
    return TextStyle(
        fontFamily: 'Gilroy',
        height: 1.1,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: AppColors.green
    );
  }

  static TextStyle gilroyRegularLightGrey2(double fontSize) {
    return TextStyle(
        fontFamily: 'Gilroy',
        height: 1.1,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: AppColors.lightGrey2
    );
  }

  static TextStyle gilroyRegularGreen(double fontSize) {
    return TextStyle(
        fontFamily: 'Gilroy',
        height: 1.1,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: AppColors.green
    );
  }

  static TextStyle gilroyRegularLightBlack(double fontSize) {
    return TextStyle(
        fontFamily: 'Gilroy',
        height: 1.1,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: AppColors.lightBlack
    );
  }

  static TextStyle gilroyRegularBlack(double fontSize) {
    return TextStyle(
        fontFamily: 'Gilroy',
        height: 1.1,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: AppColors.black
    );
  }

  static TextStyle gilroyRegularGrey1(double fontSize) {
    return TextStyle(
        fontFamily: 'Gilroy',
        height: 1.1,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: AppColors.grey1
    );
  }

  static TextStyle gilroyRegularGrey3(double fontSize) {
    return TextStyle(
        fontFamily: 'Gilroy',
        height: 1.1,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: AppColors.grey3
    );
  }

  static TextStyle gilroyRegularWhite(double fontSize) {
    return TextStyle(
        fontFamily: 'Gilroy',
        height: 1.1,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: AppColors.white
    );
  }
}