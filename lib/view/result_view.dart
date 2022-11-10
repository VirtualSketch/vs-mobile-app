import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/custom_close_button.dart';

class ResultView extends StatelessWidget {
  const ResultView(
      {Key? key, required this.imageBytes, required this.equationSteps})
      : super(key: key);

  final Uint8List imageBytes;
  final List<String> equationSteps;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFEDF6F9),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomCloseButton(onClose: () => Modular.to.navigate('/')),
                  const Spacer(),
                  Expanded(
                    child: Text(
                      'Function',
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const Spacer()
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.memory(imageBytes),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: equationSteps
                      .map((item) => Text(item,
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              color: Colors.black,
                            ),
                          )))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
