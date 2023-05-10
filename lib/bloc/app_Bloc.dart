import 'dart:io';

import 'package:final_bloc_example/bloc/app_event.dart';
import 'package:final_bloc_example/bloc/app_state.dart';
import 'package:final_bloc_example/utils/upload_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : super(const AppStateLoggedOut(
          isLoading: false,
          authError: null,
        )) {
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
