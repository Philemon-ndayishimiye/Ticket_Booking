import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_booking/presentation/pages/home/widgets/TopNavigation.dart';
import 'package:ticket_booking/presentation/pages/home/widgets/ButtonNavigation.dart';
import 'package:ticket_booking/presentation/pages/home/widgets/image_carousel.dart';
import 'package:ticket_booking/presentation/pages/home/widgets/ActivityCard.dart';
import 'package:ticket_booking/presentation/pages/login/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Handle navigation logic based on the index
    switch (index) {
      case 0:
        // Navigate to Home
        print('home');
        break;
      case 1:
        print('discover');
        // Navigate to Discover
        break;
      case 2:
        // Navigate to My Tickets
        print('my ticket');
        break;
      case 3:
        // Navigate to Events
        print('events');
        break;
      case 4:
        // Navigate to Profile
        print('profile ');
        break;
    }
  }

  void _handleSignIn() {
    // TODO: Navigate to sign-in page
    Navigator.push(context, MaterialPageRoute(builder:(context)=>LoginPage() ),);
  }

  void _handleNotifications() {
    // TODO: Handle notifications
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigationBar(
        onSignIn: _handleSignIn,
        onNotifications: _handleNotifications,
      ),

      body: Container(
        color: Colors.blueAccent, // background color
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 0),
              ImageCarousel(), // Carousel section
              SizedBox(height: 12),
              Text(
                "Best Location",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15),

              ActivityCard(
                backgroundImage: 'assets/images/arena.png',
                activityNames: ['Live Music', 'Volley Ball'],
                onTap: ()=>{print('arena')},
              ),

              SizedBox(height: 10),

               ActivityCard(
                backgroundImage: 'assets/images/intare.png',
                activityNames: ['concert' ,'youth connect'],
                onTap: ()=>{print('intare')},
              ),

              SizedBox(height: 10),

              ActivityCard(
                backgroundImage: 'assets/images/convetion.png',
                activityNames: ['digital program' ,''],
                onTap: ()=>{'convention'},
              ),

              SizedBox(height: 10),
            ],
          ),
        ),
      ),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
