import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/core/theme/app_theme.dart';

const _supabaseUrl = 'http://10.0.2.2:54321';
const _supabaseKey = 'sb_publishable_ACJWlzQHlZjBrEguHvfOxg_3BJgxAaH';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: _supabaseUrl, publishableKey: _supabaseKey);
  runApp(const ProviderScope(child: AnimaApp()));
}

class AnimaApp extends ConsumerWidget {
  const AnimaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Anima',
      theme: AppTheme.light,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}