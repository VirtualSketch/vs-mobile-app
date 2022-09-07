import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_sketch_app/components/custom_close_button.dart';
import 'package:virtual_sketch_app/components/section_template.dart';
import 'package:virtual_sketch_app/components/subject_item.dart';

typedef Subject = List<Map<String, dynamic>>;

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({Key? key, required this.pageViewController})
      : super(key: key);

  final PageController pageViewController;

  static const Subject subjects = [
    {
      'name': 'Math',
      'icon': FontAwesomeIcons.squareRootVariable,
      'isDisabled': false
    },
    {
      'name': 'Coming Soon',
      'icon': FontAwesomeIcons.screwdriverWrench,
      'isDisabled': true
    },
    {
      'name': 'Coming Soon',
      'icon': FontAwesomeIcons.screwdriverWrench,
      'isDisabled': true
    },
    {
      'name': 'Coming Soon',
      'icon': FontAwesomeIcons.screwdriverWrench,
      'isDisabled': true
    },
    {
      'name': 'Coming Soon',
      'icon': FontAwesomeIcons.screwdriverWrench,
      'isDisabled': true
    },
    {
      'name': 'Coming Soon',
      'icon': FontAwesomeIcons.screwdriverWrench,
      'isDisabled': true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SectionTemplate(
      title: 'Choose a subject',
      subTitle: 'to start to learn',
      bgColor: const Color(0xFF7A44EC),
      closeButtonWidget: CustomCloseButton(onClose: _handleCloseButton),
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 25,
        mainAxisSpacing: 32,
        children: subjects
            .map((subject) => SubjectItem(
                name: subject['name'],
                icon: subject['icon'],
                isDisabled: subject['isDisabled']))
            .toList(),
      ),
    );
  }

  void _handleCloseButton() {
    pageViewController.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
