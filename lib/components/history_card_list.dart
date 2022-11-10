import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_sketch_app/utils/to_uint_8_list.dart';
import 'package:virtual_sketch_app/view_model/main_viewmodel.dart';

class HistoryCardList extends StatelessWidget {
  const HistoryCardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: ((_) {
        final mainViewModel = Modular.get<MainViewModel>();

        if (mainViewModel.resolvedExpressions.isEmpty) {
          return Center(
            child: Text(
              'Sem items',
              style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white)),
            ),
          );
        }

        return ListView(
          children: mainViewModel.resolvedExpressions
              .map((item) => _itemBuilder(context, item!))
              .toList(),
        );
      }),
    );
  }

  Widget _itemBuilder(BuildContext context, Map<String, dynamic> item) {
    Uint8List imageBytes = toUint8List(item['image'].toString());
    List<String> equationSteps = item['equation'];

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
          onTap: () => Modular.to.navigate('/result',
              arguments: {'image': imageBytes, 'equation': equationSteps}),
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
                      'Function',
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
          ),
        ),
      ),
    );
  }
}
