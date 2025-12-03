import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:ticket_booking/presentation/pages/home/Event_view_model.dart';

// Import DI
import 'package:ticket_booking/injection.dart' as di;

// ViewModels
//import 'package:ticket_booking/presentation/pages/home/home_view_model.dart';
import 'package:ticket_booking/presentation/pages/login/login-view_model.dart';
import 'package:ticket_booking/presentation/pages/signup/Signup_view_model.dart';

class AppProviders {
  static List<SingleChildWidget> get all {
    return [
      // HomeViewModel provider
     

      // LoginViewModel provider
      ChangeNotifierProvider<LoginViewModel>(
        create: (_) => LoginViewModel(
          userRepository: di.SimpleDI.userRepository, // ✅ use SimpleDI
          storageService: di.SimpleDI.storageService, // ✅ use SimpleDI
        ),
        lazy: false,
      ),

      // events
      ChangeNotifierProvider<EventViewModel>(
        create: (_) =>
            EventViewModel(eventRepository: di.SimpleDI.eventRepository)
              ..loadEvents(),
      ),

      ChangeNotifierProvider<SignupViewModel>(
        create: (_) => SignupViewModel(
          userRepository: di.SimpleDI.userRepository, // ✅ use SimpleDI
        ),
        lazy: false,
      ),
    ];
  }
}
