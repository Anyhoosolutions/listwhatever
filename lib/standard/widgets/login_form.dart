import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';

import '/custom/navigation/routes.dart';
import '/standard/appUi/generated/assets.gen.dart';
import '/standard/appUi/spacing/app_spacing.dart';
import '/standard/appUi/widgets/app_button.dart';
import '/standard/bloc/login_bloc.dart';
import '/standard/bloc/login_event.dart';
import '/standard/bloc/login_state.dart';
import '/standard/page/login_with_email_and_password_page_route.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(l10n.authenticationFailure)),
            );
        }
      },
      child: const _LoginContent(),
    );
  }
}

class _LoginContent extends StatelessWidget {
  const _LoginContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: constraints.maxHeight * .75),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.xxlg,
            ),
            children: [
              _GoogleLoginButton(),
              if (theme.platform == TargetPlatform.iOS) ...[
                const SizedBox(height: AppSpacing.lg),
                _AppleLoginButton(),
              ],
              const SizedBox(height: AppSpacing.lg),
              _FacebookLoginButton(),
              const SizedBox(height: AppSpacing.lg),
              _TwitterLoginButton(),
              const SizedBox(height: AppSpacing.lg),
              _ContinueWithEmailAndPasswordLoginButton(),
            ],
          ),
        );
      },
    );
  }
}

class _AppleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppButton.black(
      key: const Key('loginForm_appleLogin_appButton'),
      onPressed: () => context.read<LoginBloc>().add(LoginAppleSubmitted()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.apple.svg(),
          const SizedBox(width: AppSpacing.lg),
          const Padding(
            padding: EdgeInsets.only(top: AppSpacing.xs),
            child: Text('Continue with Apple'),
          ),
        ],
      ),
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppButton.outlinedWhite(
      key: const Key('loginForm_googleLogin_appButton'),
      onPressed: () => context.read<LoginBloc>().add(LoginGoogleSubmitted()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.google.svg(),
          const SizedBox(width: AppSpacing.lg),
          const Padding(
            padding: EdgeInsets.only(top: AppSpacing.xxs),
            child: Text('Continue with Google'),
          ),
        ],
      ),
    );
  }
}

class _FacebookLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppButton.blueDress(
      key: const Key('loginForm_facebookLogin_appButton'),
      onPressed: () => context.read<LoginBloc>().add(LoginFacebookSubmitted()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.facebook.svg(),
          const SizedBox(width: AppSpacing.lg),
          const Text('Continue with Facebook'),
        ],
      ),
    );
  }
}

class _TwitterLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppButton.crystalBlue(
      key: const Key('loginForm_twitterLogin_appButton'),
      onPressed: () => context.read<LoginBloc>().add(LoginTwitterSubmitted()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.twitter.svg(),
          const SizedBox(width: AppSpacing.lg),
          const Text('Continue with Twitter'),
        ],
      ),
    );
  }
}

class _ContinueWithEmailAndPasswordLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppButton.outlinedTransparentDarkAqua(
      key: const Key('loginForm_emailAndPasswordLogin_appButton'),
      onPressed: () =>
          const LoginWithEmailAndPasswordPageRoute().push<void>(context),
      textStyle: Theme.of(context).textTheme.titleMedium,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.emailOutline.svg(),
          const SizedBox(width: AppSpacing.lg),
          Text(
            AppLocalizations.of(context).loginWithEmailAndPasswordButtonText,
          ),
        ],
      ),
    );
  }
}
