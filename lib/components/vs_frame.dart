import 'package:flutter/material.dart';

class VsFrame extends StatelessWidget {
  const VsFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF7A44EC),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Access the History',
                  style: TextStyle(
                    fontSize: 40,
                    color: Color(0xFFEDF6F9),
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
                  children: const [
                    Text(
                      'Virtual Sketch',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8075FF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: const Color(0xFFEDF6F9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Icon(
                      Icons.keyboard_double_arrow_up_rounded,
                      color: Color(0xFFBBCDE5),
                      size: 60,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 100),
                    child: Center(
                      child: Text(
                        '\r \r \r  SWIPE UP \n to open the menu',
                        style: TextStyle(
                          fontSize: 25,
                          color: Color(0xFFBBCDE5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
