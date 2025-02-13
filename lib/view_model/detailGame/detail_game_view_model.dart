import 'package:flutter/material.dart';
import 'package:game_list_app/data/remote/response/api_response.dart';
import 'package:game_list_app/models/GameDetailModel/game_detail_model.dart';
import 'package:game_list_app/repository/game_repo.dart';
import 'package:logger/logger.dart';

class DetailGameViewModel extends ChangeNotifier {
  final _repo = GameRepo();

  var logger = Logger();

  ApiResponse<GameDetail> gameDetail = ApiResponse.loading();

  void _setGameDetail(ApiResponse<GameDetail> response) {
    gameDetail = response;
    notifyListeners();
  }

  Future<void> fetchGameDetail(int id) async {
    _setGameDetail(ApiResponse.loading());
    try {
      final gameDetail = await _repo.getGameDetail(id);
      _setGameDetail(ApiResponse.completed(gameDetail));
    } catch (e) {
      _setGameDetail(ApiResponse.error(e.toString()));
    }
  }
}