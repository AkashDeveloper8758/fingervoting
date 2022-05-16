import 'package:flutter/material.dart';

class HelperWidget {
  static Future popDialogBox(BuildContext context, String message) async {
    await showDialog(
      context: context,
      builder: (ctx) => Dialog(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 56,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(message,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(' OK ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            )
          ],
        ),
      )),
    );
  }
}
