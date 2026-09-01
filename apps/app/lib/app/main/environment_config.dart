import 'package:anyhoo_auth/anyhoo_auth.dart';
import 'package:anyhoo_core/models/arguments.dart';
import 'package:listwhatever/app/main/environments/interfaces/app_repositories.dart';
import 'package:listwhatever/app/main/environments/prod/flavors/flavor_profile.dart';

import 'package:core_models/core_models.dart';

abstract class EnvironmentConfig {
  FlavorProfile get flavorProfile;

  Future<AppRepositories> repositories();

  Future<void> initializeInfrastructure(Arguments arguments);

  Future<AnyhooAuthCubit<User>> getAuthCubit();
}
