import 'dart:developer' as DEV;
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/configs/constants/app_images.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/resource/bloc/campaign_bloc/campaign_bloc.dart';
import 'package:flutter_application_1/src/resource/response/campaign_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Campings extends StatefulWidget {
  const Campings({Key? key}) : super(key: key);

  @override
  State<Campings> createState() => _CampingsState();
}

class _CampingsState extends State<Campings> {
  final _random = Random();
  final List _campingImgs = [
    AppImages.productCamping1,
    AppImages.productCamping2,
    AppImages.productCamping3,
    AppImages.productCamping4
  ];

  final CampaignBloc _campaignBloc = getIt<CampaignBloc>();

  List<CampaignData> campaigns = [];

  @override
  void initState() {
    super.initState();
    _campaignBloc.add(GetCampaignsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _campaignBloc,
      child: BlocListener<CampaignBloc, CampaignState>(
        listener: (context, state) {
          DEV.log("CampaignState $state");
          if (state is GetCampaignsLoaded) {
            setState(() {
              campaigns = state.response.data ?? [];
            });
          }
        },
        child: BlocBuilder<CampaignBloc, CampaignState>(
          builder: (context, state) {
            if (state is GetCampaignsLoaded) {
              return CarouselSlider.builder(
                itemCount: campaigns.length,
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  aspectRatio: 2.0,
                  initialPage: 1,
                ),
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  CampaignData campaign = campaigns[itemIndex];
                  return SizedBox(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                _campingImgs[
                                    _random.nextInt(_campingImgs.length)],
                              ),
                            ),
                          ),
                          width: double.infinity,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black.withOpacity(0.4)),
                        ),
                        Positioned.fill(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              campaign.name ?? "",
                              style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              campaign.campaignDescription == null
                                  ? ""
                                  : campaign.campaignDescription!,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Divider(color: Colors.white),
                            Text(
                              campaign.kpiSaleProduct.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ))
                      ],
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
