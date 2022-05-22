import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentations/main/components/navigator_item.dart';

class BottomNavigation extends StatefulWidget {
  final int? pageIndex;
  final Function(int) itemMenuClicked;
  const BottomNavigation(
      {Key? key, required this.pageIndex, required this.itemMenuClicked})
      : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  // fake menu
  final List<ItemMenu> _items = [
    const ItemMenu(
      icon: Icons.home_outlined,
      index: 0,
    ),
    const ItemMenu(
      icon: Icons.send_outlined,
      index: 1,
    ),
    const ItemMenu(
      icon: Icons.local_grocery_store_outlined,
      index: 2,
    ),
    const ItemMenu(
      icon: Icons.person_outline_outlined,
      index: 3,
    ),
  ];

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
          children: _items
              .map((child) => ItemNavigator(
                    icon: Icon(
                      child.icon,
                      color: _items.indexOf(child) == widget.pageIndex
                          ? Colors.orange
                          : Colors.black,
                    ),
                    onTap: () => widget.itemMenuClicked(child.index),
                  ))
              .toList()),
    );
  }
}

class ItemMenu {
  final IconData icon;
  final int index;
  const ItemMenu({Key? key, required this.icon, required this.index});
}
