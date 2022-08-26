import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = PageController(
      initialPage: 2,
    );
    return Scaffold(
      body: PageView(
        controller: controller,
        scrollDirection: Axis.vertical,
        children: [
          Container(
            child: const History(),
          ),
          Container(
            color: const Color(0xFF7A44EC),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'Access the History',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color(0xFFEDF6F9),
                        size: 40,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xFFEDF6F9),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 200),
                          child: Text(
                            'Virtual Sketch',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8075FF),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 100),
                              child: Icon(
                                Icons.keyboard_double_arrow_up_rounded,
                                color: Color(0xFFBBCDE5),
                                size: 60,
                              ),
                            ),
                            Center(
                              child: Text(
                                'SWIPE UP',
                                style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25,
                                    color: Color(0xFFBBCDE5),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'to open the menu',
                                style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25,
                                    color: Color(0xFFBBCDE5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
