class GameDetail {
  // ignore: non_constant_identifier_names
  final String description_raw;

  GameDetail({
    // ignore: non_constant_identifier_names
    required this.description_raw
  });

  factory GameDetail.fromJson(Map<String, dynamic> json) {
    return GameDetail(
      description_raw: json['description_raw'] ?? 'Unknown',
    );
  }
}