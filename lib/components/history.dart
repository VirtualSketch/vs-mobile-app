import 'package:flutter/material.dart';
import 'package:virtual_sketch_app/components/custom_close_button.dart';
import 'package:virtual_sketch_app/components/section_template.dart';
import 'history_card_list.dart';

class History extends StatelessWidget {
  final PageController pageViewController;

  const History({Key? key, required this.pageViewController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionTemplate(
      title: 'You recent activies',
      bgColor: const Color(0xFF7A44EC),
      closeButtonWidget: CustomCloseButton(onClose: _handleCloseButton),
      child: const HistoryCardList(),
    );
  }

  void _handleCloseButton() {
    pageViewController.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
