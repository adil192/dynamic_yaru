import 'package:dynamic_yaru/dynamic_yaru.dart';
import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static Brightness? _lastBrightness;
  static ThemeData? _kdeTheme;

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);
    if (brightness != _lastBrightness) {
      // Refresh KDE theme if light/dark mode changed
      DynamicYaru.refresh();
      _lastBrightness = brightness;
      _kdeTheme = DynamicYaru.getTheme();
    }

    // If we found a KDE theme, use it.
    if (_kdeTheme != null) return _ThemedApp(theme: _kdeTheme!);

    // Otherwise, fallback to Yaru's own theme builder which is more limited
    // and only responds to a single accent color.
    return YaruTheme(
      builder: (context, yaru, _) {
        final theme = brightness == .dark ? yaru.darkTheme : yaru.theme;
        return _ThemedApp(theme: theme);
      },
    );
  }
}

class _ThemedApp extends StatelessWidget {
  const _ThemedApp({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const Scaffold(body: Text('Your app goes here')),
    );
  }
}
