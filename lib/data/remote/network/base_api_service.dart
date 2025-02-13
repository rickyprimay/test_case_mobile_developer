abstract class BaseApiService {
  String get baseUrl;

  Future<dynamic> getResponse(String url);
}