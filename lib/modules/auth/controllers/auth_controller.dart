import 'package:elkitap/data/network/api_edpoints.dart';
import 'package:elkitap/data/network/network_manager.dart';
import 'package:elkitap/data/network/token_managet.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final NetworkManager _networkManager = Get.find<NetworkManager>();
  final TokenManager _tokenManager = Get.find<TokenManager>();
  
  final RxBool isLoading = false.obs;
  
  // Send verification code
  Future<void> sendCode(String phone) async {
    try {
      isLoading.value = true;
      
      final response = await _networkManager.post(
        ApiEndpoints.sendCode,
        body: {
          'phone': phone,
        },
        sendToken: false, 
      );
      
      if (response['success']) {
        Get.snackbar(
          'Success',
          response['data']['message'] ?? 'Code sent successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Error',
          response['error'] ?? 'Failed to send code',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }
  
  // Login example (with token)
  Future<void> login(String phone, String code) async {
    try {
      isLoading.value = true;
      
      final response = await _networkManager.post(
        ApiEndpoints.login,
        body: {
          'phone': phone,
          'code': code,
        },
        sendToken: false,
      );
      
      if (response['success']) {
        // Save token
        final token = response['data']['token'];
        await _tokenManager.saveToken(token);
        
        Get.snackbar(
          'Success',
          'Logged in successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Error',
          response['error'] ?? 'Login failed',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }
  
 
  Future<void> getProfile() async {
    try {
      isLoading.value = true;
      
      final response = await _networkManager.get(
        ApiEndpoints.getProfile,
        sendToken: true, 
      );
      
      if (response['success']) {
        print('Profile: ${response['data']}');
      } else {
        Get.snackbar(
          'Error',
          response['error'] ?? 'Failed to get profile',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }
}