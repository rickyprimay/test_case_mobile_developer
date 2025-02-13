import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:game_list_app/view/screens/home/widget/result_game_card.dart';
import 'package:game_list_app/view_model/favoritesGame/favorite_game_view_model.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites Games", style: TextStyle(fontSize: 20, fontFamily: "Quicksand", fontWeight: FontWeight.w600)),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.blueGrey[800],
            ),
          ),
          Align(
            alignment: const Alignment(1.2, -0.3),
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueGrey[400],
              ),
            ),
          ),
          Align(
            alignment: const Alignment(-1.2, -0.3),
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueGrey[500],
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, -1.2),
            child: Container(
              height: 300,
              width: 600,
              decoration: BoxDecoration(color: Colors.blueGrey[600]),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Consumer<FavoriteGameViewModel>(
            builder: (context, viewModel, child) {
              final favoriteGames = viewModel.favoriteGames;

              if (favoriteGames.isEmpty) {
                return Center(child: Text('No favorite games found.', style: TextStyle(color: Colors.white)));
              }

              return ListView.builder(
                itemCount: favoriteGames.length,
                itemBuilder: (context, index) {
                  final game = favoriteGames[index];
                  return ResultGameCard(game: game);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
