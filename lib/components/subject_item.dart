import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectItem extends StatelessWidget {
  const SubjectItem(
      {Key? key,
      required this.name,
      required this.icon,
      this.isDisabled = false})
      : super(key: key);

  final String name;
  final IconData icon;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 1), blurRadius: 2.0)
          ],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(12.0),
          color: const Color(0xffEDF6F9),
          child: isDisabled
              ? Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(icon, color: const Color(0xFF8075FF)),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        name,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xFF8075FF)),
                        ),
                      ),
                    ],
                  ),
                )
              : InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(icon, color: const Color(0xFF8075FF)),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          name,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFF8075FF)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }
}
