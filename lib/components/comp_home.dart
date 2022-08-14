import 'package:flutter/material.dart';
import 'circle_button.dart';

class CompHome extends StatelessWidget {
  const CompHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF7A44EC),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircleButton(),
        ],
      ),
    );
  }
}
