import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:movies_app/src/core/common_feature/domain/entities/login_by_enum.dart';
import 'package:movies_app/src/core/common_feature/presentation/widgets/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../common_feature/data/data_sources/app_shared_prefs.dart';
import 'injections.dart';

class Helper {
  /// Get language
  static String getLang() {
    String? lang;
    lang = sl<AppSharedPrefs>().getLang();
    lang = lang ?? "en";
    return lang;
  }

  /// Get svg picture path
  static String getSvgPath(String name) {
    return "assets/svg/$name";
  }

  /// Get image picture path
  static String getImagePath(String name) {
    return "assets/images/$name";
  }

  /// Get vertical space
  static double getVerticalSpace() {
    return 10.h;
  }

  /// Get horizontal space
  static double getHorizontalSpace() {
    return 10.w;
  }

  static formatDate(DateTime date) {
    final formatted = DateFormat('yyyy-MM-dd');
    return formatted.format(date);
  }

  /// Show snack bar message
  static showSnackBar(BuildContext context, String message,
      {ToastTypeEnum type = ToastTypeEnum.info}) {
    Future.delayed(const Duration(seconds: 0), () {
      AppSnackBar.show(context, message, type);
    });
  }

  /// Show custom dialog with specific page
  static Future showCustomDialog(BuildContext context, Widget child,
      {EdgeInsets? margin,
      bool barrierDismissible = true,
      Color? backgroundColor}) async {
    return showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: barrierDismissible,
      builder: (ctx) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: backgroundColor ?? Theme.of(context).dialogBackgroundColor,
            ),
            margin: margin ?? EdgeInsets.symmetric(horizontal: 100.w),
            child: child,
          ),
        ],
      ),
    );
  }

  /// Get Dio Header
  static Map<String, dynamic> getHeaders() {
    return {}..removeWhere((key, value) => value == null);
  }

  static LoginByEnum loginBy() {
    return LoginByEnum.password;
    // if (sl<AuthSharedPrefs>().getFingerPrint()) {
    //   return LoginByEnum.fingerprint;
    // } else {
    //   if (sl<AuthSharedPrefs>().getProfile() != null && sl<AuthSharedPrefs>().getProfile()?.gesturePwd != "") {
    //     return LoginByEnum.gesturePassword;
    //   } else {
    //     return LoginByEnum.password;
    //   }
    // }
  }

  static bool isDarkTheme() {
    return sl<AppSharedPrefs>().getIsDarkTheme();
  }
}
