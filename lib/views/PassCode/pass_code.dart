import 'dart:async';

import 'package:flutter/material.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:todo_ps_robinhood/core/res/app_text.dart';
import 'package:todo_ps_robinhood/repositories/pin_repository.dart';

class PassCodePage extends StatefulWidget {
  const PassCodePage({Key? key, required this.onPinValid}) : super(key: key);

  final Function onPinValid;

  @override
  State<PassCodePage> createState() => _PassCodePageState();
}

class _PassCodePageState extends State<PassCodePage> {
  final PinRepository pinRepository = PinRepositoryIml();

  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = '123456' == enteredPasscode;

    if (isValid) {
      pinRepository.updateLatestPinTime(dateTime: DateTime.now());
      widget.onPinValid();
    } else {
      _verificationNotifier.add(isValid);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PasscodeScreen(
          backgroundColor: Colors.transparent,
          circleUIConfig: CircleUIConfig(
            borderColor: Theme.of(context).colorScheme.primary,
            fillColor: Theme.of(context).colorScheme.primary,
          ),
          keyboardUIConfig: KeyboardUIConfig(
            primaryColor: Theme.of(context).colorScheme.primary,
            digitFillColor: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            AppText.passCodeTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          passwordEnteredCallback: _onPasscodeEntered,
          cancelButton: Text(AppTextButton.cancel),
          deleteButton: Text(AppTextButton.delete),
          shouldTriggerVerification: _verificationNotifier.stream,
        ),
      ),
    );
  }
}
