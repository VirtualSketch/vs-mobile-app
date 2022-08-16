import 'package:flutter/material.dart';
import '../components/main_frame.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Expanded(
            child: MainFrame(),
          ),
        ],
      ),
    );
  }
}
