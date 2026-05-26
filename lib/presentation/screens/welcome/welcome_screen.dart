import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/providers.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

  final bool darkMode = ref.watch(isDarkModeProvider);
  final colors = Theme.of(context).colorScheme;
  final text = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: colors.primary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.data_object, color: colors.primary)
                  ),
                  SizedBox(width: 8),
                  Text('Flu AVM', style: text.titleLarge),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      ref.read(isDarkModeProvider.notifier).state = !darkMode;
                    },
                    icon: Icon(darkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined)
                  )
                ]
              )
            ],
          )
        ),
      )
    );
  }
}