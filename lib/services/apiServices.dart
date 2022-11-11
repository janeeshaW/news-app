import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/newsData.dart';

import '../utilities/constant.dart';

class NewsApiService {
  static Future<NewsData?> getNewsHeadLines() async {
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=$apikey");

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return NewsData.fromJson(data);
      }
      return null;
    } catch (err) {
      return null;
    }
  }

  static Future<NewsData?> getNewsCategory({String? filterText}) async {
    var url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$filterText&apiKey=$apikey");

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return NewsData.fromJson(data);
      }
      return null;
    } catch (err) {
      return null;
    }
  }

  static Future<NewsData?> getAllNews(
      {String? filterText, int? pageSize, int? pageNo}) async {
    var url = Uri.parse(
        "https://newsapi.org/v2/everything?apiKey=$apikey&pageSize=$pageSize&page=$pageNo&q=$filterText");

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return NewsData.fromJson(data);
      }
      return null;
    } catch (err) {
      return null;
    }
  }
}
