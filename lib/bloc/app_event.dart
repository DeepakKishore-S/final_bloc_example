// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AppEvent {
  const AppEvent();
}

@immutable
class AppEventUploadImage extends AppEvent {
  final String filePathToUpload;
  const AppEventUploadImage({
    required this.filePathToUpload,
  });
}

@immutable
class AppEventDeleteAccount extends AppEvent {
  const AppEventDeleteAccount();
}

@immutable
class AppEventLogOut extends AppEvent {
  const AppEventLogOut();
}

@immutable
class AppEventInitialize extends AppEvent {
  const AppEventInitialize();
}

@immutable
class AppEventLogin extends AppEvent {
  final String login;
  final String  password;
  const AppEventLogin({
    required this.login,
    required this.password,
  });
}

@immutable
class AppEventGoToRegistration extends AppEvent {
  const AppEventGoToRegistration();
}

@immutable
class AppEventGoToLogin extends AppEvent {
  const AppEventGoToLogin();
}

@immutable
class AppEventRegister extends AppEvent {
  final String login;
  final String  password;
  const AppEventRegister({
    required this.login,
    required this.password,
  });
}