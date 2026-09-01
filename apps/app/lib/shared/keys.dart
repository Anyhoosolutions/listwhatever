import 'package:flutter/foundation.dart';

class TopBarKeys {
  final backButton = const Key('topBarBackButton');
}

class BottomBarKeys {
  Key bottomBarButton(int index) => Key('bottomBarButton$index');
}

class CounterPageKeys {
  Key incrementButton = const Key('incrementButton');
}

class Keys {
  final topBar = TopBarKeys();
  final bottomBarKeys = BottomBarKeys();
  final counterPage = CounterPageKeys();
}

final keys = Keys();
