class GameDetail {
  final String descriptionRaw;

  GameDetail({required this.descriptionRaw});

  factory GameDetail.fromJson(Map<String, dynamic> json) {
    return GameDetail(
      descriptionRaw: json['description_raw'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description_raw': descriptionRaw,
    };
  }
}