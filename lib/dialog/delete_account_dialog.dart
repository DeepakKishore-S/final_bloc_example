import 'package:final_bloc_example/dialog/generic_dialog.dart';
import 'package:flutter/material.dart' show BuildContext;

Future<bool> showDeleteAccountDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: "Delete Account",
      content:
          "Are you sure you want to delete this account? This Operation cannot be undone",
      optionDialogBuilder: () => {
            "Cancel": false,
            "Delete": true,
          }).then((value) => value ?? false);
}
