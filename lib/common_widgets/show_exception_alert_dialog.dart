import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aves_de_san_martin/common_widgets/show_alert_dialog.dart';

Future<void> showExceptionAlertDialog(BuildContext context,
        {required String title,
        required Exception exception,
        StackTrace? stack}) =>
    showAlertDialog(context,
        title: title,
        dialogContent: exception.toString(),
        defaultActionText: 'Ok');

String _message(Exception exception) {
  if (exception is FirebaseException) {
    return exception.message!;
  }
  return exception.toString();
}
