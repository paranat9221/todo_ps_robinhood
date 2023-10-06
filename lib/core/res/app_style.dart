import 'package:flutter/material.dart';
import 'package:todo_ps_robinhood/core/res/app_color.dart';
import 'package:todo_ps_robinhood/core/res/app_value.dart';

class AppStyle {
  static BoxDecoration homeMenuCon = BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(0, 1),
      ),
    ],
  );
  static BoxDecoration homeHeaderBg = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: const [0.1, 0.9],
        colors: [AppColor.primary, AppColor.secondary],
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.elliptical(
          AppValue.mainHeaderEllipticalX,
          AppValue.mainHeaderEllipticalY,
        ),
        bottomRight: Radius.elliptical(
          AppValue.mainHeaderEllipticalX,
          AppValue.mainHeaderEllipticalY,
        ),
      ));
  static BoxDecoration homeTabbarIndicator = BoxDecoration(
    color: AppColor.primary,
    borderRadius: BorderRadius.all(Radius.circular(
      AppRadius.homeTabbarIndicator,
    )),
  );
}
