import 'package:dynamic_yaru/dynamic_yaru.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_screenshot/golden_screenshot.dart';
import 'package:yaru/yaru.dart';

void main() {
  testGoldens('golden', (tester) async {
    DynamicYaru.overrideWith(_darkGreenKdeGlobals);
    final theme = DynamicYaru.getTheme()!;
    final thumbIcon = WidgetStateProperty.all(Icon(YaruIcons.kde_logo));
    await tester.pumpWidget(
      ScreenshotApp.withConditionalTitlebar(
        device: GoldenScreenshotDevices.flathub.device,
        theme: theme,
        title: 'Demo app',
        home: Scaffold(
          appBar: AppBar(title: Text('Demo app')),
          body: Column(
            mainAxisAlignment: .center,
            spacing: 8,
            children: [
              Text('hello world!'),
              Divider(),
              Row(
                mainAxisAlignment: .center,
                spacing: 8,
                children: [
                  Switch(value: true, onChanged: (_) {}, thumbIcon: thumbIcon),
                  Switch(value: false, onChanged: (_) {}, thumbIcon: thumbIcon),
                ],
              ),
              Row(
                mainAxisAlignment: .center,
                spacing: 8,
                children: [
                  Switch(value: true, onChanged: null, thumbIcon: thumbIcon),
                  Switch(value: false, onChanged: null, thumbIcon: thumbIcon),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: .center,
                spacing: 8,
                children: [
                  ElevatedButton(onPressed: () {}, child: Text('Hello')),
                  OutlinedButton(onPressed: () {}, child: Text('Hello')),
                  TextButton(onPressed: () {}, child: Text('Hello')),
                ],
              ),
              Row(
                mainAxisAlignment: .center,
                spacing: 8,
                children: [
                  ElevatedButton(onPressed: null, child: Text('Hello')),
                  OutlinedButton(onPressed: null, child: Text('Hello')),
                  TextButton(onPressed: null, child: Text('Hello')),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: .center,
                spacing: 8,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.inverseSurface,
                      border: Border.all(color: theme.dividerColor),
                    ),
                    width: 128,
                    height: 64,
                    child: Center(
                      child: Text(
                        'inverseSurface',
                        style: TextStyle(
                          color: theme.colorScheme.onInverseSurface,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainer,
                      border: Border.all(color: theme.dividerColor),
                    ),
                    width: 128,
                    height: 64,
                    child: Center(
                      child: Text(
                        'surfaceContainer',
                        style: TextStyle(color: theme.colorScheme.onSurface),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    await tester.loadAssets();
    await tester.pump();
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('golden_test.png'),
    );
  });
}

/// A kdeglobals file representing a dark green theme.
const _darkGreenKdeGlobals = '''
[Colors:Tooltip]
BackgroundNormal=31,37,25
ForegroundLink=142,196,88
ForegroundInactive=193,196,190
ForegroundActive=142,196,88
ForegroundPositive=146,207,156
DecorationFocus=142,196,88
ForegroundNegative=253,161,160
ForegroundVisited=142,196,88
ForegroundNormal=214,216,211
DecorationHover=142,196,88
ForegroundNeutral=247,224,98
BackgroundAlternate=36,45,28

[Colors:Button]
DecorationHover=142,196,88
ForegroundPositive=146,207,156
ForegroundLink=142,196,88
DecorationFocus=142,196,88
ForegroundNormal=214,216,211
BackgroundAlternate=142,196,88
ForegroundVisited=142,196,88
ForegroundActive=142,196,88
ForegroundNeutral=247,224,98
ForegroundNegative=253,161,160
ForegroundInactive=193,196,190
BackgroundNormal=48,52,44

[Colors:Header]
DecorationHover=142,196,88
DecorationFocus=142,196,88
ForegroundNormal=214,216,211
ForegroundVisited=142,196,88
ForegroundInactive=193,196,190
ForegroundNegative=253,161,160
ForegroundPositive=146,207,156
ForegroundActive=142,196,88
BackgroundNormal=11,17,6
BackgroundAlternate=18,26,10
ForegroundNeutral=247,224,98
ForegroundLink=142,196,88

[Icons]
Theme=breeze-dark

[Colors:Selection]
DecorationHover=53,58,48
BackgroundAlternate=32,38,27
ForegroundNegative=253,161,160
ForegroundLink=11,17,6
ForegroundActive=142,196,88
ForegroundNeutral=247,224,98
ForegroundPositive=146,207,156
ForegroundNormal=142,196,88
DecorationFocus=53,58,48
BackgroundNormal=53,58,48
ForegroundVisited=142,196,88
ForegroundInactive=98,127,68

[General]
Name=COSMIC Dark
ColorScheme=CosmicDark
shadeSortColumn=true

[Colors:Header][Inactive]
ForegroundInactive=193,196,190
ForegroundNormal=214,216,211
ForegroundActive=142,196,88
DecorationHover=142,196,88
ForegroundNegative=253,161,160
DecorationFocus=142,196,88
ForegroundNeutral=247,224,98
BackgroundNormal=11,17,6
BackgroundAlternate=18,26,10
ForegroundLink=142,196,88
ForegroundPositive=146,207,156
ForegroundVisited=142,196,88

[KDE]
widgetStyle=qt6ct-style
contrast=4

[ColorEffects:Inactive]
ChangeSelectionColor=false
IntensityEffect=0
Color=27,27,27
ColorEffect=2
ColorAmount=0.025
IntensityAmount=0
Enable=false
ContrastAmount=0.1
ContrastEffect=2

[ColorEffects:Disabled]
IntensityEffect=2
IntensityAmount=0.1
ColorEffect=0
Color=30,34,25
ContrastEffect=1
ContrastAmount=0.65
ColorAmount=0

[WM]
activeForeground=142,196,88
inactiveBackground=11,17,6
activeBlend=142,196,88
inactiveForeground=142,196,88
activeBackground=11,17,6
inactiveBlend=142,196,88

[Colors:Complementary]
ForegroundNeutral=247,224,98
DecorationHover=142,196,88
BackgroundNormal=11,17,6
ForegroundNegative=253,161,160
ForegroundInactive=193,196,190
ForegroundPositive=146,207,156
BackgroundAlternate=142,196,88
ForegroundActive=142,196,88
ForegroundNormal=214,216,211
ForegroundVisited=142,196,88
ForegroundLink=142,196,88
DecorationFocus=142,196,88

[KFileDialog Settings]
Allow Expansion=false
Show hidden files=false
Breadcrumb Navigation=true
Speedbar Width=143
Sort by=Name
Show Preview=false
Sort hidden files last=false
Show Inline Previews=true
View Style=DetailTree
Show Speedbar=true
Sort directories first=true
Sort reversed=false
Show Full Path=false
Decoration position=2
Automatically select filename extension=true

[Colors:Window]
DecorationFocus=142,196,88
ForegroundNegative=253,161,160
DecorationHover=142,196,88
ForegroundNeutral=247,224,98
ForegroundNormal=214,216,211
BackgroundAlternate=18,26,10
BackgroundNormal=11,17,6
ForegroundInactive=193,196,190
ForegroundPositive=146,207,156
ForegroundActive=142,196,88
ForegroundLink=142,196,88
ForegroundVisited=142,196,88

[Colors:View]
ForegroundNeutral=247,224,98
DecorationFocus=142,196,88
DecorationHover=142,196,88
BackgroundAlternate=36,45,28
ForegroundPositive=146,207,156
ForegroundNormal=214,216,211
ForegroundVisited=142,196,88
ForegroundLink=142,196,88
BackgroundNormal=31,37,25
ForegroundActive=142,196,88
ForegroundInactive=193,196,190
ForegroundNegative=253,161,160
''';
