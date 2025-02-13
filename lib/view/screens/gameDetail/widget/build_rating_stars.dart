import 'package:flutter/material.dart';

class BuildRatingStars extends StatelessWidget {

  const BuildRatingStars({super.key, required this.rating});
  final double rating;

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return Row(
      children: [
        for (int i = 0; i < fullStars; i++)
          Icon(Icons.star, color: Colors.yellow),
        if (hasHalfStar)
          Icon(Icons.star_half, color: Colors.yellow),
        for (int i = 0; i < emptyStars; i++)
          Icon(Icons.star_border, color: Colors.yellow),
      ],
    );
  }
}