import 'package:game_list_app/data/remote/network/api_end_points.dart';
import 'package:game_list_app/data/remote/network/network_api_service.dart';
import 'package:game_list_app/models/GameModel/game_model.dart';
import 'package:logger/logger.dart';

class GameRepo {
  var logger = Logger();

  final ApiEndPoints _apiEndPoints = ApiEndPoints();
  final NetworkApiService _networkApiService = NetworkApiService();

  Future<GameResult> getGamesList({int page = 1, int pageSize = 20}) async {
    try {
      final url = _apiEndPoints.gamesList(page: page, pageSize: pageSize);
      // logger.i(url);
      final response = await _networkApiService.getResponse(url);
      // logger.i(response);
      return GameResult.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load games: $e');
    }
  }

  Future<GameResult> searchGame(String query) async {
    try {
      final url = _apiEndPoints.searchGame(query);
      final response = await _networkApiService.getResponse(url);
      // logger.i(response);
      return GameResult.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load games: $e');
    }
  }
  
}