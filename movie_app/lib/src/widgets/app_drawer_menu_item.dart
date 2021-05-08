import 'package:flutter/material.dart';

class DrawerMenuItem extends StatelessWidget {
  final String menuItemTitle;
  final IconData menuItemIconData;
  final Function menuItemFunction;

  const DrawerMenuItem(
      {@required this.menuItemTitle,
      this.menuItemIconData,
      this.menuItemFunction});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(menuItemIconData),
      title: Text(menuItemTitle),
      onTap: menuItemFunction,
    );
  }
}
