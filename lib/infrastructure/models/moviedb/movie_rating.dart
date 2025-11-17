class MovieRating {
  final String certification;

  MovieRating({required this.certification});

  factory MovieRating.fromJson(Map<String, dynamic> json) {
    return MovieRating(
      certification: json['certification'] ?? '',
    );
  }
}
