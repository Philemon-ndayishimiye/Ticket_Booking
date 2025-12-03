import 'package:flutter/material.dart';
import 'router.dart';
import 'theme/app_theme.dart';

class TicketBooking extends StatelessWidget {
  const TicketBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'KTicket',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      debugShowCheckedModeBanner: false,
    );
  }
}
