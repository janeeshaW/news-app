import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_first_app/providers/dashboardProvider.dart';
import 'package:news_first_app/utilities/HexColor.dart';
import 'package:provider/provider.dart';

import '../../../models/newsData.dart';
import '../../../services/apiServices.dart';
import '../../../utilities/AppColors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utilities/CustomTextStyle.dart';
import '../../../utilities/navigation_utils.dart';
import '../../../utilities/widgets/Button.dart';
import 'categoryView.dart';
import 'detailView.dart';
import 'newsListView.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  NewsData? _headlinesNewsdata;
  String filterString = "Healthy";

  bool isLoading = false;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        isLoading = true;
      });
      _getNewsData();
      final ind =
          Provider.of<DashboardProvider>(context, listen: false).tabIndex;
      tabController.animateTo(ind);
    });
    super.initState();
  }

  void _getNewsData() async {
    _headlinesNewsdata = await NewsApiService.getNewsHeadLines();

    if (_headlinesNewsdata != null) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    return SafeArea(
      child: isLoading || _headlinesNewsdata == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(color: Colors.black),
                            autofocus: false,
                            cursorColor: Colors.black,
                            textInputAction: TextInputAction.search,
                            onChanged: (val) {
                              dashboardProvider
                                  .setSearchString(val.toLowerCase());
                            },
                            decoration: InputDecoration(
                                focusedErrorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                hintText: "Dogecoin to the Moon..",
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      dashboardProvider.isSearchModeOn
                                          ? dashboardProvider
                                              .toggleAppbarSearchMode(false)
                                          : dashboardProvider
                                              .toggleAppbarSearchMode(true);
                                    },
                                    icon: dashboardProvider.isSearchModeOn
                                        ? const Icon(
                                            Icons.search_rounded,
                                            color: Colors.black,
                                          )
                                        : const Icon(
                                            Icons.close,
                                            color: Colors.black,
                                          ))),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Visibility(
                          visible: dashboardProvider.isSearchModeOn,
                          child: CircleAvatar(
                            backgroundColor: HexColor(AppColors.mainColor),
                            radius: 20,
                            child: SvgPicture.asset(
                                'assets/images/notification.svg'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            // isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30))),
                            context: context,
                            builder: (context) => buildBottomSheet());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HexColor(AppColors.mainColor)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text('Filter',
                                style: CustomTextStyle(context)
                                    .blueText()
                                    .copyWith(color: Colors.white)),
                          ),
                        ),
                        // height: 15
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: dashboardProvider.isSearchModeOn,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Latest News",
                                style: CustomTextStyle(context)
                                    .headlineBlack()
                                    .copyWith(
                                        color:
                                            HexColor(AppColors.primaryColor)),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const NewsListView()));
                                },
                                child: Row(
                                  children: [
                                    Text('See All',
                                        style: CustomTextStyle(context)
                                            .blueText()),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      Icons.navigate_next,
                                      color: Colors.blue,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 200,
                            // width: width,
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: _headlinesNewsdata!.articles.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return headLineCard(index);
                                }),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            height: kToolbarHeight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: TabBar(
                                  controller: tabController,
                                  isScrollable: true,
                                  labelColor: Colors.white,
                                  unselectedLabelColor: Colors.black,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicatorPadding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 2),
                                  indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: HexColor(AppColors.mainColor)),
                                  onTap: (idx) {
                                    dashboardProvider.setTabIndex(idx);
                                    setState(() {
                                      if (idx == 0) {
                                        filterString = "Healthy";
                                      } else if (idx == 1) {
                                        filterString = "Technology";
                                      } else if (idx == 2) {
                                        filterString = "Finance";
                                      } else if ((idx == 3)) {
                                        filterString = "Arts";
                                      }
                                    });
                                    dashboardProvider.setTab(filterString);
                                  },
                                  tabs: const [
                                    Tab(
                                      text: ' Healthy ',
                                    ),
                                    Tab(
                                      text: ' Technology ',
                                    ),
                                    Tab(
                                      text: ' Finance ',
                                    ),
                                    Tab(
                                      text: ' Arts ',
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const CategoryView()
                  ],
                ),
              ),
            ),
    );
  }

  InkWell headLineCard(int index) {
    final dashboardProvider =
        Provider.of<DashboardProvider>(context, listen: true);
    return InkWell(
      onTap: () {
        dashboardProvider.singleSelectedNews =
            _headlinesNewsdata!.articles[index];

        openDetailScreen(context);
      },
      child: SizedBox(
          height: 200,
          width: 300,
          child: Stack(
            children: [
              Center(
                child: Card(
                  elevation: 5,
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.white,
                  child: CachedNetworkImage(
                    height: 200,
                    width: 300,
                    placeholder: (context, url) => Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,

                      // width: double.infinity,
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.broken_image,
                      color: HexColor(AppColors.mainColor),
                      size: 40,
                    ),
                    imageUrl: _headlinesNewsdata!.articles[index].urlToImage,
                    // width: width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              _headlinesNewsdata!.articles[index].author.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20, top: 25),
                      child: Text(
                        "By " + _headlinesNewsdata!.articles[index].author,
                        style: CustomTextStyle(context).body5(),
                        textAlign: TextAlign.left,
                      ),
                    )
                  : Container(),
              Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(_headlinesNewsdata!.articles[index].title,
                    style: CustomTextStyle(context).body4(),
                    textAlign: TextAlign.left),
              ))
            ],
          )),
    );
  }

  Widget buildBottomSheet() {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          )),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  "Filter",
                  style: CustomTextStyle(context)
                      .headlineBlack()
                      .copyWith(color: HexColor(AppColors.primaryColor)),
                ),
                const Spacer(),
                Button(
                  name: ' Reset ',
                  itemClick: () {
                    // login();
                  },
                  textStyle: null,
                ),
              ],
            ),
            Text(
              "Sort By",
              style: CustomTextStyle(context)
                  .body2()
                  .copyWith(color: HexColor(AppColors.primaryColor)),
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button2(
                  name: 'category',
                  itemClick: () {
                    // login();
                  },
                  textStyle: null,
                ),
                Button2(
                  name: 'language',
                  itemClick: () {
                    // login();
                  },
                  textStyle: null,
                ),
                Button2(
                  name: 'country',
                  itemClick: () {
                    // login();
                  },
                  // you can use any textstyle you want
                  textStyle: null,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
