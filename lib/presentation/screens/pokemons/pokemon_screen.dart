import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/config.dart';
import '../../providers/providers.dart';

class PokemonScreen extends ConsumerWidget {

  final String pokemonId;

  const PokemonScreen({
    required this.pokemonId,
    super.key
  });

  @override

  Widget build(BuildContext context, WidgetRef ref) {

    final pokemonAsync = ref.watch(pokemonProvider(pokemonId));

    return pokemonAsync.when(
      data: (pokemon) => _PokemonVisual(pokemon: pokemon),
      error: (error, stackTrace) => _ErrorWidget(error: error.toString()),
      loading: () => _LoadingWidget(),
    );
  }
}

class _PokemonVisual extends StatelessWidget {

  final Pokemon pokemon;
  
  const _PokemonVisual({
    required this.pokemon
  });

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            Text("Sus habilidades son:", style: GoogleFonts.russoOne(fontSize: 20),),
            Text(pokemon.faculties.join(', '), style: GoogleFonts.russoOne(fontSize: 22),),
            Image.network(
              pokemon.faceImage ?? '',
              fit: BoxFit.contain,
              width: 300,
              height: 300,
            ),
            SizedBox(height: 15,),
            Text('Mide ${ pokemon.altitud / 10 }m. y pesa ${ pokemon.weight / 10}kg.',
            style: GoogleFonts.russoOne(fontSize: 22))
          ],
        )
      )
    );
  }
}

class _ErrorWidget extends StatelessWidget {

  final String error;

  const _ErrorWidget({
    required this.error
  });

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Error: $error')
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: CircularProgressIndicator(),
      )
    );
  }
}