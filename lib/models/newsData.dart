import 'package:news_first_app/models/newsArticles.dart';
import 'package:news_first_app/utilities/functions.dart';

class NewsData {
  late String status;
  late int totalResults;
  late List<NewsArticles> articles;

  NewsData.fromJson(dynamic f) {
    status = f["status"];
    totalResults = f["totalResults"];
    articles =
        (f["articles"] as List).map((e) => NewsArticles.fromJson(e)).toList();
  }
}
