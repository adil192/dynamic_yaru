import 'package:dynamic_yaru/dynamic_yaru.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('does not crash in tests without refresh', () {
    // Users of this package should not have to do/call anything
    // to fix this package crashing in tests.
    final theme = DynamicYaru.getTheme();
    expect(theme, isNull);
  });

  test('does not crash in tests with refresh', () {
    // UI classes might call refresh() so we need to make sure
    // that calling it does not cause a crash.
    DynamicYaru.refresh();
    final theme = DynamicYaru.getTheme();
    expect(theme, isNull);
  });
}
