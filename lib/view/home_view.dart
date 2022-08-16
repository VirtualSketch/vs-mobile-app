import 'package:flutter/material.dart';
import '../components/splash_screan.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Expanded(
            child: SplashScrean(),
          ),
        ],
      ),
    );
  }
}
