import 'package:flutter/material.dart';
import 'package:venture_guide/main.dart';

class AlertService {
  static void showAlert(
    String message, [
    String? title,
    String buttonTitle = "Ok",
  ]) {
    showDialog(
      context: navigatorKey.currentContext!,

      builder: (BuildContext context) {
        final theme = Theme.of(context);
        final titleTheme = theme.textTheme.headlineSmall;

        return AlertDialog(
          title: title != null
              ? Text(title, style: titleTheme)
              : null,
          content: Text(message, style: theme.textTheme.bodyLarge),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: theme.dividerColor,
              width: 1.0,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                buttonTitle,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showSuccess(String message) {
    showAlert(message, "Success");
  }

  static void showWarning(String message) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void showError(String message) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
