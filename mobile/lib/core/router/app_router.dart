import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/auth/data/auth_repository.dart';
import 'package:mobile/features/auth/presentation/pages/login_page.dart';
import 'package:mobile/features/auth/presentation/pages/register_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull?.session != null;
      final onAuthPage =
          state.matchedLocation == '/login' || state.matchedLocation == '/register';

      if (!isLoggedIn && !onAuthPage) return '/login';
      if (isLoggedIn && onAuthPage) return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (ctx, _) => const LoginPage()),
      GoRoute(path: '/register', builder: (ctx, _) => const RegisterPage()),
      GoRoute(
        path: '/home',
        builder: (ctx, _) => const Scaffold(
          body: Center(child: Text('Home - coming soon')),
        ),
      ),
    ],
  );
});