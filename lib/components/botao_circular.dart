import 'package:flutter/material.dart';

class BotaoCircular extends StatelessWidget {
  const BotaoCircular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
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
