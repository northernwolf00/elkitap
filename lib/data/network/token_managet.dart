
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class TokenManager extends GetxController {
  final GetStorage _storage = GetStorage();
  
  // Keys
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _phoneKey = 'user_phone';
  static const String _usernameKey = 'user_username';
  static const String _imageKey = 'user_image';
  
  // Observable token
  final RxString token = ''.obs;
  final RxBool isAuthenticated = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadToken();
  }
  

  static Future<void> init() async {
    await GetStorage.init();
  }
  
  // Save token and user data
  Future<void> saveToken(String authToken, {Map<String, dynamic>? user}) async {
    await _storage.write(_tokenKey, authToken);
    token.value = authToken;
    isAuthenticated.value = true;
    
    if (user != null) {
      await _storage.write(_userIdKey, user['id']);
      await _storage.write(_phoneKey, user['phone']);
      await _storage.write(_usernameKey, user['username']);
      await _storage.write(_imageKey, user['image']);
    }
  }
  
  // Load token
  void loadToken() {
    final savedToken = _storage.read<String>(_tokenKey);
    if (savedToken != null && savedToken.isNotEmpty) {
      token.value = savedToken;
      isAuthenticated.value = true;
    } else {
      token.value = '';
      isAuthenticated.value = false;
    }
  }
  
  // Get token
  String? getToken() {
    return _storage.read<String>(_tokenKey);
  }
  
  // Get user data
  int? getUserId() {
    return _storage.read<int>(_userIdKey);
  }
  
  String? getPhone() {
    return _storage.read<String>(_phoneKey);
  }
  
  String? getUsername() {
    return _storage.read<String>(_usernameKey);
  }
  
  String? getUserImage() {
    return _storage.read<String>(_imageKey);
  }
  
  // Clear token (logout)
  Future<void> clearToken() async {
    await _storage.remove(_tokenKey);
    await _storage.remove(_userIdKey);
    await _storage.remove(_phoneKey);
    await _storage.remove(_usernameKey);
    await _storage.remove(_imageKey);
    token.value = '';
    isAuthenticated.value = false;
  }
  
  // Check if token exists
  bool hasToken() {
    final savedToken = _storage.read<String>(_tokenKey);
    return savedToken != null && savedToken.isNotEmpty;
  }
}