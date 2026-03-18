import 'package:dynamic_yaru/dynamic_yaru.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('colors are taken directly from kdeglobals', () {
    test('dark green', () {
      DynamicYaru.overrideWith('''
[Colors:Window]
BackgroundNormal=11,17,6
ForegroundNormal=214,216,211
DecorationHover=142,196,88

[Colors:Button]
BackgroundNormal=48,52,44
ForegroundNormal=214,216,211
''');
      final theme = DynamicYaru.getTheme();
      expect(theme, isNotNull);

      expect(
        [
          theme!.brightness,
          theme.colorScheme.brightness,
          theme.colorScheme.surface,
          theme.colorScheme.onSurface,
          theme.colorScheme.primary,
          theme.elevatedButtonTheme.style!.backgroundColor!.resolve({}),
          theme.elevatedButtonTheme.style!.foregroundColor!.resolve({}),
        ],
        [
          Brightness.dark,
          Brightness.dark,
          Color.fromARGB(255, 11, 17, 6),
          Color.fromARGB(255, 214, 216, 211),
          Color.fromARGB(255, 142, 196, 88),
          Color.fromARGB(255, 48, 52, 44),
          Color.fromARGB(255, 214, 216, 211),
        ],
      );
    });

    test('light pink', () {
      DynamicYaru.overrideWith('''
[Colors:Window]
BackgroundNormal=249,162,233
ForegroundNormal=13,2,14
DecorationHover=104,33,124

[Colors:Button]
BackgroundNormal=207,121,194
ForegroundNormal=13,2,14
''');
      final theme = DynamicYaru.getTheme();
      expect(theme, isNotNull);

      expect(
        [
          theme!.brightness,
          theme.colorScheme.brightness,
          theme.colorScheme.surface,
          theme.colorScheme.onSurface,
          theme.colorScheme.primary,
          theme.elevatedButtonTheme.style!.backgroundColor!.resolve({}),
          theme.elevatedButtonTheme.style!.foregroundColor!.resolve({}),
        ],
        [
          Brightness.light,
          Brightness.light,
          Color.fromARGB(255, 249, 162, 233),
          Color.fromARGB(255, 13, 2, 14),
          Color.fromARGB(255, 104, 33, 124),
          Color.fromARGB(255, 207, 121, 194),
          Color.fromARGB(255, 13, 2, 14),
        ],
      );
    });
  });
}
