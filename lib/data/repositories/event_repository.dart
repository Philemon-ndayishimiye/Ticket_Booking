import 'package:ticket_booking/core/network/api_client.dart';
import 'package:ticket_booking/core/constants/api_endpoints.dart';
import 'package:ticket_booking/data/models/Event_model.dart';

//import 'package:ticket_booking/data/models/TicketModel.dart';

class EventRepository {
  final ApiClient apiClient;

  EventRepository(this.apiClient);

  Future<List<EventSummaryModel>> getEvents() async {
    final response = await apiClient.get(ApiEndpoints.events, useToken: false);
    final List data = response["data"] as List? ?? [];
    return data.map((e) => EventSummaryModel.fromJson(e)).toList();
  }

  Future<EventDetailModel> getEventById(String id) async {
    final response = await apiClient.get('${ApiEndpoints.eventsDetail}$id/', useToken: true);
    return EventDetailModel.fromJson(response['data']);
  }
}
