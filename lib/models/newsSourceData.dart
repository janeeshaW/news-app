import 'package:news_first_app/utilities/functions.dart';

class NewsSourceData {
  late String id;
  late String name;

  NewsSourceData.fromJson(dynamic f) {
    id = f["id"] ?? "";
    name = f["name"] ?? "";
  }
}
