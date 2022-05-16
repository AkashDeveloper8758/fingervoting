import 'package:finger_voting/constants.dart';
import 'package:finger_voting/views/home.dart';
import 'package:finger_voting/views/login/loginScreen.dart';
import 'package:finger_voting/views/otherScreens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  late Future<bool> _checkLoginState;
  Future<bool> checkLoginState() async {
    var preference = await SharedPreferences.getInstance();
    var loginData = preference.getBool(Constants.isLoggedIn);
    await Future.delayed(const Duration(seconds: 2));
    print('login data : $loginData ');
    return loginData != null && loginData;
  }

  @override
  void initState() {
    super.initState();
    _checkLoginState = checkLoginState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: _checkLoginState,
        builder: (ctx, snp) {
          if (snp.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          print('smap dta : ${snp.data}');
          if (snp.data!) {
            return const HomePage();
          } else {
            return const LoginScreen();
          }
        });
  }
}
