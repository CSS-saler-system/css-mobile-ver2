import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/configs/constants/app_color.dart';

import '../../../../../components/list_action_hedaer.dart';
import '../../../../../configs/configs.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Column(
        children: [
          ListActionHeader(
            title: "Popular Products",
            onPressed: () =>
                Navigator.pushNamed(context, AppRouters.listProduct),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (() => Navigator.pushNamed(
                      context, AppRouters.productDetail,
                      arguments: {"productId": index})),
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset(AppImages.iphone12),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Iphone 12",
                            maxLines: 1,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            "31.000.000 VND",
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primarycolor,
                            ),
                          ),
                        ]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
