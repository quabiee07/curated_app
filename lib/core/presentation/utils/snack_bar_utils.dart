import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:curated_app/core/presentation/theme/colors/snack_bar_colors.dart';
import 'package:logger/logger.dart';

extension SnackbarStateless on BuildContext {
  showSuccess(String message) {
    customFlushBar(message, 1).show(this);
  }

  showError(String message) {
    customFlushBar(
      message,
      3,
    ).show(this);
  }

  showWarning(String message) {
    customFlushBar(
      message,
      2,
    ).show(this);
  }

  logg(String log) {
    return Logger().i(log);
  }
}

extension Snackbar on State {
  showSuccess(String message) {
    context.showSuccess(message);
  }

  logg(String log) {
    context.logg(log);
  }

  showError(String message) {
    context.showError(message);
  }

  showWarning(String message) {
    context.showWarning(message);
  }
}

Flushbar customFlushBar(String message, [type = 1]) {
  final IconData icon;
  final Color color;
  final Color iconColor;
  switch (type) {
    case 1:
      icon = Icons.check_circle;
      color = successBackground;
      iconColor = successForeground;
      break;
    case 2:
      icon = Icons.warning;
      color = pendingBackground;
      iconColor = pendingForeground;
      break;
    default:
      icon = Icons.error;
      color = errorBackground;
      iconColor = errorForeground;
  }

  return Flushbar(
    messageText: Text(
      message,
      style: TextStyle(
          fontFamily: 'DMSans',
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: iconColor),
    ),
    messageColor: iconColor,
    icon: Icon(
      icon,
      color: iconColor,
    ),
    flushbarPosition: FlushbarPosition.TOP,
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.decelerate,
    shouldIconPulse: true,
    backgroundColor: color,
    isDismissible: true,
    duration: const Duration(seconds: 4),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    flushbarStyle: FlushbarStyle.FLOATING,
    boxShadows: const [],
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 32),
    borderRadius: BorderRadius.circular(8),
  );
}
