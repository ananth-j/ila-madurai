import 'package:flutter/material.dart';

class SmsScreen extends StatefulWidget {
  const SmsScreen({super.key});

  @override
  State<SmsScreen> createState() => _SmsScreenState();
}

class _SmsScreenState extends State<SmsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
           //   height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text(
                'Unfortunately, it is not currently possible to directly send SMS messages from a Flutter app without interacting with the default SMS app on the users device. This is due to security and privacy restrictions imposed by Android ( Android Inc ) and iOS ( Apple Inc).',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
