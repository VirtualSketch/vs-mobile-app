import 'package:flutter/material.dart';
import '../components/comp_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Expanded(
            child: CompHome(),
          ),
        ],
      ),
    );
  }
}
