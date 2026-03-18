import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ini/ini.dart';
import 'package:logging/logging.dart';
import 'package:yaru/yaru.dart';

abstract class DynamicYaru {
  static final log = Logger('DynamicYaru');

  static Config? _kdeGlobals;

  @pragma('vm:platform-const-if', kReleaseMode)
  static bool enabled = defaultTargetPlatform == .linux && !_isThisATest;

  @visibleForTesting
  static void overrideWith(String kdeGlobals) {
    _kdeGlobals = Config.fromString(kdeGlobals);
    enabled = true;
  }

  /// Returns a new theme with colors taken from the `~/.config/kdeglobals` file.
  ///
  /// If the file is not found or the colors are not defined, the input theme is returned.
  static ThemeData? getTheme() {
    if (!enabled) return null;

    final kdeGlobals = DynamicYaru._kdeGlobals;
    if (kdeGlobals == null) return null;

    final bg =
        kdeGlobals.getColor('Colors:Window', 'BackgroundNormal') ??
        kdeGlobals.getColor('Colors:View', 'BackgroundNormal');
    final fg =
        kdeGlobals.getColor('Colors:View', 'ForegroundNormal') ??
        kdeGlobals.getColor('Colors:Window', 'ForegroundNormal');
    final seedColor =
        kdeGlobals.getColor('Colors:View', 'DecorationHover') ??
        kdeGlobals.getColor('Colors:Window', 'DecorationHover');
    if (bg == null || fg == null || seedColor == null) return null;
    final button = kdeGlobals.getColor('Colors:Button', 'BackgroundNormal');
    final onButton = kdeGlobals.getColor('Colors:Button', 'ForegroundNormal');
    final borderColor = Color.lerp(bg, fg, 0.2);

    final Brightness brightness = bg.computeLuminance() < 0.5 ? .dark : .light;
    var theme = switch (brightness) {
      .dark => createYaruDarkTheme(
        primaryColor: seedColor,
        lightBaseColor: fg,
        darkBaseColor: bg,
        elevatedButtonColor: button,
        elevatedButtonTextColor: onButton,
      ),
      .light => createYaruLightTheme(
        primaryColor: seedColor,
        lightBaseColor: bg,
        darkBaseColor: fg,
        elevatedButtonColor: button,
        elevatedButtonTextColor: onButton,
      ),
    };

    theme = theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        onSurface: fg,
        inverseSurface: kdeGlobals.getColor(
          'Colors:Complementary',
          'BackgroundNormal',
        ),
        onInverseSurface: kdeGlobals.getColor(
          'Colors:Complementary',
          'ForegroundNormal',
        ),
        outline: borderColor,
      ),
      dividerColor: borderColor,
      dividerTheme: theme.dividerTheme.copyWith(color: borderColor),
    );

    return theme;
  }

  /// Call this to re-read the `~/.config/kdeglobals` file.
  /// We expect the file to change when the user changes their theme.
  static void refresh() {
    if (!enabled) return;
    if (_isThisATest) return;
    print('Refreshing ${kdeGlobalsFile.path}');
    if (!kdeGlobalsFile.existsSync()) {
      _kdeGlobals = null;
    } else {
      final lines = kdeGlobalsFile.readAsLinesSync();
      _kdeGlobals = Config.fromStrings(lines);
    }
  }

  @visibleForTesting
  static final kdeGlobalsFile = () {
    late final home = Platform.environment['HOME'] ?? '~';
    final xdgConfigDir =
        Platform.environment['XDG_CONFIG_HOME'] ?? '$home/.config';
    return File('$xdgConfigDir/kdeglobals');
  }();
}

extension on Config {
  Color? getColor(String section, String key) {
    final rgb = get(section, key);
    final split = rgb?.split(',');
    if (split == null || split.length != 3) return null;
    final r = int.parse(split[0]);
    final g = int.parse(split[1]);
    final b = int.parse(split[2]);
    return Color.fromARGB(255, r, g, b);
  }
}

/// Returns true if we're currently running in a test, not in a real app.
@pragma('vm:platform-const-if', !kDebugMode)
final _isThisATest =
    kDebugMode && Platform.environment.containsKey('FLUTTER_TEST');
