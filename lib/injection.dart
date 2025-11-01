import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking/data/repositories/user_repository.dart';
import 'package:ticket_booking/data/repositories/post_repository.dart';
import 'package:ticket_booking/core/network/api_client.dart';
import 'package:ticket_booking/core/services/storage_service.dart';


class SimpleDI {
static late ApiClient apiClient;

static late StorageService storageService;
static late UserRepository userRepository;
static late PostRepository postRepository;
}


Future<void> init() async {
final prefs = await SharedPreferences.getInstance();
SimpleDI.storageService = StorageService(prefs);
SimpleDI.apiClient = ApiClient();
  SimpleDI.userRepository = UserRepository(
    SimpleDI.apiClient,
    SimpleDI.storageService,
  );
SimpleDI.postRepository = PostRepository(SimpleDI.apiClient);
}