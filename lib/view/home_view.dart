import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_sketch_app/components/app_bar_menu.dart';
import 'package:virtual_sketch_app/components/history.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = PageController(initialPage: 2);

    return PageView(
      controller: controller,
      scrollDirection: Axis.vertical,
      onPageChanged: (value) => print(value),
      children: [
        History(pageViewController: controller),
        Scaffold(
          appBar: AppBarMenu(height: 120, barTitle: 'Access the history'),
          backgroundColor: const Color(0xFFEDF6F9),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Virtual Sketch',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8075FF),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.keyboard_double_arrow_up_rounded,
                      color: Color(0xFFBBCDE5),
                      size: 60,
                    ),
                    Text(
                      'SWIPE UP',
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          color: Color(0xFFBBCDE5),
                        ),
                      ),
                    ),
                    Text(
                      'to open the menu',
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Color(0xFFBBCDE5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
