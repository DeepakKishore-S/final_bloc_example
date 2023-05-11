import 'dart:io';

import 'package:final_bloc_example/auth/auth_error.dart';
import 'package:final_bloc_example/bloc/app_event.dart';
import 'package:final_bloc_example/bloc/app_state.dart';
import 'package:final_bloc_example/utils/upload_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : super(const AppStateLoggedOut(
          isLoading: false,
          authError: null,
        )) {
    on<AppEventDeleteAccount>(
      (event, emit) async {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          emit(const AppStateLoggedOut(
            isLoading: false,
            authError: null,
          ));
          return;
        }
        emit(AppStateLoggedIn(
          user: user,
          images: state.images ?? [],
          isLoading: true,
          authError: null,
        ));

        try {
          final foldercontents =
              await FirebaseStorage.instance.ref(user.uid).listAll();
          for (final item in foldercontents.items) {
            await item.delete().catchError((_) {});
          }
          await FirebaseStorage.instance
              .ref(user.uid)
              .delete()
              .catchError((_) {});
          await user.delete();
          await FirebaseAuth.instance.signOut();
          emit(const AppStateLoggedOut(
            isLoading: false,
            authError: null,
          ));
        } on FirebaseAuthException catch (e) {
          emit(AppStateLoggedIn(
            user: user,
            images: state.images ?? [],
            isLoading: false,
            authError: AuthError.from(e),
          ));
        } on FirebaseException {
          emit(const AppStateLoggedOut(
            isLoading: false,
            authError: null,
          ));
        }
      },
    );

    on<AppEventUploadImage>((
      event,
      emit,
    ) async {
      final user = state.user;
      if (user == null) {
        emit(const AppStateLoggedOut(
          isLoading: false,
          authError: null,
        ));
        return;
      }
      emit(AppStateLoggedIn(
        authError: null,
        isLoading: true,
        images: state.images ?? [],
        user: user,
      ));

      final file = File(event.filePathToUpload);
      await uploadImage(
        file: file,
        userid: user.uid,
      );

      final images = await _getImages(user.uid);
      emit(
        AppStateLoggedIn(
          authError: null,
          images: images,
          isLoading: false,
          user: user,
        ),
      );
    });
  }
}

Future<Iterable<Reference>> _getImages(String userId) =>
    FirebaseStorage.instance
        .ref(userId)
        .list()
        .then((listResult) => listResult.items);
