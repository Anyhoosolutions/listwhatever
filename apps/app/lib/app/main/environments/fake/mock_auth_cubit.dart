import 'package:anyhoo_auth/cubit/anyhoo_auth_cubit.dart';
import 'package:anyhoo_auth/cubit/anyhoo_auth_state.dart';
import 'package:anyhoo_auth/services/anyhoo_auth_service.dart';
import 'package:anyhoo_auth/services/anyhoo_enhance_user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listwhatever/app/main/environments/fake/fake_data.dart';
import 'package:listwhatever/shared/user/user_converter.dart';

import 'package:core_models/core_models.dart';

class MockAuthCubit implements AnyhooAuthCubit<User> {
  @override
  AnyhooAuthService get authService => throw UnimplementedError();

  @override
  UserConverter get converter => UserConverter();

  @override
  User copyAnyhooUser(User user) => user.copyWith();

  @override
  List<AnyhooEnhanceUserService<User>> get enhanceUserServices => const [];

  @override
  void init() {}

  @override
  Future<void> login(String email, String password) async {}

  @override
  Future<void> loginWithAnonymous() async {}

  @override
  Future<void> loginWithApple() async {}

  @override
  Future<void> loginWithGoogle() async {}

  @override
  Future<void> logout() async {}

  @override
  Future<void> refreshUser(User user) async {}

  @override
  Future<void> saveUser(User user) async {}

  @override
  AnyhooAuthState<User> get state => AnyhooAuthState(user: FakeData.demoUser);

  @override
  Stream<AnyhooAuthState<User>> get stream => Stream.value(state);

  @override
  void addError(Object error, [StackTrace? stackTrace]) {}

  @override
  Future<void> close() async {}

  @override
  void emit(AnyhooAuthState<User> state) {}

  @override
  bool get isClosed => false;

  @override
  void onChange(Change<AnyhooAuthState<User>> change) {}

  @override
  void onError(Object error, StackTrace stackTrace) {}
}
