
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TokenManager extends GetxController {
  final GetStorage _storage = GetStorage();
  
  // Keys
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userIdKey = 'user_id';
  
  // Observable token
  final RxString token = ''.obs;
  final RxBool isAuthenticated = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadToken();
  }
  
  // Initialize GetStorage (call this in main.dart before runApp)
  static Future<void> init() async {
    await GetStorage.init();
  }
  
  // Save token
  Future<void> saveToken(String authToken, {String? refreshToken, String? userId}) async {
    await _storage.write(_tokenKey, authToken);
    token.value = authToken;
    isAuthenticated.value = true;
    
    if (refreshToken != null) {
      await _storage.write(_refreshTokenKey, refreshToken);
    }
    
    if (userId != null) {
      await _storage.write(_userIdKey, userId);
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
  
  // Get refresh token
  String? getRefreshToken() {
    return _storage.read<String>(_refreshTokenKey);
  }
  
  // Get user ID
  String? getUserId() {
    return _storage.read<String>(_userIdKey);
  }
  
  // Clear token (logout)
  Future<void> clearToken() async {
    await _storage.remove(_tokenKey);
    await _storage.remove(_refreshTokenKey);
    await _storage.remove(_userIdKey);
    token.value = '';
    isAuthenticated.value = false;
  }
  
  // Check if token exists
  bool hasToken() {
    final savedToken = _storage.read<String>(_tokenKey);
    return savedToken != null && savedToken.isNotEmpty;
  }
}
