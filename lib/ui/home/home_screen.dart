import 'package:evently_app/ui/home/taps/profile/profile_tap.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileTap(),
    );
  }
}
