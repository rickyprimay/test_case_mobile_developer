
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:game_list_app/data/remote/response/api_response.dart';
import 'package:game_list_app/models/GameModel/game_model.dart';
import 'package:game_list_app/repository/game_repo.dart';
import 'package:logger/logger.dart';

class HomeViewModel with ChangeNotifier {
  final _repo = GameRepo();

  var logger = Logger();

  ApiResponse<GameResult> gameResult = ApiResponse.loading();
  ApiResponse<GameResult> randomGameResult = ApiResponse.loading();
  ApiResponse<GameResult> randomGameResultForYou = ApiResponse.loading();
  ApiResponse<GameResult> searchResult = ApiResponse.loading();

  final int randomGamesCount = 5;

  void _setGameResult(ApiResponse<GameResult> response) {
    gameResult = response;
    notifyListeners();
  }

  void _setRandomGameResult(ApiResponse<GameResult> response) {
    randomGameResult = response;
    notifyListeners();
  }

  void _setRandomGameResultForYou(ApiResponse<GameResult> response) {
    randomGameResultForYou = response;
    notifyListeners();
  }

  void _setSearchResult(ApiResponse<GameResult> response) {
    searchResult = response;
    notifyListeners();
  }

  Future<void> fetchGameList() async {
    _setGameResult(ApiResponse.loading());
    try {
      final games = await _repo.getGamesList();
      _setGameResult(ApiResponse.completed(games));
      fetchRandomGame();
      fetchRandomGameForYou();
    } catch (e) {
      _setGameResult(ApiResponse.error(e.toString()));
    }
  }

  Future<void> fetchRandomGame() async {
    if (gameResult.data != null && gameResult.data!.results.isNotEmpty) {
      var games = gameResult.data!.results;
      var shuffledGames = List<Game>.from(games)..shuffle();
      var numberOfGames = min(randomGamesCount, shuffledGames.length);

      var randomGames = shuffledGames.take(numberOfGames).toList();
      _setRandomGameResult(ApiResponse.completed(GameResult(results: randomGames)));
    }
  }

  Future<void> fetchRandomGameForYou() async {
    if (gameResult.data != null && gameResult.data!.results.isNotEmpty) {
      var games = gameResult.data!.results;
      var shuffledGames = List<Game>.from(games)..shuffle();
      var numberOfGames = min(randomGamesCount, shuffledGames.length);

      var randomGames = shuffledGames.take(numberOfGames).toList();
      _setRandomGameResultForYou(ApiResponse.completed(GameResult(results: randomGames)));
    }
  }

  Future<void> fetchSearchGame(String query) async {
    logger.i("Searching for: $query"); 

    _setSearchResult(ApiResponse.loading());

    try {
      final games = await _repo.searchGame(query);

      logger.f("Search results: ${games.results.length} games found");

      _setSearchResult(ApiResponse.completed(games));
    } catch (e) {
      logger.e("Error fetching search results: $e"); 
      _setSearchResult(ApiResponse.error(e.toString()));
    }
  }

}