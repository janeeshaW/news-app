
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_first_app/views/dashboard/tabViews/DashboardView.dart';
import 'package:news_first_app/views/dashboard/tabViews/FavouriteView.dart';
import 'package:news_first_app/views/dashboard/tabViews/myProfileView.dart';
import 'package:provider/provider.dart';

import '../../providers/dashboardProvider.dart';
import '../../utilities/AppColors.dart';
import '../../utilities/HexColor.dart';


class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    return Scaffold(
       
        body: NotificationListener(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: dashboardProvider.currentTab == 0
              ? const DashboardView() : dashboardProvider.currentTab == 1 ?
              const FavouriteView () : const MyProfileView (),
           
        ),
        bottomNavigationBar: bottomNavigationBar(dashboardProvider)
       
        );
        
  }

  BottomNavigationBar bottomNavigationBar(DashboardProvider dashboardProvider) {
    return BottomNavigationBar(
      currentIndex: dashboardProvider.currentTab,
      items: [
        BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/home.svg'),
            label: "Home",
            activeIcon: SvgPicture.asset('assets/images/home_selected.svg')),
        BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/heart.svg'),
            label: "Favourite",
            activeIcon: SvgPicture.asset('assets/images/heart_selected.svg')),
        BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/account.svg'),
            label: "Profile",
            activeIcon: SvgPicture.asset('assets/images/account_selected.svg')),
      ],
     selectedItemColor: HexColor(
                                                AppColors.mainColor),
      elevation: 12,
      // if want animation behavior un comment below type.
     // type: BottomNavigationBarType.shifting,
      onTap: (index) {
        dashboardProvider.currentTab = index;
      },
    );
  }

  

 
}