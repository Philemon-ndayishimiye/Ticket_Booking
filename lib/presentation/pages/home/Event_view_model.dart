import 'package:flutter/material.dart';
import 'package:ticket_booking/data/models/Event_model.dart';
//import 'package:ticket_booking/data/models/TicketModel.dart';
import 'package:ticket_booking/data/repositories/event_repository.dart';

class EventViewModel extends ChangeNotifier {
  final EventRepository eventRepository;

  EventViewModel({required this.eventRepository});

  List<EventSummaryModel> events = [];
  bool isLoading = false;
  EventDetailModel? selectedEvent;

  Future<void> loadEvents() async {
    isLoading = true;
    notifyListeners();

    try {
      events = await eventRepository.getEvents();
    } catch (e) {
      print("Error loading events: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadEventById(String id) async {
    isLoading = true;
    notifyListeners();

    try {
      selectedEvent = await eventRepository.getEventById(id);
    } catch (e) {
      print("Error loading event by ID: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
