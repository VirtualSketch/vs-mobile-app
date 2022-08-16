import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF7A44EC),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainPage(),
                ),
              );
            },
            child: const Icon(
              Icons.circle,
              color: Color(0xFFEDF6F9),
            ),
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(125, 125),
              shape: const CircleBorder(),
              primary: const Color(0xFFEDF6F9),
            ),
          ),
        ],
      ),
    );
  }
}
