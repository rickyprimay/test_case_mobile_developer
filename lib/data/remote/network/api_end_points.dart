import 'package:game_list_app/utils/api_key.dart';
import 'package:game_list_app/utils/base_url.dart';

class ApiEndPoints {
  String get baseUrl => BaseUrl.baseUrl;
  final String apiKey = ApiKey.apiKey;

  String gamesList({int page = 1, int pageSize = 20}) {
    return "$baseUrl/games?page=$page&page_size=$pageSize&key=$apiKey";
  }

  String randomGamesList({int page = 20, int pageSize = 40}) {
    return "$baseUrl/games?page=$page&page_size=$pageSize&key=$apiKey";
  }

  String searchGame(String query) {
    return "$baseUrl/games?search=$query&key=$apiKey";
  }

  String gameDetail(int id) {
    return "$baseUrl/games/$id?key=$apiKey";
  }
}