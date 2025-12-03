import 'package:flutter/material.dart';
import 'dart:io';
import 'package:ticket_booking/injection.dart' as di;
import 'package:ticket_booking/app/app.dart';
import 'package:provider/provider.dart';
import 'package:ticket_booking/presentation/state/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final result = await InternetAddress.lookup('dummyjson.com');
    print('Host lookup result: $result');
  } catch (e) {
    print('Host lookup failed: $e');
  }

  await di.init();

  runApp(
    MultiProvider(
      providers: AppProviders.all,
      child: const TicketBooking(),
    ),
  );
}
