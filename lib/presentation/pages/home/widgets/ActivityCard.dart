import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String backgroundImage;
  final List<String> activityNames; // e.g., ['Yoga', 'Meditation']
  final VoidCallback? onTap;

  const ActivityCard({
    Key? key,
    required this.backgroundImage,
    required this.activityNames,
    required  this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 90% of screen width
    final double cardWidth = MediaQuery.of(context).size.width * 0.9;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: 195,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.4), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: activityNames
                .map(
                  (name) => Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
