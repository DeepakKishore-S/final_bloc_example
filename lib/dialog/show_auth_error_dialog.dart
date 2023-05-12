import 'package:final_bloc_example/auth/auth_error.dart';
import 'package:final_bloc_example/dialog/generic_dialog.dart';
import 'package:flutter/material.dart' show BuildContext;

Future<void> showAuthErrorDialog({
  required AuthError authError,
  required BuildContext context,
}) {
  return showGenericDialog(
      context: context,
      title: authError.dialogTitle,
      content: authError.dialogText,
      optionDialogBuilder: () => {
            "Ok": true,
          });
}
