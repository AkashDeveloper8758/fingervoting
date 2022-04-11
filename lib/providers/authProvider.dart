import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggingIn = false;
  bool getIsLoggingIn() => _isLoggingIn;
  // indirect update
  Future<Map<String, bool>> loginWithIdPassword(
      String voterId, String password) async {
    //todo code to be implemented
    _isLoggingIn = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    _isLoggingIn = false;
    notifyListeners();
    return {'isAuthenticated': true, 'isFingerprintAded': false};
  }

  // direct
  Future<bool> isFigerPrintAvailable(String voterId) async {
    //todo code to be implemented
    return true;
  }
}
