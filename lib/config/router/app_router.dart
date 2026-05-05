import 'package:flu_avm/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
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
  ]
);