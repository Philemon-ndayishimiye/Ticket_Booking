import 'package:flutter/material.dart';

class ProfileFlatCard extends StatelessWidget {
  final String title;
  final IconData leftIcon;
  final IconData rightIcon;
  final VoidCallback? onTap;

  const ProfileFlatCard({
    Key? key,
    required this.title,
    required this.leftIcon,
    required this.rightIcon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(leftIcon, size: 30),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Icon(rightIcon, size: 30),
          ],
        ),
      ),
    );
  }
}
