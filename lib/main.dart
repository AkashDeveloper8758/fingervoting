import 'package:finger_voting/core/getit.dart';
import 'package:finger_voting/providers/authProvider.dart';
import 'package:finger_voting/providers/candidateProvider.dart';
import 'package:finger_voting/views/otherScreens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeData = ThemeData(
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.orange[200],
      ),
    );
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: themeData.copyWith(
          colorScheme: themeData.colorScheme
              .copyWith(secondary: Colors.blue, primary: Colors.orange)),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (ctx) => getIt.get<AuthProvider>()),
        ChangeNotifierProvider(create: (ctx) => getIt.get<CandidateProvider>())
      ], child: const Wrapper()),
    );
  }
}
