import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_sketch_app/components/custom_close_button.dart';

class SectionTemplate extends StatelessWidget {
  const SectionTemplate(
      {Key? key,
      this.bgColor = Colors.white,
      required this.child,
      required this.closeButtonWidget})
      : super(key: key);

  final Color? bgColor;
  final Widget child;
  final CustomCloseButton closeButtonWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              alignment: AlignmentDirectional.centerStart,
              child: closeButtonWidget,
            ),
            Text(
              'Choose a subject',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 35,
                  color: Color(0xFFEDF6F9),
                ),
              ),
            ),
            Text(
              'to start to learn',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  color: Color(0xFFEDF6F9),
                ),
              ),
            ),
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
