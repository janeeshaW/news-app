import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/dashboardProvider.dart';
import '../../../utilities/AppColors.dart';
import '../../../utilities/CustomTextStyle.dart';
import '../../../utilities/HexColor.dart';
import '../../../utilities/navigation_utils.dart';

class DetailView extends StatefulWidget {
  const DetailView({Key? key}) : super(key: key);

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              // bottom: height/2,
              child: CachedNetworkImage(
                height: height * 0.5,
                // width: width,
                placeholder: (context, url) => Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.fitHeight,
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.broken_image,
                  color: HexColor(AppColors.mainColor),
                  size: 40,
                ),
                imageUrl: dashboardProvider.selectedNews.urlToImage,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 15,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: Colors.grey),
                height: 35,
                width: 35,
                child: Center(
                  child: IconButton(
                      onPressed: () {
                        backButton(context);
                      },
                      icon: Icon(
                        Platform.isIOS
                            ? Icons.arrow_back_ios
                            : Icons.arrow_back,
                        color: Colors.black,
                      )),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                // bottom: height/2,
                child: SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35)),
                      color: Colors.white,
                    ),
                    height: height * 0.5,
                    width: width,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 120, left: 20, right: 20),
                      child: Text(
                        dashboardProvider.selectedNews.content,
                        style: CustomTextStyle(context)
                            .body5()
                            .copyWith(color: Colors.black),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                )),
            Center(

                // bottom: height/2,
                child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey.withOpacity(0.8),
                ),
                // height: 100,
                width: width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Text(dashboardProvider.selectedNews.publishedAt,
                          style: CustomTextStyle(context).body7(),
                          textAlign: TextAlign.left),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(dashboardProvider.selectedNews.title,
                            style: CustomTextStyle(context)
                                .body4()
                                .copyWith(color: Colors.black),
                            textAlign: TextAlign.left),
                      ),
                    ),
                    dashboardProvider.selectedNews.author.isNotEmpty
                        ? Padding(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 15),
                            child: Text(
                              "By " + dashboardProvider.selectedNews.author,
                              style: CustomTextStyle(context)
                                  .body5()
                                  .copyWith(color: Colors.black),
                              textAlign: TextAlign.left,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
