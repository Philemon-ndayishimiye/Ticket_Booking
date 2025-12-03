import 'package:go_router/go_router.dart'; // optional: you can use Navigator 2.0; if you prefer, add go_router package.
import 'package:ticket_booking/presentation/pages/EditUser/EditUserPage.dart';
import 'package:ticket_booking/presentation/pages/EventPlace/EventPlace.dart';
import 'package:ticket_booking/presentation/pages/Otp/OtpPage.dart';
import 'package:ticket_booking/presentation/pages/accounts/Faq/Faqs.dart';
import 'package:ticket_booking/presentation/pages/accounts/Terms%20and%20condition/Terms.dart';
import 'package:ticket_booking/presentation/pages/accounts/help/Help.dart';
import 'package:ticket_booking/presentation/pages/accounts/private%20and%20privacy/PrivateAndPolicy.dart';
import 'package:ticket_booking/presentation/pages/discover/DIscover_page.dart';
import 'package:ticket_booking/presentation/pages/mytickets/Myticket_page.dart';
import 'package:ticket_booking/presentation/pages/password/PasswordPage.dart';
import 'package:ticket_booking/presentation/pages/profile/ProfilePage.dart';
import 'package:ticket_booking/presentation/pages/resetPassword/ResetPassword_page.dart';
import 'package:ticket_booking/presentation/pages/sucess/SucessPage.dart';
import 'package:ticket_booking/presentation/pages/userProfile/UserProfilePage.dart';
import '../presentation/pages/home/home_page.dart';
import '../presentation/pages/login/login_page.dart';
import '../presentation/pages/signup/Signup_page.dart';


final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),

    GoRoute(path: '/signup', builder: (context, state) => const SignupPage()),

    GoRoute(
      path: '/discover',
      builder: (context, state) => const DiscoverPage(),
    ),

    GoRoute(
      path: '/newpassword',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>?;
        final email = data?['email'] ?? '';
        final otp = data?['otp'] ?? '';
        return NewPasswordPage(email: email, otpCode: otp);
      },
    ),

    GoRoute(path: '/success', builder: (context, state) => const SuccessPage()),

    GoRoute(path: '/reset', builder: (context, state) => const ResetPage()),

    GoRoute(
      path: '/otp',
      builder: (context, state) {
        final email = state.extra as String?;
        return OtpPage(email: email ?? '');
      },
    ),

    GoRoute(
      path: '/ticketpage',
      builder: (context, state) => const TicketPage(),
    ),

    GoRoute(
      path: '/myprofile',
      builder: (context, state) => const CompleteProfilePage(),
    ),

    GoRoute(
      path: '/privacy',
      builder: (context, state) => const PrivacyPolicyPage(),
    ),

    GoRoute(path: '/faq', builder: (context, state) => const FAQPage()),

    GoRoute(
      path: '/help',
      builder: (context, state) => const HelpSupportPage(),
    ),

    GoRoute(
      path: '/eventplace/:id',
      builder: (context, state) {
        final eventId = state.pathParameters['id']!; // use pathParameters
        return EventPlacePage(eventId: eventId);
      },
    ),

    GoRoute(
      path: '/terms',
      builder: (context, state) => const TermsConditionsPage(),
    ),
    GoRoute(
      path: '/editprofile',
      builder: (context, state) => const EditProfilePage(),
    ),

    GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
  ],
);
