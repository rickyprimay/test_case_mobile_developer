class Game {
  final int id;
  final String name;
  final String backgroundImage;
  final double rating;
  final String released;
  final List<Screenshot> shortScreenshots;

  Game({
    required this.id,
    required this.name,
    required this.backgroundImage,
    required this.rating,
    required this.released,
    required this.shortScreenshots,
  });

  Uri? get backgroundImageURL => Uri.tryParse(backgroundImage);

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'] as int,
      name: json['name'] ?? 'Unknown',
      backgroundImage: json['background_image'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      released: json['released'] ?? 'TBA',
      shortScreenshots: (json['short_screenshots'] as List?)
          ?.map((s) => Screenshot.fromJson(s))
          .toList() ?? [],
    );
  }

  // Tambahkan method toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'background_image': backgroundImage,
      'rating': rating,
      'released': released,
      'short_screenshots': shortScreenshots.map((s) => s.toJson()).toList(),
    };
  }
}

class GameResult {
  final List<Game> results;

  GameResult({required this.results});

  factory GameResult.fromJson(Map<String, dynamic> json) {
    return GameResult(
      results: (json['results'] as List)
          .map((game) => Game.fromJson(game))
          .toList(),
    );
  }
}

class Screenshot {
  final String image;

  Screenshot({required this.image});

  Uri? get screenShotURL => Uri.tryParse(image);

  factory Screenshot.fromJson(Map<String, dynamic> json) {
    return Screenshot(image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
    };
  }
}