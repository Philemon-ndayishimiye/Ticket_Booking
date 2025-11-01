import 'package:flutter/material.dart';
// import '../../../data/repositories/user_repository.dart';
import 'package:ticket_booking/data/models/post_model.dart';
import 'package:ticket_booking/data/repositories/post_repository.dart';
import 'package:ticket_booking/core/utils/logger.dart';

// ViewModel as ChangeNotifier: manages state for HomePage
class HomeViewModel extends ChangeNotifier {
  final PostRepository postRepository;

  HomeViewModel({required this.postRepository});

  bool isLoading = false;
  String? error;
  List<PostModel> posts = [];

  Future<void> loadPosts() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      posts = await postRepository.fetchPosts();
    } catch (e) {
      error = e.toString();
      appLogger.e('loadPosts error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}