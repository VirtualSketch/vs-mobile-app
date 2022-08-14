import 'package:flutter/material.dart';

import 'comp_main.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CompMain(),
              ),
            );
          },
          child: const Icon(
            Icons.circle,
            color: Colors.white,
          ),
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(125, 125),
            shape: const CircleBorder(),
            primary: Colors.white,
          ),
        ),
      ],
    );
  }
}
