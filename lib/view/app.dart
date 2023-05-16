import 'package:final_bloc_example/bloc/app_Bloc.dart';
import 'package:final_bloc_example/bloc/app_event.dart';
import 'package:final_bloc_example/bloc/app_state.dart';
import 'package:final_bloc_example/dialog/show_auth_error_dialog.dart';
import 'package:final_bloc_example/loading/loading_screen.dart';
import 'package:final_bloc_example/view/login_view.dart';
import 'package:final_bloc_example/view/photo_gallery_view.dart';
import 'package:final_bloc_example/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (context) => AppBloc()..add(const AppEventInitialize()),
      child: MaterialApp(
        title: 'Material App',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Material App Bar'),
          ),
          body: BlocConsumer<AppBloc, AppState>(
            listener: (context, state) {
              if (state.isLoading) {
                LoadingScreen().show(context: context, text: "Loading...");
              } else {
                LoadingScreen().hide();
              }
              final authError = state.authError;
              if (authError != null) {
                showAuthErrorDialog(
                  authError: authError,
                  context: context,
                );
              }
            },
            builder: (context, appState) {
              if (appState is AppStateLoggedOut) {
                return const LoginView();
              } else if (appState is AppStateLoggedIn) {
                return const PhotoGalleryView();
              } else if (appState is AppStateIsInRegistrationView) {
                return const RegistrationView();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
