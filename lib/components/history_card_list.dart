import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryCardList extends StatelessWidget {
  const HistoryCardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _itemBuilder(context),
        _itemBuilder(context),
        _itemBuilder(context),
      ],
    );
  }

  Widget _itemBuilder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
      child: Card(
        color: const Color(0xFFEDF6F9),
        elevation: 20,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: InkWell(
          splashColor: const Color(0xFFBBCDE5),
          onTap: () {},
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  children: [
                    Text(
                      'Second Degree Function',
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: Image.asset('assets/graph.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        // 'f(x) = -2X + 1 \nf(0) = -2x0 + 1 = 1 \nf(1) = -2x1 + 1 = -1 \nf(2) = -2x2 + 1 = -3 \nf(3) = -2x3 + 1 = -5',
                        'f(x) = x ** 2 - 4 * x - 12 \n\nf(x) = x ** 2 - 4 * x - 12 = (-3) ** 2 - 4 * (-3) - 12 = 9 \n\nf(x) = x ** 2 - 4 * x - 12 = (-2) ** 2 - 4 * (-2) - 12 = 0 \n\nf(x) = x ** 2 - 4 * x - 12 = (-1) ** 2 - 4 * (-1) - 12 = -7 \n\nf(x) = x ** 2 - 4 * x - 12 = (0) ** 2 - 4 * (0) - 12 = -12 \n\nf(x) = x ** 2 - 4 * x - 12 = (1) ** 2 - 4 * (1) - 12 = -15 \n\nf(x) = x ** 2 - 4 * x - 12 = (2) ** 2 - 4 * (2) - 12 = -16 \n\nf(x) = x ** 2 - 4 * x - 12 = (3) ** 2 - 4 * (3) - 12 = -15',
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
