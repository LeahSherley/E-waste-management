import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileNotifier extends StateNotifier<File?> {
  ProfileNotifier() : super(null);

  void setImage(File? image) {
    state = image;
  }
}
final profileProvider =
    StateNotifierProvider<ProfileNotifier, File?>((ref) {
  return ProfileNotifier();
});

