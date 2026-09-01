/// Firebase emulator ports for local development.
///
/// Change these when multiple projects run emulators on the same machine.
/// [rename_starter.dart] does not rewrite port numbers — adjust manually or via script.
abstract final class EmulatorPorts {
  static const auth = 11111;
  static const firestore = 11111;
  static const storage = 11111;
}
