import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String backgroundImage; // network URL or asset path
  final List<String> activityNames;
  final VoidCallback? onTap;

  const ActivityCard({
    Key? key,
    required this.backgroundImage,
    required this.activityNames,
    required this.onTap,
  }) : super(key: key);

  bool isNetworkImage(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width * 0.9;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: 195,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // ---------- IMAGE SECTION ----------
              Positioned.fill(
                child: isNetworkImage(backgroundImage)
                    ? Image.network(
                        backgroundImage,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          "assets/images/placeholder.png",
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        backgroundImage,
                        fit: BoxFit.cover,
                      ),
              ),

              // ---------- GRADIENT OVERLAY ----------
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.transparent
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),

              // ---------- TEXT SECTION ----------
              Positioned(
                bottom: 12,
                left: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: activityNames
                      .map(
                        (name) => Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 4,
                                color: Colors.black,
                                offset: Offset(1, 1),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
