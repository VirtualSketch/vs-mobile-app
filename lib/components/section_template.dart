import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_sketch_app/components/custom_close_button.dart';

class SectionTemplate extends StatelessWidget {
  const SectionTemplate(
      {Key? key,
      this.bgColor = Colors.white,
      required this.child,
      required this.closeButtonWidget,
      required this.title,
      this.subTitle})
      : super(key: key);

  final Color? bgColor;
  final Widget child;
  final CustomCloseButton closeButtonWidget;
  final String title;
  final String? subTitle;

  Widget getSubtitleWidget(String subTitle) {
    return Text(subTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
              child: Container(
                alignment: AlignmentDirectional.centerStart,
                child: closeButtonWidget,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 35,
                  color: Color(0xFFEDF6F9),
                ),
              ),
            ),
            if (subTitle != null)
              Text(
                subTitle!,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                    color: Color(0xFFEDF6F9),
                  ),
                ),
              ),
            const SizedBox(height: 30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
