import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentations/main/components/navigator_item.dart';

import '../main_screen.dart';

class BottomNavigation extends StatefulWidget {
  final int? pageIndex;
  final Function(int) itemMenuClicked;
  final List<ItemMenu> items; 
  const BottomNavigation(
      {Key? key, required this.pageIndex, required this.itemMenuClicked, required this.items})
      : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(31, 142, 142, 142),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.items
              .map((child) => ItemNavigator(
                    icon: Icon(
                      child.icon,
                      color: widget.items.indexOf(child) == widget.pageIndex
                          ? Colors.orange
                          : Colors.black,
                    ),
                    onTap: () => widget.itemMenuClicked(child.index),
                  ))
              .toList()),
    );
  }
}
