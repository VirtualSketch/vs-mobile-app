import 'package:flutter/material.dart';
import 'package:virtual_sketch_app/components/custom_close_button.dart';
import 'package:virtual_sketch_app/components/section_template.dart';
import 'package:virtual_sketch_app/components/subject_item.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionTemplate(
      bgColor: const Color(0xFF7A44EC),
      closeButtonWidget: CustomCloseButton(onClose: () => {}),
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 25,
        mainAxisSpacing: 32,
        // childAspectRatio: 3 / 2,
        padding: const EdgeInsetsDirectional.all(15),
        children: const [
          SubjectItem(name: 'Math'),
          SubjectItem(name: 'Coming Soon'),
          SubjectItem(name: 'Coming Soon'),
          SubjectItem(name: 'Coming Soon'),
          SubjectItem(name: 'Coming Soon'),
          SubjectItem(name: 'Coming Soon'),
          SubjectItem(name: 'Coming Soon'),
          SubjectItem(name: 'Coming Soon'),
          SubjectItem(name: 'Coming Soon'),
          SubjectItem(name: 'Coming Soon'),
          SubjectItem(name: 'Coming Soon'),
          SubjectItem(name: 'Coming Soon'),
          SubjectItem(name: 'Coming Soon'),
          SubjectItem(name: 'Coming Soon'),
          SubjectItem(name: 'Coming Soon'),
          SubjectItem(name: 'Coming Soon'),
        ],
      ),
    );
  }
}
