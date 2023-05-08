import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;

Map<String, AuthError> authErrorMapping = {};

@immutable
abstract class AuthError {
  final String dialogTitle;
  final String dialogText;
  const AuthError({
    required this.dialogTitle,
    required this.dialogText,
  });

  factory AuthError.from(FirebaseAuthException exception) =>
      authErrorMapping[exception.code.toUpperCase().trim()] ??
      const AuthErrorUnkown();
}

@immutable
class AuthErrorUnkown extends AuthError {
  const AuthErrorUnkown()
      : super(
            dialogTitle: "Authentication Error",
            dialogText: "Aunkown authentication error",);
}
