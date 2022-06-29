import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/configs/constants/app_lotties.dart';
import 'package:lottie/lottie.dart';

class DataNotFound extends StatelessWidget {
  const DataNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * .5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(AppLotties.noData),
          const Text(
            "Data not found!",
            style: TextStyle(fontSize: 15, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
