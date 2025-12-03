import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.search, 'label': 'Discover'},
      {'icon': Icons.confirmation_num, 'label': 'My Tickets'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];

    return Container(
      color: const Color(0xFF3B82F6),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isSelected = currentIndex == index;
          return InkWell(
            onTap: () => onItemTapped(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  items[index]['icon'] as IconData,
                  color: isSelected ? Colors.yellow : Colors.white,
                ),
                Text(
                  items[index]['label'] as String,
                  style: TextStyle(
                    color: isSelected ? Colors.yellow : Colors.white,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
