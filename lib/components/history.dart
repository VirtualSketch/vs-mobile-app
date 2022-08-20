import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'history_card_list.dart';
import 'history_close_button.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF7A44EC),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                HistoryCloseButton(),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                'Your recent \n  activities',
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                    color: Color(0xFFEDF6F9),
                  ),
                ),
              ),
            ),
          ),
          const HistoryCardList(),
        ],
      ),
    );
  }
}
