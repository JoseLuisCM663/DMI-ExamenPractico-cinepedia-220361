import 'package:flutter/material.dart';

class MovieRatingPill extends StatelessWidget {
  final String rating;

  const MovieRatingPill({super.key, required this.rating});

  Color _backgroundColor(String r) {
    switch (r) {
      case 'G':
        return Colors.green;
      case 'PG':
        return Colors.blue;
      case 'PG-13':
        return Colors.orange;
      case 'R':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _backgroundColor(rating);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6),
        ],
      ),
      child: Text(
        rating,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
