class ApiConstants {
  static const bool _isProduction = true;
  static const String _devBaseUrl = 'http://localhost:8000/api';
  static const String _prodBaseUrl = 'https://9bpggbzz-8000.usw3.devtunnels.ms/api';

  static String get baseUrl => _isProduction ? _prodBaseUrl : _devBaseUrl;
}
