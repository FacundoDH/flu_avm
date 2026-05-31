import 'package:flu_avm/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/providers.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

  final bool darkMode = ref.watch(isDarkModeProvider);
  final serverStatus = ref.watch(bandsProvider).serverStatus;
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
              ),

              Spacer(),

              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal:14, vertical:4),
                    decoration: BoxDecoration(
                      border: Border.all(color: colors.primary),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('WS', style: TextStyle(color: colors.primary)),
                  ),

                  SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/movil.png', 
                        height: 80,
                        color: darkMode ? Colors.white : null,
                        colorBlendMode: BlendMode.srcIn,
                        ),
                      Image.asset(
                        'assets/images/puntos.png', 
                        height: 40,
                        color: darkMode ? Colors.white : null,
                        colorBlendMode: BlendMode.srcIn,
                        ),
                      Image.asset(
                        'assets/images/servidor.png', 
                        height: 80,
                        color: darkMode ? Colors.white : null,
                        colorBlendMode: BlendMode.srcIn,
                        ),
                    ],
                  )
                ],
              ),

              Spacer(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: (serverStatus == ServerStatus.Online)
                        ? Colors.green.withValues(alpha: 0.15)
                        : Colors.red.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.circle, 
                          size: 10, 
                          color: (serverStatus == ServerStatus.Online)
                            ? Colors.green
                            : Colors.red,
                        ),

                        SizedBox(width: 6),

                        Text(
                          (serverStatus == ServerStatus.Online)
                            ? 'CONECTADO'
                            : 'DESCONECTADO',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: (serverStatus == ServerStatus.Online) 
                            ? Colors.green
                            : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'WebSockets en vivo',
                    style: text.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 6),

                  Text(
                    'Aprende a construir apps con datos en tiempo real en Flutter. Dos ejemplos prácticos te esperan dentro.',
                    style: text.bodyMedium,
                  ),
                ],
              ),

              Spacer(),

              Row(
                children: [
                  Expanded(
                    child: _ExampleCard(
                      image: 'assets/images/mapa.jpg',
                      title: 'Mapas',
                      subtitle: 'Ubicación en tiempo real',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _ExampleCard(
                      image: 'assets/images/votaciones.jpg',
                      title: 'Votaciones',
                      subtitle: 'Gráfico que se actualiza'),)
                ],
              ),

              Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _StatBadge(value: '${appMenuItems.length}', label: 'PANTALLAS'),
                  _StatBadge(value: '2', label: 'WEBSOCKETS'),
                  _StatBadge(value: 'FD', label: 'FACUNDO DI PIERRO'),
                ]
              ),

              Spacer(),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => context.go('/home'),
                  child: Text('Comenzar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExampleCard extends StatelessWidget {
  
  final String image;
  final String title;
  final String subtitle;

  const _ExampleCard({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8, top: 8, right: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image,
                height: 170,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style:  TextStyle(fontWeight: FontWeight.bold),),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String value;
  final String label;

  const _StatBadge({
    required this.value,
    required this.label,
  });

  @override
  
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            label, style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
      );
  }
}