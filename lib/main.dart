import 'package:flutter/material.dart';
import 'pokemon_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widgets Demo',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final PokemonService _pokemonService = PokemonService();

  Map<String, dynamic>? _pokemonData;
  String? _error;

  void _fetchPokemon() async {
    final pokemonName = _controller.text.toLowerCase();

    try {
      final data = await _pokemonService.fetchPokemon(pokemonName);
      setState(() {
        _pokemonData = data;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _pokemonData = null;
        _error = 'Error: Could not find Pokémon';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon Finder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Pokémon name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchPokemon,
              child: Text('Search'),
            ),
            SizedBox(height: 10),
            if (_error != null) 
              Text(_error!, style: TextStyle(color: Colors.red)),
            if (_pokemonData != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Nombre del Pokémon
                      Expanded(
                        child: Text(
                          _pokemonData!['name'].toString().toUpperCase(),
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Imagen del Pokémon
                      Image.network(
                        _pokemonData!['sprites']['front_default'],
                        height: 80,
                        width: 80,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Altura y Peso
                  Text('Height: ${_pokemonData!['height']}'),
                  Text('Weight: ${_pokemonData!['weight']}'),

                  SizedBox(height: 10),

                  // Habilidades
                  Text(
                    'Abilities',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  for (var ability in _pokemonData!['abilities'])
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text('- ${ability['ability']['name']}'),
                    ),

                  SizedBox(height: 10),

                  // Estadísticas
                  Text(
                    'Stats',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  for (var stat in _pokemonData!['stats'])
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text('${stat['stat']['name']}: ${stat['base_stat']}'),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}