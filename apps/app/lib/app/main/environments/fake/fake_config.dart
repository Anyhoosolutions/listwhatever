import 'package:anyhoo_auth/cubit/anyhoo_auth_cubit.dart';
import 'package:anyhoo_core/models/arguments.dart';
import 'package:listwhatever/app/main/environment_config.dart';
import 'package:listwhatever/app/main/environments/fake/fake_repositories.dart';
import 'package:listwhatever/app/main/environments/fake/mock_auth_cubit.dart';
import 'package:listwhatever/app/main/environments/interfaces/app_repositories.dart';
import 'package:listwhatever/app/main/environments/prod/flavors/flavor_profile.dart';
import 'package:listwhatever/app/main/environments/prod/flavors/flavor_profiles.dart';

import 'package:core_models/core_models.dart';

class FakeConfig implements EnvironmentConfig {
  @override
  FlavorProfile get flavorProfile => FlavorProfiles.active;

  @override
  Future<void> initializeInfrastructure(Arguments arguments) async {}

  @override
  Future<AppRepositories> repositories() async => FakeRepositories();

  @override
  Future<AnyhooAuthCubit<User>> getAuthCubit() async => MockAuthCubit();
}
