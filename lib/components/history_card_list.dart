import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryCardList extends StatelessWidget {
  const HistoryCardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          _itemBuilder(context),
          _itemBuilder(context),
          _itemBuilder(context),
        ],
      ),
    );
  }

  Widget _itemBuilder(BuildContext context) {
    return Center(
      child: Padding(
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
              height: 400,
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        '1fst Degree Function',
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Image(
                          image: NetworkImage(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'f(x) = -2X + 1 \nf(0) = -2x0 + 1 = 1 \nf(1) = -2x1 + 1 = -1 \nf(2) = -2x2 + 1 = -3 \nf(3) = -2x3 + 1 = -5',
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
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
