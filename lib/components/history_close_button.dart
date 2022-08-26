import 'package:flutter/material.dart';

class HistoryCloseButton extends StatelessWidget {
  const HistoryCloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF7A44EC),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
            child: const Icon(
              Icons.close,
              color: Color(0xFF8075FF),
              size: 32,
            ),
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(40, 40),
              shape: const CircleBorder(),
              primary: const Color(0xFFEDF6F9),
            ),
          ),
        ],
      ),
    );
  }
}
