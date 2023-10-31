/*import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikesNotifier extends StateNotifier<int> {
  LikesNotifier() : super(0);
  bool _isLiked = false;

  bool get isLiked => _isLiked;
  void increment() {
    _isLiked = true;
    state++;
  }

  void decrement() {
    _isLiked = false;
    state--;
  }
}

final likesProvider = StateNotifierProvider<LikesNotifier, int>((ref) {
  return LikesNotifier();
});*/
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikesNotifier extends StateNotifier<Map<String, int>> {
  LikesNotifier() : super({});

  void increment(String postId) {
    state[postId] = (state[postId] ?? 0) + 1;
  }

  void decrement(String postId) {
    if (state.containsKey(postId)) {
      state[postId] = state[postId]! - 1;
      if (state[postId] == 0) {
        state.remove(postId);
      }
    }
  }

  bool isLiked(String postId) {
    return state.containsKey(postId);
  }
}

final likesProvider = StateNotifierProvider<LikesNotifier, Map<String, int>>((ref) {
  return LikesNotifier();
});

