import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:listwhatever/shared/keys.dart';

class CounterRobot {
  const CounterRobot(this.$);
  final PatrolIntegrationTester $;

  Future<void> increment() async {
    // await $(keys.counterPage.incrementButton).scrollTo();
    await $(keys.counterPage.incrementButton).tap();
  }
}
