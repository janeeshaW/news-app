import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/newsData.dart';
import '../../../providers/dashboardProvider.dart';
import '../../../services/apiServices.dart';
import '../../../utilities/AppColors.dart';
import '../../../utilities/CustomTextStyle.dart';
import '../../../utilities/HexColor.dart';
import '../../../utilities/navigation_utils.dart';
import 'detailView.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  bool isLoading = false;

  NewsData? _categoryNewsdata;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    _getNewsData();

    super.initState();
  }

  void _getNewsData() async {
    final dashboardProvider =
        Provider.of<DashboardProvider>(context, listen: false);

    _categoryNewsdata = await NewsApiService.getNewsCategory(
      filterText: dashboardProvider.selectedTab,
    );

    if (_categoryNewsdata != null) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return isLoading
        ? Center(
            child: Padding(
              padding: EdgeInsets.only(top: height / 8),
              child: const CircularProgressIndicator(),
            ),
          )
        : NotificationListener(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return true;
            },
            child: Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _categoryNewsdata!.articles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return categoryCard(index);
                  }),
            ),
          );
  }

  InkWell categoryCard(int index) {
    final dashboardProvider =
        Provider.of<DashboardProvider>(context, listen: true);
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        dashboardProvider.singleSelectedNews =
            _categoryNewsdata!.articles[index];
        openDetailScreen(context);
      },
      child: SizedBox(
          height: 130,
          width: width,
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
                    height: 230,
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
                    imageUrl: _categoryNewsdata!.articles[index].urlToImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              _categoryNewsdata!.articles[index].title.isNotEmpty
                  ? Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 25, right: 20),
                      child: Text(
                        _categoryNewsdata!.articles[index].title,
                        style: CustomTextStyle(context).body6(),
                        textAlign: TextAlign.left,
                      ),
                    )
                  : Container(),
              Positioned(
                bottom: 20,
                right: 20,
                child: Text(_categoryNewsdata!.articles[index].publishedAt,
                    style: CustomTextStyle(context).body6(),
                    textAlign: TextAlign.right),
              )
            ],
          )),
    );
  }
}
