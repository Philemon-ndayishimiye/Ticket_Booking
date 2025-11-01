import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({Key? key}) : super(key: key);

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  final List<String> images = [
    'assets/images/arena.png',
    'assets/images/convetion.png',
    'assets/images/intare.png',
  ];

  @override
  void initState() {
    super.initState();
    // Auto-scroll every 3 seconds
    Future.delayed(const Duration(seconds: 3), _autoScroll);
  }

  void _autoScroll() {
    if (!mounted) return;
    _currentPage++;
    if (_currentPage >= images.length) _currentPage = 0;

    _controller.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );

    Future.delayed(const Duration(seconds: 3), _autoScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent, // Full background color
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: SizedBox(
        height: 220,
        child: PageView.builder(
          controller: _controller,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 🖼️ Background image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),

                  // 🌑 Transparent dark overlay
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black26,
                    ),
                  ),

                  // 🏷️ Centered "Book Now" with padding and rounded edges
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12, // x-axis padding = 3 * 4 (Flutter uses px)
                      vertical: 4, // y-axis padding = 1 * 4
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Book Now',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
