import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:game_list_app/models/GameModel/game_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteGameViewModel extends ChangeNotifier {

  List<Game> _favoriteGames = [];

  List<Game> get favoriteGames => _favoriteGames;

  Future<void> loadFavoriteGames() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteGames = prefs.getStringList('favorite_games') ?? [];

    _favoriteGames = favoriteGames.map((gameString) {
      final gameJson = jsonDecode(gameString);
      return Game.fromJson(gameJson);
    }).toList();
    
    notifyListeners();
  }

  Future<void> addFavoriteGame(Game game) async {
    final prefs = await SharedPreferences.getInstance();
    
    final gameString = jsonEncode(game.toJson());
    final updatedFavorites = List<String>.from(prefs.getStringList('favorite_games') ?? [])..add(gameString);

    await prefs.setStringList('favorite_games', updatedFavorites);
    
    _favoriteGames.add(game);
    notifyListeners();
  }

  Future<void> removeFavoriteGame(Game game) async {
    final prefs = await SharedPreferences.getInstance();
    
    final gameString = jsonEncode(game.toJson());
    final updatedFavorites = List<String>.from(prefs.getStringList('favorite_games') ?? [])
      ..remove(gameString);

    await prefs.setStringList('favorite_games', updatedFavorites);
    
    _favoriteGames.remove(game);
    notifyListeners();
  }

  bool isFavorite(Game game) {
    return _favoriteGames.contains(game);
  }

  Future<void> loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteGames = prefs.getStringList('favorite_games') ?? [];

    _favoriteGames = favoriteGames.map((gameString) {
      final gameJson = jsonDecode(gameString);
      return Game.fromJson(gameJson);
    }).toList();
    
    notifyListeners();
  }
}
