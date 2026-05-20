import 'package:flu_avm/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flu_avm/config/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

Future <void> main() async {

  WidgetsFlutterBinding.ensureInitialized(); //esto se pone siempre que el main sea asincrono
  
  MapboxOptions.setAccessToken(mapboxAccessToken);

  runApp(
    const ProviderScope( //toda la aplicación se maneja con providers de tipo riverpod
      child: MainApp(),
    )
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final darkModeState = ref.watch(isDarkModeProvider);

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(
        darkModeState: darkModeState,
        chooseColor: const Color.fromARGB(255, 238, 148, 14)
        ).getTheme(),
    );
  }
}