import 'package:anyhoo_auth/anyhoo_auth.dart';
import 'package:anyhoo_core/models/arguments.dart';
import 'package:anyhoo_firebase/anyhoo_firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:listwhatever/app/di/auth_factory.dart';
import 'package:listwhatever/shared/firebase/emulator_host.dart';
import 'package:listwhatever/shared/firebase/emulator_ports.dart';
import 'package:core_models/core_models.dart';

class AppAuthFactory {
  static AnyhooAuthCubit<User> create({
    required Arguments arguments,
    required FirebaseInitializer firebaseInitializer,
  }) {
    return AuthCubitFactory.createAuthCubit(
      arguments: arguments,
      firebaseInitializer: firebaseInitializer,
    );
  }

  static Future<FirebaseInitializer> initializeFirebase({
    required Arguments arguments,
    required FirebaseOptions options,
  }) async {
    final firebaseInitializer = FirebaseInitializer(
      arguments: arguments,
      emulatorConfig: EmulatorConfig(
        hostIp: EmulatorHost.defaultHost,
        authPort: EmulatorPorts.auth,
        firestorePort: EmulatorPorts.firestore,
        storagePort: EmulatorPorts.storage,
        overrideUseFirebaseEmulator: arguments.shouldUseFirebaseEmulator(),
        useFirebaseAuth: true,
        useFirebaseStorage: true,
        useFirebaseFirestore: true,
      ),
    );

    await firebaseInitializer.initialize(options);
    return firebaseInitializer;
  }
}
