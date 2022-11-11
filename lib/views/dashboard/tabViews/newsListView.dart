import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/newsArticles.dart';
import '../../../models/newsData.dart';
import '../../../providers/dashboardProvider.dart';
import '../../../services/apiServices.dart';
import '../../../utilities/AppColors.dart';
import '../../../utilities/CustomTextStyle.dart';
import '../../../utilities/HexColor.dart';
import '../../../utilities/navigation_utils.dart';

class NewsListView extends StatefulWidget {
  const NewsListView({Key? key}) : super(key: key);

  @override
  State<NewsListView> createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
  bool isLoading = false;

  NewsData? _newsdata;
  List<NewsArticles> _allNewsdata = [];
  final controller = ScrollController();
  int pageNo = 1;
  bool noData = false;
  bool isLast = false;
  int pageSize = 8;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    _getNewsData();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset && !isLast) {
        setState(() {
          pageNo++;
        });
        _getNewsData();
      }
    });

    super.initState();
  }

  void _getNewsData() async {
    final dashboardProvider =
        Provider.of<DashboardProvider>(context, listen: false);

    _newsdata = await NewsApiService.getAllNews(
        filterText: dashboardProvider.selectedTab,
        pageNo: pageNo,
        pageSize: pageSize);

    if (_newsdata != null) {
      setState(() {
        isLoading = false;
        _allNewsdata.addAll(_newsdata!.articles);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              backButton(context);
            },
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Hot Updates",
            style: CustomTextStyle(context)
                .body3()
                .copyWith(color: HexColor(AppColors.mainColor))),
        toolbarHeight: 50,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              controller: controller,
              physics: const BouncingScrollPhysics(),
              itemCount: _allNewsdata.length,
              itemBuilder: (BuildContext context, int index) {
                return singleNewsView(index);
              }),
    );
  }

  Padding singleNewsView(int index) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            // height: 120,
            width: width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    elevation: 2,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white,
                    child: CachedNetworkImage(
                      height: 130,
                      width: width,
                      placeholder: (context, url) => Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.broken_image,
                        color: HexColor(AppColors.mainColor),
                        size: 40,
                      ),
                      imageUrl: _allNewsdata[index].urlToImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(_allNewsdata[index].publishedAt,
                      style: CustomTextStyle(context).body8(),
                      textAlign: TextAlign.left),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    _allNewsdata[index].title,
                    style: CustomTextStyle(context).body6(),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    _allNewsdata[index].content,
                    style: CustomTextStyle(context)
                        .body5()
                        .copyWith(color: Colors.black),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "By " + _allNewsdata[index].author,
                    style: CustomTextStyle(context)
                        .body8()
                        .copyWith(color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
