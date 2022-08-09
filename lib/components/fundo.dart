import 'package:flutter/material.dart';
import 'botao_circular.dart';

class Fundo extends StatelessWidget {
  const Fundo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF7A44EC),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          BotaoCircular(),
        ],
      ),
    );
  }
}
