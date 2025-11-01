import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // optional: you can use Navigator 2.0; if you prefer, add go_router package.
import '../presentation/pages/home/home_page.dart';
import '../presentation/pages/login/login_page.dart';

// NOTE: If you prefer not to add go_router, replace usage with normal Navigator routes.
// For simplicity, the sample below uses GoRouter's concept; if you want me to include go_router dependency & usage, say so.

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
  ],
);
