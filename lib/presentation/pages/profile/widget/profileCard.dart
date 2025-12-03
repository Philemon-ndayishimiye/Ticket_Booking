import 'package:flutter/material.dart';

class ProfileInfoCard extends StatelessWidget {
  final String title;
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const ProfileInfoCard({
    Key? key,
    required this.title,
    required this.label,
    this.icon = Icons.person,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Icon(icon, size: 30),
                  ],
                ),
              ),
              Positioned(
                top: 17,
                left: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    label,
                    style: const TextStyle(color: Colors.black, fontSize: 14 , fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: Colors.grey),
      ],
    );
  }
}
