import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:ticket_booking/injection.dart';
import 'package:ticket_booking/app/app.dart';
import 'package:ticket_booking/presentation/pages/home/home_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    try {
    final result = await InternetAddress.lookup('dummyjson.com');
    print('Host lookup result: $result');
  } catch (e) {
    print('Host lookup failed: $e');
  }
  await init(); // initialize SimpleDI

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(postRepository: SimpleDI.postRepository),
        ),
      ],
      child: const TicketBooking(),
    ),
  );
}
