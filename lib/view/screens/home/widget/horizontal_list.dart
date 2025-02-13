import 'package:flutter/material.dart';
import 'package:game_list_app/models/GameModel/game_model.dart';
import 'package:game_list_app/view/screens/home/widget/game_card.dart';

class HorizontalList extends StatelessWidget {
  final List<Game> games; 

  const HorizontalList({super.key, required this.games});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: games.length,
        itemBuilder: (context, index) => Container(
          width: 300,
          margin: const EdgeInsets.only(right: 8),
          child: GameCard(game: games[index]),
        ),
      ),
    );
  }
}