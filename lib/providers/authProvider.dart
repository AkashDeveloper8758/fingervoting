import 'package:finger_voting/models/twin.dart';
import 'package:finger_voting/repositories/api_calls_repo.dart';
import 'package:finger_voting/repositories/auth_repo.dart';
import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
// import 'package:local_auth_android/local_auth_android.dart' as android;

class AuthProvider extends ChangeNotifier {
  bool _isLoggingIn = false;
  bool getIsLoggingIn() => _isLoggingIn;
  final AuthRepository _authRepository = AuthRepository();
  final ApiRepository _apiRepository;

  AuthProvider(this._apiRepository);

  // indirect update
  Future<bool> loginWithIdPassword(String voterId, String password) async {
    try {
      _isLoggingIn = true;
      notifyListeners();
      // await Future.delayed(const Duration(seconds: 1));
      var check =
          await _apiRepository.verifyVoterIdAndPassword(voterId, password);
      print('check : $check');
      if (check) {
        var preference = await SharedPreferences.getInstance();
        await preference.setBool(Constants.isLoggedIn, true);
        await preference.setString(Constants.voterId, voterId);
      }
      _isLoggingIn = false;
      notifyListeners();
      return check;
    } catch (err) {
      print('error on login : $err');
      return false;
    }
  }

  // Future<Twin<bool, String>> checkForBiometricsAvlability() async {
  //   return await _authRepository.checkForBiometricsAvlability();
  // }

  Future<Twin<bool, String>> authenticateOnly() async {
    return await _authRepository.authenticateWithBiometric();
  }

  logout() async {
    var preference = await SharedPreferences.getInstance();
    await preference.clear();
    print('logged out');
  }
}
