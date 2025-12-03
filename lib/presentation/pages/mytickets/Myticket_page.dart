import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_booking/presentation/pages/home/widgets/ButtonNavigation.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({Key? key}) : super(key: key);

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> with SingleTickerProviderStateMixin {
  int _currentIndex = 2; // ticket page is 3rd item in bottom nav
  int _selectedTab = 0; // 0 = Reserved, 1 = Past

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      // TODO: add navigation if needed
    });
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
        // Navigate to Events
        context.go('/profile');
        print('events');
        break;
      case 4:
        // Navigate to Profile
        context.go('/profile');
        print('profile ');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Tickets',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: Column(
        children: [
          // Top navigation tabs
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // Reserved Tab
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: _selectedTab == 0 ? Colors.blue : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Reserved',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: _selectedTab == 0 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),

                // Past Tab
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: _selectedTab == 1 ? Colors.blue : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Past',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: _selectedTab == 1 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content based on selected tab
          Expanded(
            child: _selectedTab == 0 ? _buildReservedTickets() : _buildPastTickets(),
          ),
        ],
      ),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  // Reserved Tickets
  Widget _buildReservedTickets() {
    // Dummy content, replace with your actual data
    return ListView.builder(
      itemCount: 5,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: ListTile(
            title: Text('Reserved Ticket ${index + 1}'),
            subtitle: const Text('Event Details Here'),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        );
      },
    );
  }

  // Past Tickets
  Widget _buildPastTickets() {
    // Dummy content, replace with your actual data
    return ListView.builder(
      itemCount: 3,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: ListTile(
            title: Text('Past Ticket ${index + 1}'),
            subtitle: const Text('Event Details Here'),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        );
      },
    );
  }
}
