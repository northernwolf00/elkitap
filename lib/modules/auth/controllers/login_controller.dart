import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final GetStorage _storage = GetStorage();
  var isAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadAuthState();
  }

  /// Load the saved authentication state from GetStorage
  void _loadAuthState() {
    isAuthenticated.value = _storage.read('isAuthenticated') ?? false;
  }

  /// Log in user and save state
  void login() {
    _storage.write('isAuthenticated', true);
    isAuthenticated.value = true;
  }

  /// Log out user and clear saved state
  void logout() {
    _storage.write('isAuthenticated', false);
    isAuthenticated.value = false;
  }
}
