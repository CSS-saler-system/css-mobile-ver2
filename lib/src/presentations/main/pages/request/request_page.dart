import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/button_error.dart';
import 'package:flutter_application_1/src/configs/constants/app_color.dart';
import 'package:flutter_application_1/src/configs/constants/app_images.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/resource/bloc/selling_bloc/selling_bloc_bloc.dart';
import 'package:flutter_application_1/src/resource/response/get_sellings_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../resource/extension/number.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final SellingBlocBloc _sellingBloc = getIt<SellingBlocBloc>();
  List<SellingData> sellings = [];
  int _page = 1;
  int _totalPage = 0;

  @override
  void initState() {
    super.initState();

    _sellingBloc.add(const GetSellingsEvent(page: 1, pageSize: 99999));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Expanded(
            child: BlocProvider(
              create: (context) => _sellingBloc,
              child: BlocListener<SellingBlocBloc, SellingBlocState>(
                  listener: (context, state) {
                if (state is GetSellingsLoaded) {
                  setState(() {
                    sellings = state.sellingResponse.data ?? [];
                    log(sellings[0].id ?? "");
                    _page = state.sellingResponse.number ?? 1;
                    _totalPage = state.sellingResponse.totalPage ?? 0;
                  });
                }
              }, child: BlocBuilder<SellingBlocBloc, SellingBlocState>(
                builder: (context, state) {
                  if (state is GetSellingsLoaded) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shrinkWrap: false,
                      itemCount: sellings.length,
                      itemBuilder: ((context, index) {
                        SellingData selling = sellings[index];
                        return Card(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: 110,
                                      child: Image.asset(AppImages.iphone12)),
                                  const SizedBox(height: 5),
                                  Expanded(
                                    child: SizedBox(
                                      height: 110,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 8,
                                                width: 8,
                                                decoration: BoxDecoration(
                                                  color: AppColors.primarycolor,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                selling.requestStatus ??
                                                    "UNKNOW",
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.primarycolor,
                                                ),
                                              )
                                            ],
                                          ),
                                          Divider(color: Colors.grey.shade200),
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Name: ${selling.product != null ? selling.product?.name : "UNKNOW"}",
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 2),
                                                  Text(
                                                    "Price: ${selling.product?.price!.getVnCurrence ?? ""}",
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors
                                                          .primarycolor,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 2),
                                                  Text(
                                                    "Sell: ${selling.product?.pointSale ?? ""}",
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors
                                                          .primarycolor,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 5,
                                                  horizontal: 15,
                                                ),
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColors.primarycolor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: const Text(
                                                  "Cancle",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        );
                      }),
                    );
                  }

                  if (state is GetSellingsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is GetSellingsError) {
                    return Center(
                        child: ButtonError(
                            onPressed: () => _sellingBloc.add(
                                const GetSellingsEvent(
                                    page: 1, pageSize: 99999))));
                  }

                  return const SizedBox();
                },
              )),
            ),
          ),
        ],
      ),
    );
  }
}
