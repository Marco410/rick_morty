import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screens/screens.dart';

final currentIndexPage = StateProvider<int>((ref) {
  return 1;
});

final homeProvider = FutureProvider<Widget>((ref) async {
  final page = ref.watch(currentIndexPage);
  switch (page) {
    case 0:
      return const LastCharacterScreen();
    case 1:
      return const HomeScreen();
    case 2:
      return const LastFiveScreen();
    default:
      return const HomeScreen();
  }
});
