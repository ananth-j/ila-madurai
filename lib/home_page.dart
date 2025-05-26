import 'package:flutter/material.dart';
import 'package:ila/pages/sub_home.dart';
import 'package:ila/widgets/custom_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppbar(),
            SubHome(),
          ],
        ),
      ),
    );
  }
}
