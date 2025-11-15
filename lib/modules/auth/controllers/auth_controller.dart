import 'package:elkitap/data/network/api_edpoints.dart';
import 'package:elkitap/data/network/network_manager.dart';
import 'package:elkitap/data/network/token_managet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final NetworkManager _networkManager = Get.find<NetworkManager>();
  final TokenManager _tokenManager = Get.find<TokenManager>();
  
  final RxBool isLoading = false.obs;
  final RxString currentPhone = ''.obs;
  
  // Send verification code
  Future<bool> sendCode(String phone) async {
    try {
      isLoading.value = true;
      
      // Format phone number with country code
      final formattedPhone = phone.startsWith('+993') ? phone : '+993$phone';
      currentPhone.value = formattedPhone;
      
      final response = await _networkManager.post(
        ApiEndpoints.sendCode,
        body: {
          'phone': formattedPhone,
        },
        sendToken: false, // No token needed for send code
      );
      
      if (response['success']) {
        Get.snackbar(
          'Success',
          response['message'] ?? 'Code sent successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
        );
        return true;
      } else {
        Get.snackbar(
          'Error',
          response['error'] ?? 'Failed to send code',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
  
  // Verify code and login
  Future<bool> verifyCodeAndLogin(String code) async {
    try {
      isLoading.value = true;
      
      final response = await _networkManager.post(
        ApiEndpoints.verifyCode, // Use the same endpoint or change to verifyCode endpoint
        body: {
          'phone': currentPhone.value,
          'code': int.parse(code),
        },
        sendToken: false,
      );
      
      if (response['success']) {
        // Extract token and user data from response
        final data = response['data'];
        final accessToken = data['accessToken'];
        final user = data['user'];
        
        // Save token and user data
        await _tokenManager.saveToken(accessToken, user: user);
        
        Get.snackbar(
          'Success',
          'Logged in successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
        );
        return true;
      } else {
        Get.snackbar(
          'Error',
          response['error'] ?? 'Invalid code',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
  
  // Logout
  Future<void> logout() async {
    await _tokenManager.clearToken();
    Get.offAllNamed('/auth'); // Navigate to auth screen
  }
  
  // Get profile (example with token)
  Future<Map<String, dynamic>?> getProfile() async {
    try {
      isLoading.value = true;
      
      final response = await _networkManager.get(
        ApiEndpoints.getProfile,
        sendToken: true, // Send token for authenticated request
      );
      
      if (response['success']) {
        return response['data'];
      } else {
        Get.snackbar(
          'Error',
          response['error'] ?? 'Failed to get profile',
          snackPosition: SnackPosition.BOTTOM,
        );
        return null;
      }
    } finally {
      isLoading.value = false;
    }
  }
  
  // Update profile (example)
  Future<bool> updateProfile(Map<String, dynamic> userData) async {
    try {
      isLoading.value = true;
      
      final response = await _networkManager.put(
        ApiEndpoints.updateProfile,
        body: userData,
        sendToken: true, // Send token for authenticated request
      );
      
      if (response['success']) {
        Get.snackbar(
          'Success',
          'Profile updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
        );
        return true;
      } else {
        Get.snackbar(
          'Error',
          response['error'] ?? 'Failed to update profile',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
        return false;
      }
    } finally {
      isLoading.value = false;
    }
  }
  
  // Delete account (example)
  Future<bool> deleteAccount() async {
    try {
      isLoading.value = true;
      
      final response = await _networkManager.delete(
        ApiEndpoints.deleteAccount,
        sendToken: true, // Send token for authenticated request
      );
      
      if (response['success']) {
        await logout();
        return true;
      } else {
        Get.snackbar(
          'Error',
          response['error'] ?? 'Failed to delete account',
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
