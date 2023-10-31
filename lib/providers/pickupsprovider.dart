import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompletedPickupsNotifier extends StateNotifier<int> {
  CompletedPickupsNotifier() : super(3);

  void increment() {
    state = state + 1;
  }
}

final completedPickupsProvider =
    StateNotifierProvider<CompletedPickupsNotifier, int>((ref) {
  return CompletedPickupsNotifier();
});
