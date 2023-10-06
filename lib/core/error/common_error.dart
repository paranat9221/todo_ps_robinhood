import 'package:flutter/material.dart';
import 'package:todo_ps_robinhood/core/res/app_text.dart';
import 'package:todo_ps_robinhood/core/res/app_value.dart';

class CommonDialogError {
  void createDialog({
    required BuildContext context,
    int? code,
    required dynamic exception,
    String? title,
    String? message,
    String? buttonText,
    Function()? buttonAction,
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                padding: EdgeInsets.all(AppPadding.main),
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _title(exception),
                            SizedBox(height: AppPadding.main),
                            ElevatedButton(
                              onPressed: () => _onClick(context, buttonAction),
                              child: Text(buttonText ?? AppTextButton.ok),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  _onClick(BuildContext context, onClick) {
    if (onClick != null) {
      onClick();
    } else {
      Navigator.pop(context);
    }
  }

  _title(exception) {
    return Text(exception.toString());
  }
}
