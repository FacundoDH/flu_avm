
import 'package:dio/dio.dart';
import 'package:flu_avm/mappers/pokemon_mapper.dart';

class PokemonService {

  static getPokemon<String>(String pokemonId) async {

    final dio = Dio();
    try {

      final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$pokemonId');

      final pokemon = PokemonMapper.pokeApiPokemonToEntity(response.data);

      return (pokemon, 'Data obtenida correctamente');

    } catch (e) {

      return (null, 'No se pudo obtener el Pokemon');
      
    }
  }
}