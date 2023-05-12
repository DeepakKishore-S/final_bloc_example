import 'package:final_bloc_example/dialog/generic_dialog.dart';
import 'package:flutter/material.dart' show BuildContext;

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: "Log Out",
      content:
          "Are you sure you want to log out?",
      optionDialogBuilder: () => {
            "Cancel": false,
            "Log out": true,
          }).then((value) => value ?? false);
}
