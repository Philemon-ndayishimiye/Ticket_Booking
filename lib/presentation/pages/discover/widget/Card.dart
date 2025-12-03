import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String category;
  final VoidCallback? onTap;

  const CategoryCard({
    Key? key,
    required this.imageUrl,
    required this.category,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Left: Image thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image.network(
                  imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 50,
                      color: Color.fromRGBO(240, 248, 255, 1.0),
                      child: const Icon(Icons.broken_image, color: Colors.white),
                    );
                  },
                ),
              ),

              const SizedBox(width: 16),

              // Right: Category label
              Expanded(
                child: Text(
                  category,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
