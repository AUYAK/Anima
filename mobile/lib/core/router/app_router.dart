import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/auth/data/auth_repository.dart';
import 'package:mobile/features/auth/presentation/pages/login_page.dart';
import 'package:mobile/features/auth/presentation/pages/register_page.dart';
import 'package:mobile/features/calendar/presentation/pages/calendar_screen.dart';
import 'package:mobile/features/home/presentation/pages/home_screen.dart';
import 'package:mobile/features/pets/data/pet_model.dart';
import 'package:mobile/features/pets/presentation/pages/add_pet_screen.dart';
import 'package:mobile/features/pets/presentation/pages/pet_list_screen.dart';
import 'package:mobile/features/pets/presentation/pages/pet_profile_screen.dart';
import 'package:mobile/features/profile/presentation/pages/profile_screen.dart';
import 'package:mobile/shared/widgets/main_scaffold.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
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
        parentNavigatorKey: _rootNavigatorKey,
        path: '/pets/add',
        builder: (ctx, _) => const AddPetScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/pets/:id',
        builder: (ctx, state) => PetProfileScreen(pet: state.extra as PetModel),
      ),
      StatefulShellRoute.indexedStack(
        builder: (ctx, _, shell) => MainScaffold(navigationShell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/home', builder: (_, _) => const HomeScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/pets', builder: (_, _) => const PetListScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/calendar', builder: (_, _) => const CalendarScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/profile', builder: (_, _) => const ProfileScreen()),
          ]),
        ],
      ),
    ],
  );
});
