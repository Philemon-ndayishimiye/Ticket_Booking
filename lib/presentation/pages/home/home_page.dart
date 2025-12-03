import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking/presentation/pages/home/Event_view_model.dart';
import 'package:ticket_booking/presentation/pages/home/widgets/TopNavigation.dart';
import 'package:ticket_booking/presentation/pages/home/widgets/ButtonNavigation.dart';
import 'package:ticket_booking/presentation/pages/home/widgets/image_carousel.dart';
import 'package:ticket_booking/presentation/pages/home/widgets/ActivityCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String? token;
  String? userName;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    loadToken();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loaded) {
      context.read<EventViewModel>().loadEvents();
      _loaded = true;
    }
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      userName = prefs.getString('username');
      _loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventVM = Provider.of<EventViewModel>(context);

    return Scaffold(
      appBar: _loaded
          ? TopNavigationBar(
              onSignIn: () => context.go('/login'),
              onNotification: () => context.go('/notifications'),
              onUser: () => context.go('/myprofile'),
              hasToken: token != null && token!.isNotEmpty,
              userName: token != null && token!.isNotEmpty ? userName : null,
              notificationCount: token != null && token!.isNotEmpty ? 5 : 0,
            )
          : null,

      body: Container(
        color: Colors.blueAccent,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 0),
              ImageCarousel(),
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

              eventVM.isLoading
                  ? CircularProgressIndicator()
                  : Column(
                      children: eventVM.events.map((event) {
                        return ActivityCard(
                          backgroundImage:
                              event.bannerImage ??
                              'assets/images/placeholder.png',
                          activityNames: [event.title, event.venue.name],
                          onTap: () => context.go('/eventplace/${event.id}'),
                        );
                      }).toList(),
                    ),

              SizedBox(height: 80),
            ],
          ),
        ),
      ),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onItemTapped: (index) {
          setState(() => _currentIndex = index);
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/discover');
              break;
            case 2:
              context.go('/ticketpage');
              break;
            case 3:
              context.go('/events');
              break;
            case 4:
              context.go('/profile');
              break;
          }
        },
      ),
    );
  }
}
