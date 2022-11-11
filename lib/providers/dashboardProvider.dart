


import 'package:flutter/material.dart';

import '../models/newsArticles.dart';


class DashboardProvider extends ChangeNotifier {
    int? _currentTab;

  int get currentTab => _currentTab ?? 0;

  set currentTab(int data) {
    _currentTab = data;
    notifyListeners();
  }

  bool _isSearchModeOn = true;
  String _searchString = '';

  bool get isSearchModeOn => _isSearchModeOn;
  String get searchString => _searchString;

void toggleAppbarSearchMode(bool val) {
    _isSearchModeOn = val;
    notifyListeners();
  }

void setSearchString(String val) {
    _searchString = val;
    notifyListeners();
  }

   int _tabIndex = 0;
  int get tabIndex => _tabIndex;
  setTabIndex(int tabIndex) {
    _tabIndex = tabIndex;
   notifyListeners();
  }

  String _selectedTab = "Healthy";
  String get selectedTab => _selectedTab;
  setTab(String selectedTab) {
    _selectedTab = selectedTab;
   notifyListeners();
  }

  late NewsArticles _selectedNews;

  NewsArticles get selectedNews => _selectedNews;

 set singleSelectedNews (NewsArticles selectedNews){
    _selectedNews = selectedNews;
    notifyListeners();
  }


 





  




 
  



  


 




}