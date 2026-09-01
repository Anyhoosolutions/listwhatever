import 'package:anyhoo_auth/anyhoo_auth.dart';
import 'package:anyhoo_core/models/arguments.dart';
import 'package:anyhoo_firebase/anyhoo_firebase.dart';
import 'package:listwhatever/shared/user/user_converter.dart';
import 'package:core_models/core_models.dart';

class AuthCubitFactory {
  static AnyhooAuthCubit<User> createAuthCubit({
    required Arguments arguments,
    required FirebaseInitializer firebaseInitializer,
  }) {
    return AnyhooAuthCubit<User>(
      authService: AnyhooFirebaseAuthService(
        firebaseAuth: firebaseInitializer.getAuth(),
      ),
      converter: UserConverter(),
    );
  }
}
