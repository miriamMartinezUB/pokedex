import 'package:flutter_pokedex/common/common_setup.dart';
import 'package:flutter_pokedex/main.dart';
import 'package:flutter_test/flutter_test.dart';

import 'common/common_setup_test.dart';

void main() {
  testWidgets('Test', (WidgetTester tester) async {
    CommonSetup commonSetup = MockCommonSetup();
    await tester.pumpWidget(MyApp(commonSetup));
  });
}
