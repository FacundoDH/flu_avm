
import 'package:dio/dio.dart';

class PokemonService {

  static getPokemon<String>(String pokemonId) async {

    final dio = Dio();
    try {
      final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$pokemonId');
      final pokemonData = response.data;
      return pokemonData;
    } catch (e) {
      return e;
    }
  }
}