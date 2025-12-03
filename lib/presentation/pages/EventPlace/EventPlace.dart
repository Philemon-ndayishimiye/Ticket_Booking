import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ticket_booking/presentation/pages/home/Event_view_model.dart';
import 'package:ticket_booking/presentation/pages/EventPlace/widget/ReusableEventPage.dart';

class EventPlacePage extends StatefulWidget {
  final String eventId;

  final dateFormatter = DateFormat('yyyy-MM-dd');
  final timeFormatter = DateFormat('HH:mm');

  EventPlacePage({Key? key, required this.eventId}) : super(key: key);

  @override
  State<EventPlacePage> createState() => _EventPlacePageState();
}

class _EventPlacePageState extends State<EventPlacePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<EventViewModel>();
      vm.loadEventById(widget.eventId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<EventViewModel>();

    if (vm.isLoading || vm.selectedEvent == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Loading..."),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => {context.go('/')},
          ),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final event = vm.selectedEvent!;

    return EventPage(
      bannerImage: event.bannerImage ?? 'assets/images/placeholder.png',
      eventTitle: event.title,
      description: event.description,
      eventDate: event.startDatetime.toIso8601String().split('T').first,
      eventTime:
          '${event.startDatetime.toIso8601String().split('T').last.split('Z').first} - '
          '${event.endDatetime.toIso8601String().split('T').last.split('Z').first}',

      tickets: event.ticketTypes,
      onTicketTap: (ticket) {
        print("Clicked ticket: ${ticket.type}");
      },
    );
  }
}
