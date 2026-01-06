import 'package:coffe_app_ui/domain/entities/coffee_entity.dart';
import 'package:coffe_app_ui/presentation/screens/splash_screen.dart';
import 'package:coffe_app_ui/presentation/screens/main_screen.dart';
import 'package:coffe_app_ui/presentation/screens/home_screen.dart';
import 'package:coffe_app_ui/presentation/screens/details_screen.dart';
import 'package:coffe_app_ui/presentation/screens/favorites_screen.dart';
import 'package:coffe_app_ui/presentation/screens/cart_screen.dart';
import 'package:coffe_app_ui/presentation/screens/notifications_screen.dart';
import 'package:coffe_app_ui/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Route names for type-safe navigation
class AppRoutes {
  static const String splash = '/';
  static const String main = '/main';
  static const String home = '/home';
  static const String details = '/details';
  static const String favorites = '/favorites';
  static const String cart = '/cart';
  static const String notifications = '/notifications';
  static const String profile = '/profile';
}

/// Global router configuration using go_router
final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.main,
      name: 'main',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.details,
      name: 'details',
      builder: (context, state) {
        final coffee = state.extra as CoffeeEntity;
        return DetailsScreen(coffee: coffee);
      },
    ),
    GoRoute(
      path: AppRoutes.favorites,
      name: 'favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),
    GoRoute(
      path: AppRoutes.cart,
      name: 'cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: AppRoutes.notifications,
      name: 'notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.uri}'),
    ),
  ),
);
