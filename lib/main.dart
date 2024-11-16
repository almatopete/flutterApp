import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pokemon_service.dart';
import 'firebase_options.dart'; // Archivo que contiene las opciones de Firebase


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Instancia Firestore

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

      // Agrega la búsqueda a Firestore
      await _firestore.collection('searches').add({
        'name': pokemonName,
        'timestamp': Timestamp.now(),
        'height': data['height'],
        'weight': data['weight'],
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
                  Text('Height: ${_pokemonData!['height']}'),
                  Text('Weight: ${_pokemonData!['weight']}'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
