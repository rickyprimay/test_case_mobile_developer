import 'package:flutter/material.dart';
import 'package:game_list_app/view/screens/home/widget/result_game_card.dart';
import 'package:game_list_app/view/shared/background.dart';
import 'package:game_list_app/view_model/favoritesGame/favorite_game_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {

  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites Games", style: GoogleFonts.quicksand(fontSize: 20, fontWeight: FontWeight.w700)),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Background(),
          Consumer<FavoriteGameViewModel>(
            builder: (context, viewModel, child) {
              final favoriteGames = viewModel.favoriteGames;

              if (favoriteGames.isEmpty) {
                return Center(child: Text('No favorite games found.', style: GoogleFonts.quicksand(color: Colors.white, fontWeight: FontWeight.w500)));
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
