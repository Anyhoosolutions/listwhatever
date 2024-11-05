import 'package:firebase_storage/firebase_storage.dart';
import '/standard/emulator/emulator_info.dart';
import '/standard/emulator/get_emulator_info.dart';

const port = 9199;

Future<FirebaseStorage> getFirebaseStorage() async {
  final emulatorInfo = await getEmulatorInfo();
// Todo: Singleton here
  final instance = FirebaseStorage.instance;
  if (emulatorInfo.type != EmulatorType.none) {
    // LoggerHelper.logger.i('firebaseStorage. Using emulator ${emulatorInfo.address}');
    _connectToFirebaseEmulator(instance, emulatorInfo.address!);
  } else {
    // LoggerHelper.logger.i('firebaseStorage. Using firebase storage without emulator');
  }

  return instance;
}

void _connectToFirebaseEmulator(
  FirebaseStorage instance,
  String localHostString,
) {
  instance.useStorageEmulator(
    localHostString,
    port,
  );
}
