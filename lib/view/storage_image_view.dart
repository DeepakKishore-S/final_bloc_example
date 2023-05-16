import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageImageView extends StatelessWidget {
  final Reference images;
  const StorageImageView({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: images.getData(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
            {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          case ConnectionState.done:
            {
              if (snapshot.hasData) {
                final data = snapshot.data;
                return Image.memory(
                  data!,
                  fit: BoxFit.cover,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          default:
            return const SizedBox();
        }
      },
    );
  }
}
