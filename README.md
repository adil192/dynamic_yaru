Match your Flutter app to the user's KDE or COSMIC theme
for better Linux integration.

## Features

Creates a theme based on a handful of colors taken from the user's `~/.config/kdeglobals` file.

If we're not on Linux or the file isn't there, `DynamicYaru.getTheme()` will simply return `null`.

For example, here are my Flutter apps
[Saber](https://github.com/saber-notes/saber)
and
[NoMoreBackground](https://github.com/adil192/no_more_background)
responding to the ambient dark green theme:

<img src="https://raw.githubusercontent.com/adil192/dynamic_yaru/main/assets/screenshot.png">

## Getting started

Add `dynamic_yaru` to your app's dependencies:

```bash
flutter pub add dynamic_yaru
```

See the example for more detail, but now essentially all you need to do is:
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DynamicYaru.refresh();
    final ThemeData? theme = DynamicYaru.getTheme();
    return MaterialApp(
      theme: theme,
      home: ...,
    );
  }
}
```

Besides this core functionality, the example also has code for caching the result
and falling back to the regular Yaru theme builder in GNOME.

***

This package is intended to complement the [`yaru`](https://pub.dev/packages/yaru) package
but is not endorsed by or affiliated with Yaru/Ubuntu/Canonical.
