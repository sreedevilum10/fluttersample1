import 'package:get/get.dart';
import '../model/user_model.dart';
import '../service/user_service.dart';
class UserController extends GetxController {
  // ── State ──────────────────────────────────────────────────────────────────
  var users     = <User>[].obs;   // list of users from API
  var isLoading = false.obs;      // show spinner while fetching
  var errorMsg  = ''.obs;         // show error message if fetch fails

  // ── Service (injected) ─────────────────────────────────────────────────────
  final _service = UserService();
  // ── Called automatically when controller is created ────────────────────────
  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }
  // ── Fetch users from API ───────────────────────────────────────────────────
  Future<void> fetchUsers() async {
    isLoading.value = true;
    errorMsg.value  = '';

    try {
      final result = await _service.getUsers();
      users.assignAll(result);
    } catch (e) {
      errorMsg.value = 'Something went wrong. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }
}
