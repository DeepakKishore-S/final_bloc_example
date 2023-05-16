import 'package:flutter/material.dart';

enum MenuAction { logout, deleteAccount }

class MainPopUpMenuButton extends StatefulWidget {
  const MainPopUpMenuButton({Key? key}) : super(key: key);

  @override
  State<MainPopUpMenuButton> createState() => _MainPopUpMenuButtonState();
}

class _MainPopUpMenuButtonState extends State<MainPopUpMenuButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      itemBuilder: (context) {
        return [
          const PopupMenuItem<MenuAction>(
            value: MenuAction.logout,
            child: Text("Log out"),
          ),
          const PopupMenuItem<MenuAction>(
            value: MenuAction.deleteAccount,
            child: Text("Delete Account"),
          ),
        ];
      },
    );
  }
}
