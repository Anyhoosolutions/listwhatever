import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:listwhatever/auth/bloc/auth_bloc.dart';
import 'package:listwhatever/pages/auth/social_button.dart';
import 'package:listwhatever/routing/go_router_configuration.dart';

class SignInOptionsPage extends StatelessWidget {
  const SignInOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Create Account 22',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.visibility),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Handle sign-up logic here
                  },
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 20),
                const Center(child: Text('or')),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialButton(
                      icon: HugeIcons.strokeRoundedApple,
                      onPressed: () {
                        // Handle Apple sign-in
                      },
                    ),
                    const SizedBox(width: 20),
                    SocialButton(
                      icon: HugeIcons.strokeRoundedGoogle,
                      onPressed: () {
                        // Handle Google sign-in
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).goNamed(RouteName.logIn.value);
                      },
                      child: const Text('Log In'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void logIn(BuildContext context) {
    GoRouter.of(context).goNamed(RouteName.logIn.value);
  }

  void register(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(RegisterWithEmailAndPassword());
  }

  void appleSignUp(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(SignUpWithApple());
  }

  void googleSignUp(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(SignUpWithGoogle());
  }
}
