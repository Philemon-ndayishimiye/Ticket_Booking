import 'package:flutter/material.dart';
import 'router.dart';
import 'theme/app_theme.dart';

class TicketBooking extends StatelessWidget {
  const TicketBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // Use router for web-friendly routes
      routerConfig: router, // see app/router.dart
      title: 'My Flutter App',
      theme: AppTheme.light,   // defined in app_theme.dart
      darkTheme: AppTheme.dark,
      // You can add localization delegates, etc. here later
    );
  }
}
