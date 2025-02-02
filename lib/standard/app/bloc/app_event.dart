import 'package:equatable/equatable.dart';
import '/standard/userRepository/models/user.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();
}

class AuthenticationUserChanged extends AppEvent {
  const AuthenticationUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

// class AppOnboardingCompleted extends AppEvent {
//   const AppOnboardingCompleted();
// }

// class AppOpened extends AppEvent {
//   const AppOpened();
// }

class UpdateUser extends AppEvent {
  const UpdateUser({required this.user});
  final User user;

  @override
  List<Object> get props => [user];
}

class AddUser extends AppEvent {
  const AddUser({required this.user});
  final User user;

  @override
  List<Object> get props => [user];
}

// class UpdateSettings extends AppEvent {
//   const UpdateSettings(this.user, this.settings);

//   final User user;
//   final Settings settings;

//   @override
//   List<Object> get props => [user];
// }
