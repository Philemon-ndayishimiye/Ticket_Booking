import 'package:flutter/material.dart';

class TopNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSignIn;
  final VoidCallback onUser;
  final VoidCallback onNotification;
  final bool hasToken;              // <— CHECK LOGIN
  final int notificationCount;      // <— BADGE COUNT
  final String? userName;

  const TopNavigationBar({
    Key? key,
    required this.onSignIn,
    required this.onUser,
    required this.onNotification,
    required this.hasToken,
    this.notificationCount = 0,
    this.userName,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side: logo and title
          Row(
            children: [
              Image.asset(
                'assets/images/logo.jpg',
                height: 30,
              ),
              const SizedBox(width: 8),
              const Text(
                "Ticket Booking",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),

          // Right side section
          Row(
            children: [
              /// ------------------------------
              /// SHOW NOTIFICATION ONLY IF LOGGED IN
              /// ------------------------------
              if (hasToken) 
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications, color: Colors.white),
                      onPressed: onNotification,
                    ),
                    
                    // BADGE
                    if (notificationCount > 0)
                      Positioned(
                        right: 4,
                        top: 4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            notificationCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

              const SizedBox(width: 10),

              /// USER ICON / SIGN IN
              if (!hasToken)
                TextButton(
                  onPressed: onSignIn,
                  child: const Text("Sign In", style: TextStyle(color: Colors.white)),
                )
              else
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.person, color: Colors.white),
                      onPressed: onUser,
                    ),
                    if (userName != null)
                      Text(
                        userName!,
                        style: const TextStyle(color: Colors.white),
                      ),
                  ],
                ),
            ],
          )
        ],
      ),
    );
  }
}
