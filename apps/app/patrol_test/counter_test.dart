import 'package:patrol/patrol.dart';

import 'robots/app_robot.dart';
import 'robots/counter_robot.dart';

void main() {
  patrolTest('count to three', skip: false, ($) async {
    final appRobot = AppRobot($);
    final counterRobot = CounterRobot($);

    await appRobot.runApp($, useDb: false);

    await appRobot.clickBottomBarButton(1);

    await appRobot.verifyText('0');

    await counterRobot.increment();
    await appRobot.verifyText('1');

    await counterRobot.increment();
    await appRobot.verifyText('2');

    await counterRobot.increment();
    await appRobot.verifyText('3');
  });
}
