import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'history_card_list.dart';
import 'history_close_button.dart';

class History extends StatelessWidget {
  final PageController pageViewController;

  const History({Key? key, required this.pageViewController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFF7A44EC),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    HistoryCloseButton(onClose: _handleCloseButton),
                  ],
                ),
              ),
              Center(
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: [
                        Text(
                          'Your recent',
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 40,
                              color: Color(0xFFEDF6F9),
                            ),
                          ),
                        ),
                        Text(
                          'activities',
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 40,
                              color: Color(0xFFEDF6F9),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              const HistoryCardList(),
            ],
          ),
        ));
  }

  void _handleCloseButton() {
    pageViewController.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
