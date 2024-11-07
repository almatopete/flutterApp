import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonService {
  final String baseUrl = 'https://pokeapi.co/api/v2';

  Future<Map<String, dynamic>> fetchPokemon(String pokemonName) async {
    final url = Uri.parse('$baseUrl/pokemon/$pokemonName');
    
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load Pokémon');
      }
    } catch (e) {
      throw Exception('Error fetching Pokémon data: $e');
    }
  }
}
