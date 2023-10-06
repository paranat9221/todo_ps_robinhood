import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_ps_robinhood/core/res/app_color.dart';
import 'package:todo_ps_robinhood/repositories/pin_repository.dart';
import 'package:todo_ps_robinhood/utils/custom/app_constant.dart';
import 'package:todo_ps_robinhood/views/Main/main_page.dart';
import 'package:todo_ps_robinhood/views/PassCode/pass_code.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final TextStyle defaultTitle = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColor.primary,
  );

  final TextStyle defaultBody = const TextStyle(
    color: Colors.grey,
  );

  final TextStyle defaultLabel = const TextStyle(
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: defaultTitle,
          titleMedium: defaultTitle,
          titleSmall: defaultTitle,
          bodyLarge: defaultBody,
          bodyMedium: defaultBody,
          bodySmall: defaultBody,
          labelLarge: defaultLabel,
          labelMedium: defaultLabel,
          labelSmall: defaultLabel,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
        useMaterial3: true,
      ),
      home: const _Home(),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home({Key? key}) : super(key: key);

  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  final PinRepository pinRepository = PinRepositoryIml();

  late Timer _inactivityTimer;
  bool isPinStillValid = false;
  bool isInitial = false;

  @override
  void initState() {
    _initCheckInactive();
    // _checkPin();
    isInitial = true;
    super.initState();
  }

  // void _checkPin() async {
  //   DateTime? latestPinTime = await pinRepository.fetchLatestPinTime();

  //   if (latestPinTime != null &&
  //       DateTime.now().difference(latestPinTime).inSeconds < 10) {
  //     isPinStillValid = true;
  //   }

  //   setState(() {
  //     isInitial = true;
  //   });
  // }

  void _initCheckInactive() {
    _inactivityTimer =
        Timer(Duration(seconds: AppConstant.passCodeActiveTimeSec.toInt()), () {
      _onActiveExpire();
    });
  }

  void _onUserActive() {
    _inactivityTimer.cancel();
    _inactivityTimer =
        Timer(Duration(seconds: AppConstant.passCodeActiveTimeSec.toInt()), () {
      _onActiveExpire();
    });
  }

  void _onActiveExpire() {
    setState(() {
      isPinStillValid = false;
    });
  }

  void _onPinValid() {
    setState(() {
      isPinStillValid = true;
    });
  }

  void _onDispose() {
    pinRepository.clearLatestPinTime();
  }

  @override
  void dispose() {
    _inactivityTimer.cancel();
    _onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isInitial
        ? Listener(
            onPointerDown: (event) => _onUserActive(),
            child: isPinStillValid
                ? const MainPage()
                : PassCodePage(onPinValid: _onPinValid),
          )
        : Container();
  }
}
