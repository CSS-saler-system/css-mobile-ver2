import 'package:flutter/material.dart';

class ItemNavigator extends StatelessWidget {
  final Icon icon;
  final VoidCallback onTap;

  const ItemNavigator({Key? key, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: IconButton(
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: onTap,
      icon: icon,
    ));
  }
}
