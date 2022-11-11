import 'package:news_first_app/models/newsSourceData.dart';
import 'package:news_first_app/utilities/functions.dart';

class NewsArticles {
  late NewsSourceData source;
  late String author;
  late String title;
  late String description;
  late String url;
  late String urlToImage;
  late String publishedAt;
  late String content;

  NewsArticles.fromJson(dynamic f) {
    source = NewsSourceData.fromJson(f["source"]);
    author = f["author"] ?? "";
    title = f["title"] ?? "";
    description = f["description"] ?? "";
    url = f["url"] ?? "";
    urlToImage = f["urlToImage"] ?? "";
    publishedAt = dateFormatter(DateTime.parse(f["publishedAt"])) +
        " " +
        timeFormatter(DateTime.parse(f["publishedAt"]));
    content = f["content"] ?? "";
  }
}
