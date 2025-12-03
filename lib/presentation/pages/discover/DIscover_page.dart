import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_booking/presentation/pages/discover/widget/Card.dart';
import 'package:ticket_booking/presentation/pages/home/widgets/ButtonNavigation.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  int _currentIndex = 1; // current index for bottom nav

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
      // Handle navigation logic based on the index
    switch (index) {
      case 0:
        // Navigate to Home
        context.go('/');
        print('home');
        break;
      case 1:
        print('discover');
        context.go('/discover');
        break;
      case 2:
        // Navigate to My Tickets
        context.go('/ticketpage');
        print('my ticket');
        break;
      case 3:
      context.go('/profile');
        // Navigate to Events
        print('events');
        break;
      case 4:
        // Navigate to Profile
        context.go('/profile');
        print('profile ');
        break;
    }
  }

  final List<Map<String, String>> categories = [
    {
      'image': 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d',
      'category': 'Concert',
    },
    {
      'image': 'https://images.unsplash.com/photo-1521737604893-d14cc237f11d',
      'category': 'BasketBall',
    },
    {
      'image': 'https://images.unsplash.com/photo-1499951360447-b19be8fe80f5',
      'category': 'VolleyBallNetworking',
    },
    {
      'image': 'https://images.unsplash.com/photo-1517486808906-6ca8b3f04846',
      'category': 'Workshops',
    },
    {
      'image': 'https://images.unsplash.com/photo-1503341455253-b2e723bb3dbb',
      'category': 'Seminars',
    },
    {
      'image': 'https://images.unsplash.com/photo-1472214103451-9374bd1c798e',
      'category': 'Trade Shows',
    },

    {
      'image': 'https://images.unsplash.com/photo-1472214103451-9374bd1c798e',
      'category': 'Part',
    },

    {
      'image': 'https://images.unsplash.com/photo-1472214103451-9374bd1c798e',
      'category': 'Festivals',
    },

    {
      'image': 'https://images.unsplash.com/photo-1472214103451-9374bd1c798e',
      'category': 'Movie shows',
    },

    {
      'image': 'https://images.unsplash.com/photo-1472214103451-9374bd1c798e',
      'category': 'Sponsorships',
    },

    {
      'image': 'https://images.unsplash.com/photo-1472214103451-9374bd1c798e',
      'category': 'Webinars',
    },

    {
      'image': 'https://images.unsplash.com/photo-1472214103451-9374bd1c798e',
      'category': 'Speaker sessions',
    },

    {
      'image': 'https://images.unsplash.com/photo-1472214103451-9374bd1c798e',
      'category': 'Expositions',
    },
  ];

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discover',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      // <-- just close AppBar with comma, no semicolon
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 0, right: 8),
                  child: Icon(
                    Icons.search,
                    color: Colors.blue, // change the icon color
                    size: 28, // change the icon size
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 40,
                  minHeight: 40,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // category
            Text(
              'Search By Category',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            // all category
            Expanded(
              child: ListView(
                children: categories.map((item) {
                  return CategoryCard(
                    imageUrl: item['image']!,
                    category: item['category']!,
                    onTap: () {
                      print('Clicked on ${item['category']}');
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      //  Add your custom bottom navigation
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
