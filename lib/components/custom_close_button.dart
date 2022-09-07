import 'package:flutter/material.dart';

class CustomCloseButton extends StatelessWidget {
  final void Function() onClose;

  const CustomCloseButton({Key? key, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onClose,
        child: const Icon(
          Icons.close,
          color: Color(0xFF8075FF),
          size: 32,
        ),
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(40, 40),
          shape: const CircleBorder(),
          primary: const Color(0xFFEDF6F9),
        ));
  }
}
