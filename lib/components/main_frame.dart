import 'package:flutter/material.dart';
import 'vs_frame.dart';

class MainFrame extends StatelessWidget {
  const MainFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          VsFrame(),
        ],
      ),
    );
  }
}
