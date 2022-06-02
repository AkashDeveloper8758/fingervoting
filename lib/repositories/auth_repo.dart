import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart' as auth;
import 'package:finger_voting/models/twin.dart';
import 'package:flutter/services.dart';

class AuthRepository {
  final _localAuth = auth.LocalAuthentication();

  Future<Twin<bool, String>> authenticateWithBiometric() async {
    // -------------- test
    // return Twin(true, '');
    try {
      var didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Please authentication for secure voting',
        options: const auth.AuthenticationOptions(biometricOnly: true),
      );
      return Twin(didAuthenticate, 'passed');
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('error : ${e.message}');
      }
      return Twin(false, e.message ?? '');
    }
  }

  // Future<Twin<bool, String>> checkForBiometricsAvlability() async {
  // -------------- test
  // return Twin(true, '');
  //   var cancheck = await _localAuth.canCheckBiometrics;
  //   if (cancheck) {
  //     var availableBio = await _localAuth.getAvailableBiometrics();
  //     if (availableBio.isNotEmpty) {
  //       if (availableBio.contains(auth.BiometricType.strong)) {
  //         // return await authenticateWithBiometric();
  //         return Twin(true, 'no biometric added to this device');
  //       }
  //     } else {
  //       return Twin(false, 'no biometric added to this device');
  //     }
  //   }
  //   return Twin(false, 'Biometrics are not available on this device');
  // }
}
