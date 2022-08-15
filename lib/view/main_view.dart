import 'package:flutter/material.dart';
import '../components/comp_main.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Expanded(
            child: CompMain(),
          ),
        ],
      ),
    );
  }
}
