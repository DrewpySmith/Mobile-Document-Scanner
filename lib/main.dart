import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/providers/theme_provider.dart';

void main() async {
  // Ensure native bindings are fully initialized before rendering
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    const ProviderScope(
      child: ScanMindApp(),
    ),
  );
}

class ScanMindApp extends ConsumerWidget {
  const ScanMindApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watches the themeProvider to reactively redraw theme changes
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'ScanMind',
      debugShowCheckedModeBanner: false,
      
      // Decoupled Theme System
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      
      // Declarative Navigation Routing System
      routerConfig: appRouter,
    );
  }
}
