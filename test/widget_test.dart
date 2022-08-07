import 'package:flutter_test/flutter_test.dart';

import 'package:virtual_sketch_app/view/home_view.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const HomePage());
  });
}
