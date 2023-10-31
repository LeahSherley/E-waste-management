import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteNotifier extends StateNotifier<bool> {
  FavoriteNotifier() : super(false); 

 
  void toggleFavorite() {
    state = !state;
  }
}

final favoriteProvider = StateNotifierProvider<FavoriteNotifier, bool>((ref) {
  return FavoriteNotifier();
});
