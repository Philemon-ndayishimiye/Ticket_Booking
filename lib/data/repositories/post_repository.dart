import 'package:ticket_booking/core/network/api_client.dart';
import 'package:ticket_booking/data/models/post_model.dart';


class PostRepository {
final ApiClient apiClient;
PostRepository(this.apiClient);


Future<List<PostModel>> fetchPosts() async {
final raw = await apiClient.get('/posts');
final List posts = raw['posts'] as List;
return posts.map((p) => PostModel.fromJson(p as Map<String, dynamic>)).toList();
}
}