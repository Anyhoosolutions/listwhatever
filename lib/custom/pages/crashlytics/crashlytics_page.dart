import 'dart:async';
import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:allmylists/standard/constants.dart';

class CrashlyticsPage extends StatelessWidget {
  const CrashlyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crashlytics',
        ),
      ),
      body: kIsWeb
          ? const Text('Not supported on web')
          : Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    FirebaseCrashlytics.instance.setCustomKey('example', 'flutterfire');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Custom Key "example: flutterfire" has been set \n'
                            'Key will appear in Firebase Console once an error has been reported.'),
                        duration: Duration(seconds: 5),
                      ),
                    );
                  },
                  child: const Text('Key'),
                ),
                ElevatedButton(
                  onPressed: () {
                    FirebaseCrashlytics.instance.log('This is a log example');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('The message "This is a log example" has been logged \n'
                            'Message will appear in Firebase Console once an error has been reported.'),
                        duration: Duration(seconds: 5),
                      ),
                    );
                  },
                  child: const Text('Log'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('App will crash is 5 seconds \n'
                            'Please reopen to send data to Crashlytics'),
                        duration: Duration(seconds: 5),
                      ),
                    );

                    // Delay crash for 5 seconds
                    sleep(const Duration(seconds: 5));

                    // Use FirebaseCrashlytics to throw an error. Use this for
                    // confirmation that errors are being correctly reported.
                    FirebaseCrashlytics.instance.crash();
                  },
                  child: const Text('Crash'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Thrown error has been caught and sent to Crashlytics.',
                        ),
                        duration: Duration(seconds: 5),
                      ),
                    );

                    // Example of thrown error, it will be caught and sent to
                    // Crashlytics.
                    throw StateError('Uncaught error thrown by app');
                  },
                  child: const Text('Throw Error'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Uncaught Exception that is handled by second parameter of runZonedGuarded.',
                        ),
                        duration: Duration(seconds: 5),
                      ),
                    );

                    // Example of an exception that does not get caught
                    // by `FlutterError.onError` but is caught by
                    // `runZonedGuarded`.
                    runZonedGuarded(
                      () {
                        Future<void>.delayed(const Duration(seconds: 2), () {
                          final list = <int>[];
                          logger.d(list[100]);
                        });
                      },
                      FirebaseCrashlytics.instance.recordError,
                    );
                  },
                  child: const Text('Async out of bounds'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Recorded Error'),
                          duration: Duration(seconds: 5),
                        ),
                      );
                      throw Error();
                    } catch (e, s) {
                      // "reason" will append the word "thrown" in the
                      // Crashlytics console.
                      await FirebaseCrashlytics.instance.recordError(
                        e,
                        s,
                        reason: 'as an example of fatal error',
                        fatal: true,
                      );
                    }
                  },
                  child: const Text('Record Fatal Error'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Recorded Error'),
                          duration: Duration(seconds: 5),
                        ),
                      );
                      throw Error();
                    } catch (e, s) {
                      // "reason" will append the word "thrown" in the
                      // Crashlytics console.
                      await FirebaseCrashlytics.instance.recordError(
                        e,
                        s,
                        reason: 'as an example of non-fatal error',
                      );
                    }
                  },
                  child: const Text('Record Non-Fatal Error'),
                ),
              ],
            ),
    );
  }
}
