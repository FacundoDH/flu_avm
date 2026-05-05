import 'package:flu_avm/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumeratorScreen extends ConsumerWidget {

  const NumeratorScreen({super.key});

  @override

  Widget build(BuildContext context, WidgetRef ref) {

    final clickNumerator = ref.watch(numeratorProvider); //accedemos al dato ref de numeratorProvider, cada vez que el valor cambie lo podemos redibujar y guardará el valor

    return Scaffold(
      appBar: AppBar(
        title: Text('Numerator Screen'),
      ),
      body: Center(
        child: Text('Valor: $clickNumerator', style: Theme.of(context).textTheme.titleLarge,),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            ref.read(numeratorProvider.notifier).state++; //el .notifier permite notificar a todos los widgets que usen este numerator de un cambio
        }, //usamos esto para incrementar 'counter' al pulsar
        child: Icon(Icons.add),
      ),
    );
  }
}