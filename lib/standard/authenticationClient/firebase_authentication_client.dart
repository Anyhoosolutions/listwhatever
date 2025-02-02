import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/twitter_login.dart';

import '/standard/authenticationClient/authentication_client.dart';
import '/standard/authenticationClient/models/authentication_user.dart';
import '/standard/authenticationClient/token_storage.dart';

/// Signature for [SignInWithApple.getAppleIDCredential].
typedef GetAppleCredentials = Future<AuthorizationCredentialAppleID> Function({
  required List<AppleIDAuthorizationScopes> scopes,
  WebAuthenticationOptions webAuthenticationOptions,
  String nonce,
  String state,
});

/// {@template firebase_authentication_client}
/// A Firebase implementation of the [AuthenticationClient] interface.
/// {@endtemplate}
class FirebaseAuthenticationClient implements AuthenticationClient {
  /// {@macro firebase_authentication_client}
  FirebaseAuthenticationClient({
    required TokenStorage tokenStorage,
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    GetAppleCredentials? getAppleCredentials,
    FacebookAuth? facebookAuth,
    TwitterLogin? twitterLogin,
  })  : _tokenStorage = tokenStorage,
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),
        _getAppleCredentials =
            getAppleCredentials ?? SignInWithApple.getAppleIDCredential,
        _facebookAuth = facebookAuth ?? FacebookAuth.instance,
        _twitterLogin = twitterLogin ??
            TwitterLogin(
              apiKey: const String.fromEnvironment('TWITTER_API_KEY'),
              apiSecretKey: const String.fromEnvironment('TWITTER_API_SECRET'),
              redirectURI: const String.fromEnvironment('TWITTER_REDIRECT_URI'),
            ) {
    user.listen(_onUserChanged);
  }
  final String className = 'FirebaseAuthenticationClient';

  final TokenStorage _tokenStorage;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final GetAppleCredentials _getAppleCredentials;
  final FacebookAuth _facebookAuth;
  final TwitterLogin _twitterLogin;

  /// Stream of [AuthenticationUser] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [AuthenticationUser.anonymous] if the user is not authenticated.
  @override
  Stream<AuthenticationUser> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null
          ? AuthenticationUser.anonymous
          : firebaseUser.toUser;
    });
  }

  /// Starts the Sign In with Email and Password Flow.
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  @override
  Future<void> logInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        LogInWithEmailAndPasswordFailure(error, null),
        stackTrace,
      );
    }
  }

  /// Starts the Sign In with Apple Flow.
  ///
  /// Throws a [LogInWithAppleFailure] if an exception occurs.
  @override
  Future<void> logInWithApple() async {
    try {
      final appleIdCredential = await _getAppleCredentials(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oAuthProvider = firebase_auth.OAuthProvider('apple.com');
      final credential = oAuthProvider.credential(
        idToken: appleIdCredential.identityToken,
        accessToken: appleIdCredential.authorizationCode,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogInWithAppleFailure(error, null), stackTrace);
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleCanceled] if the flow is canceled by the user.
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  @override
  Future<firebase_auth.UserCredential> logInWithGoogle() async {
    if (kIsWeb) {
      return logInWithGoogleWeb();
    } else {
      return logInWithGoogleOther();
    }
  }

  Future<firebase_auth.UserCredential> logInWithGoogleOther() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw LogInWithGoogleCanceled(
          Exception('Sign in with Google canceled'),
          null,
        );
      }
      final googleAuth = await googleUser.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCreds = await _firebaseAuth.signInWithCredential(credential);

      return userCreds;
    } on LogInWithGoogleCanceled {
      rethrow;
    } catch (error, stackTrace) {
      final extraMessage = (error is AssertionError)
          ? error.message.toString()
          : error.runtimeType.toString();
      Error.throwWithStackTrace(
        LogInWithGoogleFailure(error, extraMessage),
        stackTrace,
      );
    }
  }

  Future<UserCredential> logInWithGoogleWeb() async {
    try {
      // Create a new provider
      final googleProvider = GoogleAuthProvider()
        ..addScope('https://www.googleapis.com/auth/contacts.readonly')
        ..setCustomParameters({'login_hint': 'user@example.com'});

      // Once signed in, return the UserCredential
      final userCredentials =
          await FirebaseAuth.instance.signInWithPopup(googleProvider);

      return userCredentials;

      // Or use signInWithRedirect
      // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
    } catch (error, stackTrace) {
      var extraMessage = error.runtimeType.toString();
      if (error is AssertionError) {
        extraMessage = error.message.toString();
      }
      if (error is firebase_auth.FirebaseAuthException) {
        extraMessage = '${error.code} - ${error.message}';
      }
      Error.throwWithStackTrace(
        LogInWithGoogleFailure(error, extraMessage),
        stackTrace,
      );
    }
  }

  /// Starts the Sign In with Facebook Flow.
  ///
  /// Throws a [LogInWithFacebookCanceled] if the flow is canceled by the user.
  /// Throws a [LogInWithFacebookFailure] if an exception occurs.
  @override
  Future<void> logInWithFacebook() async {
    try {
      final loginResult = await _facebookAuth.login();
      if (loginResult.status == LoginStatus.cancelled) {
        throw LogInWithFacebookCanceled(
          Exception('Sign in with Facebook canceled'),
          null,
        );
      } else if (loginResult.status == LoginStatus.failed) {
        throw LogInWithFacebookFailure(
          Exception(loginResult.message),
          null,
        );
      }

      final accessToken = loginResult.accessToken?.tokenString;
      if (accessToken == null) {
        throw LogInWithFacebookFailure(
          Exception(
            'Sign in with Facebook failed due to an empty access token',
          ),
          null,
        );
      }

      final credential =
          firebase_auth.FacebookAuthProvider.credential(accessToken);

      await _firebaseAuth.signInWithCredential(credential);
    } on LogInWithFacebookCanceled {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        LogInWithFacebookFailure(error, null),
        stackTrace,
      );
    }
  }

  /// Starts the Sign In with Twitter Flow.
  ///
  /// Throws a [LogInWithTwitterCanceled] if the flow is canceled by the user.
  /// Throws a [LogInWithTwitterFailure] if an exception occurs.
  @override
  Future<void> logInWithTwitter() async {
    try {
      final loginResult = await _twitterLogin.loginV2();
      if (loginResult.status == TwitterLoginStatus.cancelledByUser) {
        throw LogInWithTwitterCanceled(
          Exception('Sign in with Twitter canceled'),
          null,
        );
      } else if (loginResult.status == TwitterLoginStatus.error) {
        throw LogInWithTwitterFailure(
          Exception(loginResult.errorMessage),
          null,
        );
      }

      final authToken = loginResult.authToken;
      final authTokenSecret = loginResult.authTokenSecret;
      if (authToken == null || authTokenSecret == null) {
        throw LogInWithTwitterFailure(
          Exception(
            'Sign in with Twitter failed due to invalid auth token or secret',
          ),
          null,
        );
      }

      final credential = firebase_auth.TwitterAuthProvider.credential(
        accessToken: authToken,
        secret: authTokenSecret,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } on LogInWithTwitterCanceled {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        LogInWithTwitterFailure(error, null),
        stackTrace,
      );
    }
  }

  /// Signs out the current user which will emit
  /// [AuthenticationUser.anonymous] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  @override
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogOutFailure(error, null), stackTrace);
    }
  }

  /// Updates the user token in [TokenStorage] if the user is authenticated.
  Future<void> _onUserChanged(AuthenticationUser user) async {
    if (!user.isAnonymous) {
      await _tokenStorage.saveToken(user.id);
    } else {
      await _tokenStorage.clearToken();
    }
  }
}

extension on firebase_auth.User {
  AuthenticationUser get toUser {
    return AuthenticationUser(
      id: uid,
      email: email,
      name: displayName,
      photo: photoURL,
      isNewUser: metadata.creationTime == metadata.lastSignInTime,
    );
  }
}
