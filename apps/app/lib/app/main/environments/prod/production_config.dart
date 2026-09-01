import 'package:anyhoo_auth/cubit/anyhoo_auth_cubit.dart';
import 'package:anyhoo_core/models/arguments.dart';
import 'package:anyhoo_firebase/anyhoo_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lowercase_app_name/app/di/app_auth_factory.dart';
import 'package:lowercase_app_name/app/main/environment_config.dart';
import 'package:lowercase_app_name/app/main/environments/interfaces/app_repositories.dart';
import 'package:lowercase_app_name/app/main/environments/prod/flavors/flavor_profile.dart';
import 'package:lowercase_app_name/app/main/environments/prod/flavors/flavor_profiles.dart';
import 'package:lowercase_app_name/app/main/environments/prod/production_repositories.dart';
import 'package:lowercase_app_name/shared/firebase/firebase_options_resolver.dart';

import 'package:core_models/core_models.dart';

class ProductionConfig implements EnvironmentConfig {
  AnyhooAuthCubit<User>? _authCubit;

  @override
  FlavorProfile get flavorProfile => FlavorProfiles.active;

  @override
  Future<void> initializeInfrastructure(Arguments arguments) async {
    final options = FirebaseOptionsResolver.forFlavor(FlavorProfiles.activeFlavorName);
    final firebaseInitializer = await AppAuthFactory.initializeFirebase(
      arguments: arguments,
      options: options,
    );
    _authCubit = AppAuthFactory.create(
      arguments: arguments,
      firebaseInitializer: firebaseInitializer,
    );
  }

  @override
  Future<AppRepositories> repositories() async {
    final firestoreService = FirestoreService(firestore: FirebaseFirestore.instance);
    return ProductionRepositories(firestoreService: firestoreService);
  }

  @override
  Future<AnyhooAuthCubit<User>> getAuthCubit() async {
    final cubit = _authCubit;
    if (cubit == null) {
      throw StateError('ProductionConfig.initializeInfrastructure must run first.');
    }
    return cubit;
  }
}
