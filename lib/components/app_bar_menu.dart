import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarMenu extends StatelessWidget implements PreferredSizeWidget {
  double height = 100;

  final String barTitle;

  AppBarMenu({Key? key, required this.height, required this.barTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          height: height,
          child: ClipRRect(
            child: ClipPath(
              clipper: _AppBarClipper(),
              child: Container(
                  padding: const EdgeInsets.only(top: 32),
                  color: const Color(0xFF7A44EC),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        barTitle,
                        style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white)),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color(0xFFEDF6F9),
                        size: 40,
                      ),
                    ],
                  )),
            ),
          ),
        ),
        preferredSize: preferredSize);
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
