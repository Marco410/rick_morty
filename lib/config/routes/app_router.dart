import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/screens.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
      errorBuilder: (context, state) => ErrorScreen(error: state.error),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const HomeMainScreen(),
            routes: [
              GoRoute(
                path: 'character-detail',
                name: 'character_detail',
                builder: (context, state) => const HomeMainScreen(),
              ),
            ]),
      ]);
});
