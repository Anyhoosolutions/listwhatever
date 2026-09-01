import 'package:anyhoo_auth/anyhoo_auth.dart';
import 'package:anyhoo_auth/widgets/login_widget_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lowercase_app_name/app/main/environments/prod/flavors/flavor_profiles.dart';

import 'package:core_models/core_models.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flavor = FlavorProfiles.active;
    final title = flavor.isStaging ? 'My App (Staging)' : 'My App';

    return Scaffold(
      body: SafeArea(
        child: LoginWidget(
          title: title,
          cubit: context.read<AnyhooAuthCubit<User>>(),
          loginWidgetSettings: const LoginWidgetSettings(
            showEmailSignIn: true,
            showGoogleSignIn: true,
            showAppleSignIn: true,
            showAnonymousSignIn: false,
          ),
        ),
      ),
    );
  }
}
