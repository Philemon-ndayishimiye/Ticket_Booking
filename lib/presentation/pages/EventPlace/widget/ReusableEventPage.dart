import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_booking/data/models/Event_model.dart';

class EventPage extends StatelessWidget {
  final String bannerImage;
  final String eventTitle;
  final String eventDate;
  final String eventTime;
  final String description; //  new field
  final List<TicketModel> tickets;

  // Add a callback for ticket clicks
  final void Function(Ticket ticket)? onTicketTap;

  const EventPage({
    Key? key,
    required this.bannerImage,
    required this.eventTitle,
    required this.eventDate,
    required this.eventTime,
    required this.description, // ✅ required
    required this.tickets,
    this.onTicketTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(eventTitle),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Image with overlay
            Stack(
              children: [
                Image.network(
                  bannerImage,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: double.infinity,
                      height: 250,
                      color: Colors.grey[300],
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 250,
                      color: Colors.grey[300],
                      child: Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 50,
                          color: Colors.grey[700],
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '$eventDate • $eventTime',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            // ✅ Short description below banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),

            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Ticket categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),

            // Ticket Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: tickets.map((ticketModel) {
                  final ticket = Ticket(
                    type: ticketModel.name,
                    price: "\$${ticketModel.price}",
                  );

                  return TicketCard(
                    ticket: ticket,
                    onTap: () {
                      if (onTicketTap != null) {
                        onTicketTap!(ticket);
                      }
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Ticket model
class Ticket {
  final String type;
  final String price;

  Ticket({required this.type, required this.price});
}

// Ticket Card widget with onTap
class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final VoidCallback? onTap;

  const TicketCard({Key? key, required this.ticket, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: ListTile(
          leading: Icon(Icons.confirmation_num, color: Colors.deepPurple),
          title: Text(
            ticket.type,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          trailing: Text(
            ticket.price,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
