
import 'package:game_list_app/data/remote/network/base_api_service.dart';
import 'package:game_list_app/utils/base_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkApiService implements BaseApiService {
  
  @override
  String get baseUrl => BaseUrl.baseUrl;

  @override
  Future<dynamic> getResponse(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }
  
}