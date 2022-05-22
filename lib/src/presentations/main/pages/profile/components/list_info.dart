import 'package:flutter/material.dart';

import '../../../../../configs/configs.dart';

class ListInformationWidget extends StatefulWidget {
  const ListInformationWidget({Key? key}) : super(key: key);

  @override
  State<ListInformationWidget> createState() => _ListInformationWidgetState();
}

class _ListInformationWidgetState extends State<ListInformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(children: [
        const Divider(),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRouters.editProfile),
          child: const ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text("Profile"),
          ),
        ),
        const Divider(),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRouters.customerScreen),
          child: const ListTile(
            leading: Icon(Icons.group_outlined),
            title: Text('Customer'),
          ),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.local_grocery_store_outlined),
          title: Text("My orders"),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.settings),
          title: Text("My orders"),
        ),
        const Divider(),
        Container(
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(5),
          ),
          child: const ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            title: Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ),
      ]),
    );
  }
}
