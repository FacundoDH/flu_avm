import 'package:flu_avm/presentation/screens/home/home_screen.dart';
import 'package:flu_avm/presentation/screens/numerator/numerator_screen.dart';
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
    )
  ],
);