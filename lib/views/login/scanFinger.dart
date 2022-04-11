import 'package:finger_voting/views/home.dart';
import 'package:flutter/material.dart';

class FingerprintScreen extends StatefulWidget {
  const FingerprintScreen({Key? key}) : super(key: key);

  @override
  State<FingerprintScreen> createState() => _FingerprintScreenState();
}

class _FingerprintScreenState extends State<FingerprintScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('scan fingerprint'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx) => const HomePage()),
              (route) => false);
        },
        child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.fingerprint,
                  size: 56,
                ),
                SizedBox(height: 16),
                Text('Scan your fingerprint',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ],
            )),
      ),
    );
  }
}
