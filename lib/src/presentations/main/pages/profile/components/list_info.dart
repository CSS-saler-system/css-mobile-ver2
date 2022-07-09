import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/dialog_widget.dart';
import 'package:flutter_application_1/src/configs/constants/app_color.dart';
import 'package:flutter_application_1/src/configs/constants/app_lotties.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/presentations/main/main_screen.dart';
import 'package:flutter_application_1/src/resource/repository/local_reponsitory.dart';

import '../../../../../configs/configs.dart';

class ListInformationWidget extends StatefulWidget {
  const ListInformationWidget({Key? key}) : super(key: key);

  @override
  State<ListInformationWidget> createState() => _ListInformationWidgetState();
}

class _ListInformationWidgetState extends State<ListInformationWidget> {
  final LocalRepository _localRepository = getIt<LocalRepository>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(children: [
        const Divider(),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRouters.editProfile),
          child: const ListTile(
            leading: Icon(Icons.store),
            title: Text(
              "Enterprise",
              style: TextStyle(
                color: AppColors.textcolor,
              ),
            ),
          ),
        ),
        const Divider(),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRouters.customerScreen),
          child: const ListTile(
            leading: Icon(Icons.group_outlined),
            title: Text(
              'Customer',
              style: TextStyle(
                color: AppColors.textcolor,
              ),
            ),
          ),
        ),
        const Divider(),
        ListTile(
          // onTap: () => Navigator.pushNamed(context, AppRouters.mainScreen, arguments: {"pageIndex": 2}),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const MainScreen(pageIndex: 2))),
          leading: const Icon(Icons.local_grocery_store_outlined),
          title: const Text(
            "My orders",
            style: TextStyle(
              color: AppColors.textcolor,
            ),
          ),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.settings),
          title: Text(
            "Settings",
            style: TextStyle(
              color: AppColors.textcolor,
            ),
          ),
        ),
        const Divider(),
        Container(
          decoration: BoxDecoration(
            color: AppColors.primarycolor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: ListTile(
            onTap: () {
              DialogHelper.dialogConfirm(context,
                  lotieFile: AppLotties.confirmed,
                  message: "Do you want to log out?", onpressed: () {
                _localRepository.deleteLoginInfo();
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRouters.signIn, (route) => false);
              });
            },
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            title: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ),
      ]),
    );
  }
}
