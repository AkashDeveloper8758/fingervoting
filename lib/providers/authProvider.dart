import 'package:finger_voting/models/twin.dart';
import 'package:finger_voting/repositories/auth_repo.dart';
import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
// import 'package:local_auth_android/local_auth_android.dart' as android;

class AuthProvider extends ChangeNotifier {
  bool _isLoggingIn = false;
  bool getIsLoggingIn() => _isLoggingIn;
  final AuthRepository _authRepository = AuthRepository();
  // indirect update
  Future<bool> loginWithIdPassword(String voterId, String password) async {
    //todo code to be implemented
    _isLoggingIn = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    _isLoggingIn = false;
    notifyListeners();
    // todo if true : update isloggedin -> uncomment them.
    var preference = await SharedPreferences.getInstance();
    await preference.setBool(Constants.isLoggedIn, true);
    return true;
  }

  Future<Twin<bool, String>> checkForBiometricsAvlability() async {
    return await _authRepository.checkForBiometricsAvlability();
  }

  Future<Twin<bool, String>> authenticateOnly() async {
    return await _authRepository.authenticateWithBiometric();
  }

  logout() async {
    var preference = await SharedPreferences.getInstance();
    await preference.setBool(Constants.isLoggedIn, false);
  }
}
