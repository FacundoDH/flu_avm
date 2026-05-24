import 'package:flu_avm/config/config.dart';
import 'package:flu_avm/models/pokeapi_response.dart';

class PokemonMapper {

  static Pokemon pokeApiPokemonToEntity(Map<String, dynamic> json) {
    final pokeApiPokemon = PokeApiPokemonResponse.fromJson(json);

    return Pokemon(
      id: pokeApiPokemon.id,
      name: pokeApiPokemon.name,
      altitud: pokeApiPokemon.height,
      weight: pokeApiPokemon.weight,
      faculties: pokeApiPokemon.abilities.map((faculty) => faculty.ability!.name).toList(),
      faceImage: pokeApiPokemon.sprites.other?.home.frontDefault
    );
  }
}