import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/document/screens/document_detail_screen.dart';
import '../../features/settings/screens/settings_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeIn).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/document/:id',
      pageBuilder: (context, state) {
        final idString = state.pathParameters['id']!;
        final id = int.parse(idString);
        return CustomTransitionPage(
          key: state.pageKey,
          child: DocumentDetailScreen(documentId: id),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final begin = const Offset(0.0, 0.1);
            final end = Offset.zero;
            final curve = Curves.easeInOutQuart;
            final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            final offsetAnimation = animation.drive(tween);
            
            return SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SettingsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final begin = const Offset(1.0, 0.0);
          final end = Offset.zero;
          final curve = Curves.easeInOutQuart;
          final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);
          
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    ),
  ],
);
