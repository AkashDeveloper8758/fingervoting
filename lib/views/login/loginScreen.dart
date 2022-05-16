import 'package:finger_voting/core/getit.dart';
import 'package:finger_voting/providers/authProvider.dart';
import 'package:finger_voting/views/home.dart';
import 'package:finger_voting/views/widgets/messageDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _voterId;
  late TextEditingController _password;
  late AuthProvider _authProvider;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _voterId = TextEditingController();
    _password = TextEditingController();
    _authProvider = getIt.get<AuthProvider>();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _commonStyle =
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login to finger voting'),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _voterId,
                        style: _commonStyle,
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'enter voter id'
                            : null,
                        decoration: InputDecoration(
                            hintText: 'Voter Id',
                            hintStyle:
                                _commonStyle.copyWith(color: Colors.black87)),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _password,
                        style: _commonStyle,
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'enter password'
                            : null,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle:
                                _commonStyle.copyWith(color: Colors.black87)),
                      ),
                    ],
                  )),
              const SizedBox(height: 16),
              ChangeNotifierProvider.value(
                value: getIt.get<AuthProvider>(),
                builder: (ctx, _) {
                  var isloggingin = ctx.watch<AuthProvider>().getIsLoggingIn();
                  return isloggingin
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: Center(child: CircularProgressIndicator()))
                      : ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              var biometricCheck = await _authProvider
                                  .checkForBiometricsAvlability();
                              if (!biometricCheck.left) {
                                await HelperWidget.popDialogBox(
                                    context, biometricCheck.right);
                                return;
                              }
                              var isVerified =
                                  await _authProvider.loginWithIdPassword(
                                      _voterId.text, _password.text);
                              if (isVerified) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (ctx) => const HomePage()),
                                    (route) => false);
                              }
                            }
                          },
                          child: const Text('Login to finger voting'));
                },
              ),
            ],
          ),
        ));
  }
}
