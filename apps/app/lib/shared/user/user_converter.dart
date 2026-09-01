import 'package:anyhoo_auth/models/anyhoo_user_converter.dart';
import 'package:core_models/core_models.dart';

class UserConverter implements AnyhooUserConverter<User> {
  @override
  User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson(User user) {
    return {
      'id': user.id,
      'email': user.email,
      'name': user.name,
    };
  }
}
