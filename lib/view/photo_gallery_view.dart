import 'package:final_bloc_example/bloc/app_Bloc.dart';
import 'package:final_bloc_example/bloc/app_event.dart';
import 'package:final_bloc_example/bloc/app_state.dart';
import 'package:final_bloc_example/view/main_popup_menu_button.dart';
import 'package:final_bloc_example/view/storage_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

class PhotoGalleryView extends HookWidget {
  const PhotoGalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    final picker = useMemoized(() => ImagePicker(), [key]);
    final images = context.watch<AppBloc>().state.images ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
        actions: [
          // Text(context.read<AppBloc>().),
          Ink(child: IconButton(icon: Icon(Icons.add), onPressed: (){},),),
          IconButton(
            onPressed: () async {
              final image = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if (image == null) {
                return;
              }
              context.read<AppBloc>().add(
                    AppEventUploadImage(filePathToUpload: image.path),
                  );
            },
            icon: const Icon(Icons.download),
          ),
          const MainPopUpMenuButton()
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        children: images
            .map(
              (img) => StorageImageView(
                images: img,
              ),
            )
            .toList(),
      ),
    );
  }
}
