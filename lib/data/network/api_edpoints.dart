class ApiEndpoints {
  static const String baseUrl = 'YOUR_BASE_URL_HERE'; // Replace with your actual base URL
  
  // Auth endpoints
  static const String sendCode = '/users/send-code';
  static const String verifyCode = '/users/verify-code';
  static const String login = '/users/login';
  static const String register = '/users/register';
  
  // User endpoints
  static const String getProfile = '/users/profile';
  static const String updateProfile = '/users/profile';
  static const String deleteAccount = '/users/account';
  
  // Other endpoints
  static const String getData = '/data';
  static const String updateData = '/data';
  static const String deleteData = '/data';
  
  // Helper method to get full URL
  static String getFullUrl(String endpoint) {
    return '$baseUrl$endpoint';
  }
}