import 'package:flu_avm/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute (
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/numerator-river',
      builder: (context, state) => const NumeratorScreen(),
    ),
    GoRoute(
      path: '/bands',
      builder: (context, state) => const BandsScreen(),
    ),
    GoRoute(
      path: '/charts',
      builder: (context, state) => const ChartsScreen(),
    ),
    GoRoute(
      path: '/request',
      builder: (context, state) => const PokemonsScreen(),
      routes: [
        GoRoute(
          path: ':id', 
          builder: (context, state) {
            final id = state.pathParameters['id'] ?? '';
            return PokemonScreen(pokemonId: id,);
          },
        )
      ]
    ),
  ]
);