// models/event_models.dart

import 'package:flutter/foundation.dart';

class EventSummaryModel {
  final int id;
  final String title;
  final String description;
  final DateTime startDatetime;
  final DateTime endDatetime;
  final String status;
  final bool isFeatured;
  final Venue venue;
  final String? category;
  final String? categoryDisplay;
  final List<Tag> tags;
  final String? bannerImage;
  final String organizerName;
  final bool isActive;
  final DateTime createdAt;

  EventSummaryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startDatetime,
    required this.endDatetime,
    required this.status,
    required this.isFeatured,
    required this.venue,
    this.category,
    this.categoryDisplay,
    required this.tags,
    this.bannerImage,
    required this.organizerName,
    required this.isActive,
    required this.createdAt,
  });

  factory EventSummaryModel.fromJson(Map<String, dynamic> json) {
    return EventSummaryModel(
      id: json["id"] ?? 0,
      title: json["title"] ?? '',
      description: json["description"] ?? '',
      startDatetime: DateTime.tryParse(json["start_datetime"] ?? '') ?? DateTime.now(),
      endDatetime: DateTime.tryParse(json["end_datetime"] ?? '') ?? DateTime.now(),
      status: json["status"] ?? '',
      isFeatured: json["is_featured"] ?? false,
      venue: Venue.fromJson(json["venue"] ?? {}),
      category: json["category"],
      categoryDisplay: json["category_display"],
      tags: (json["tags"] as List? ?? []).map((t) => Tag.fromJson(t)).toList(),
      bannerImage: json["banner_image"],
      organizerName: json["organizer_name"] ?? '',
      isActive: json["is_active"] ?? false,
      createdAt: DateTime.tryParse(json["created_at"] ?? '') ?? DateTime.now(),
    );
  }
}

class EventDetailModel extends EventSummaryModel {
  final List<TicketModel> ticketTypes;

  EventDetailModel({
    required int id,
    required String title,
    required String description,
    required DateTime startDatetime,
    required DateTime endDatetime,
    required String status,
    required bool isFeatured,
    required Venue venue,
    String? category,
    String? categoryDisplay,
    required List<Tag> tags,
    String? bannerImage,
    required String organizerName,
    required bool isActive,
    required DateTime createdAt,
    required this.ticketTypes,
  }) : super(
          id: id,
          title: title,
          description: description,
          startDatetime: startDatetime,
          endDatetime: endDatetime,
          status: status,
          isFeatured: isFeatured,
          venue: venue,
          category: category,
          categoryDisplay: categoryDisplay,
          tags: tags,
          bannerImage: bannerImage,
          organizerName: organizerName,
          isActive: isActive,
          createdAt: createdAt,
        );

  factory EventDetailModel.fromJson(Map<String, dynamic> json) {
    return EventDetailModel(
      id: json["id"] ?? 0,
      title: json["title"] ?? '',
      description: json["description"] ?? '',
      startDatetime: DateTime.tryParse(json["start_datetime"] ?? '') ?? DateTime.now(),
      endDatetime: DateTime.tryParse(json["end_datetime"] ?? '') ?? DateTime.now(),
      status: json["status"] ?? '',
      isFeatured: json["is_featured"] ?? false,
      venue: Venue.fromJson(json["venue"] ?? {}),
      category: json["category"],
      categoryDisplay: json["category_display"],
      tags: (json["tags"] as List? ?? []).map((t) => Tag.fromJson(t)).toList(),
      bannerImage: json["banner_image"],
      organizerName: json["organizer_name"] ?? '',
      isActive: json["is_active"] ?? false,
      createdAt: DateTime.tryParse(json["created_at"] ?? '') ?? DateTime.now(),
      ticketTypes: (json["ticket_types"] as List? ?? [])
          .map((t) => TicketModel.fromJson(t))
          .toList(),
    );
  }
}

class Venue {
  final int id;
  final String name;
  final String address;
  final String city;
  final String country;
  final int capacity;
  final String? googleMapsUrl;
  final DateTime createdAt;

  Venue({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.country,
    required this.capacity,
    this.googleMapsUrl,
    required this.createdAt,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json["id"] ?? 0,
      name: json["name"] ?? '',
      address: json["address"] ?? '',
      city: json["city"] ?? '',
      country: json["country"] ?? '',
      capacity: json["capacity"] ?? 0,
      googleMapsUrl: json["google_maps_url"],
      createdAt: DateTime.tryParse(json["created_at"] ?? '') ?? DateTime.now(),
    );
  }
}

class Tag {
  final int id;
  final String name;
  final DateTime createdAt;

  Tag({required this.id, required this.name, required this.createdAt});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json["id"] ?? 0,
      name: json["name"] ?? '',
      createdAt: DateTime.tryParse(json["created_at"] ?? '') ?? DateTime.now(),
    );
  }
}

class TicketModel {
  final int id;
  final String name;
  final String description;
  final String price;
  final int quantityAvailable;
  final int quantityRemaining;
  final bool isAvailable;

  TicketModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantityAvailable,
    required this.quantityRemaining,
    required this.isAvailable,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? '',
      description: json["description"] ?? '',
      price: json["price"] ?? '0',
      quantityAvailable: json["quantity_available"] ?? 0,
      quantityRemaining: json["quantity_remaining"] ?? 0,
      isAvailable: json["is_available"] ?? false,
    );
  }
}
