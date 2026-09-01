# Tests 

There are some different types of tests in this repo:

* Unit tests
* Widget tests
* Component tests
* Golden tests
* Patrol tests

## Tags: 

Tags are defined in `dart_test.yaml` and then can be used by `@Tags(['golden'])` at the top of a file.

### Running tests with only the tag 

`dart test --tags component`

### Running all tests except the ones with the tag

`dart test -x component`

## Types of tests

### Unit tests

### Widget tests

### Component tests

### Golden tests

#### Run tests

`flutter test -x golden`


#### Update goldens

`flutter test --update-goldens --tags=golden`

Or just one file 

`flutter test --update-goldens --tags=golden test/goldens/home_page_test.dart`

### Patrol tests

      Hint:  
      To avoid install Node.js dependencies every time, run `patrol develop -d emulator-5554 ` instead.

#### Run a single test: 

`patrol test -d chrome -t patrol_test/go_through_match_test.dart`
`patrol develop -d emulator-5554 --flavor prod -t patrol_test/go_through_match_test.dart`

#### Run all tests 

`patrol test -d chrome patrol_test/`

## Test coverage

`dart run coverage:test_with_coverage`

### Run report

`dart run test_cov_console -i`

#### To CSV

`dart run test_cov_console -c -o coverage/test_coverage.csv`

#### To HTML

`genhtml coverage/lcov.info -o coverage/html && open coverage/html/index.html`



## Debugging

If looking for a widget and can't find it, a little trick is to add something like

```dart
      final a = find.byType(Text);
      expect(a, findsExactly(11));
```

It will fail, but the output will then show something looking like

```bash
══╡ EXCEPTION CAUGHT BY FLUTTER TEST FRAMEWORK ╞════════════════════════════════════════════════════
The following TestFailure was thrown running a test:
Expected: exactly 11 matching candidates
  Actual: _TypeWidgetFinder:<Found 9 widgets with type "Text": [
            Text("TORREY PINES (NORTH)", inherit: true, color: Color(alpha: 1.0000, red: 0.7647,
green: 0.9569, blue: 0.0000, colorSpace: ColorSpace.sRGB), family: Oswald, size: 24.0, weight: 600,
height: 1.1x, dependencies: [DefaultSelectionStyle, DefaultTextStyle, MediaQuery]),
            Text("CHANGE COURSE", debugLabel: ((englishLike labelSmall
2021).merge(((whiteMountainView labelSmall).apply).merge(unknown))).copyWith, inherit: false, color:
Color(alpha: 1.0000, red: 0.0863, green: 0.1176, blue: 0.0000, colorSpace: ColorSpace.sRGB), family:
Inter, size: 10.0, weight: 700, letterSpacing: 0.5, baseline: alphabetic, height: 1.3x,
leadingDistribution: even, decoration: Color(alpha: 1.0000, red: 0.8863, green: 0.8941, blue:
0.8118, colorSpace: ColorSpace.sRGB) TextDecoration.none, dependencies: [DefaultSelectionStyle,
DefaultTextStyle, MediaQuery]),
            Text("San Diego, CA", debugLabel: ((englishLike labelMedium
2021).merge(((whiteMountainView labelMedium).apply).merge(unknown))).copyWith, inherit: false,
color: Color(alpha: 1.0000, red: 0.7686, green: 0.7882, blue: 0.6745, colorSpace: ColorSpace.sRGB),
family: Inter, size: 14.0, weight: 700, letterSpacing: 0.5, baseline: alphabetic, height: 1.4x,
leadingDistribution: even, decoration: Color(alpha: 1.0000, red: 0.8863, green: 0.8941, blue:
0.8118, colorSpace: ColorSpace.sRGB) TextDecoration.none, dependencies: [DefaultSelectionStyle,
DefaultTextStyle, MediaQuery]),
```

This means you get to at least see what kind of widgets are on the page.

### Other method


    final allText = find.byType(Text);
    expect(allText, findsWidgets);
    debugPrint('TEXT WIDGETS: ${allText.evaluate().map((e) => (e.widget as Text).data).whereType<String>().toList()}');
    expect($(PatrolUiText.rosterProgress(filled: 2, expected: 2)), findsOneWidget);
    