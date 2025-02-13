import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:game_list_app/models/GameModel/game_model.dart';
import 'package:game_list_app/view/screens/gameDetail/game_detail_screen.dart';
import 'package:game_list_app/view_model/favoritesGame/favorite_game_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ResultGameCard extends StatelessWidget {
  final Game game;

  const ResultGameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteGameViewModel>(
      builder: (context, viewModel, child) {
        bool isFavorite = viewModel.isFavorite(game);

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context, MaterialPageRoute(
                builder: (context) => GameDetailScreen(
                  gameId: game.id, 
                  gameName: game.name,
                  gameBackgroundImage: game.backgroundImage,
                  gameRating: game.rating.toStringAsFixed(2),
                  gameReleased: game.released,
                  gameScreenshots: game.shortScreenshots,
                )
              )
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ExtendedImage.network(
                      game.backgroundImage,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 120,
                      cache: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                game.name,
                                style: GoogleFonts.quicksand(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
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
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              game.rating.toStringAsFixed(2),
                              style: GoogleFonts.quicksand(color: Colors.white, fontWeight: FontWeight.w400),
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
                        const SizedBox(height: 4),
                        Text(
                          "Released: ${game.released}",
                          style: GoogleFonts.quicksand(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
