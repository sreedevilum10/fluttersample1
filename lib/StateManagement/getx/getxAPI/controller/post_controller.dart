import 'package:get/get.dart';
import '../model/post_model.dart';
import '../service/api_service.dart';

class PostController extends GetxController {
  // Observable list
  var postList = <PostModel>[].obs;
  // Loading
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }
  void fetchPosts() async {
    try {
      isLoading(true);
      var posts = await ApiService.fetchPosts();
      postList.assignAll(posts);
    } finally {
      isLoading(false);
    }
  }
}