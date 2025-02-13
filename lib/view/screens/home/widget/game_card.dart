import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:game_list_app/models/GameModel/game_model.dart';
import 'package:game_list_app/view/screens/gameDetail/game_detail_screen.dart';
import 'package:game_list_app/view_model/favoritesGame/favorite_game_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class GameCard extends StatelessWidget {
  final Game game;

  const GameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteGameViewModel>(
      builder: (context, viewModel, child) {

        bool isFavorite = viewModel.isFavorite(game);

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (_) => FavoriteGameViewModel(), 
                  child: GameDetailScreen(
                    gameId: game.id,
                    gameName: game.name,
                    gameBackgroundImage: game.backgroundImage,
                    gameRating: game.rating.toStringAsFixed(2),
                    gameReleased: game.released,
                    gameScreenshots: game.shortScreenshots,
                  ),
                ),
              ),
            );
          },
          child: Card(
            color: Colors.grey[850],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: ExtendedImage.network(
                    game.backgroundImage,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: 150,
                    cache: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              game.name,
                              style: GoogleFonts.quicksand(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (isFavorite) {
                                viewModel.removeFavoriteGame(game);
                                Toast.show("${game.name} removed from Favorites", gravity: Toast.top, backgroundColor: Colors.red);
                              } else {
                                viewModel.addFavoriteGame(game);
                                Toast.show("${game.name} added to Favorites", gravity: Toast.top, backgroundColor: Colors.blue);
                              }
                            },
                            child: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            game.rating.toStringAsFixed(2),
                            style: GoogleFonts.quicksand(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 4),
                          ...List.generate(
                            game.rating.floor(),
                            (index) => const Icon(Icons.star, color: Colors.yellow, size: 16),
                          ),
                          if (game.rating - game.rating.floor() >= 0.5)
                            const Icon(Icons.star_half, color: Colors.yellow, size: 16),
                          ...List.generate(
                            5 - game.rating.round().clamp(0, 5),
                            (index) => const Icon(Icons.star_border, color: Colors.yellow, size: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
