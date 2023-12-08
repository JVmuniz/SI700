import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';

class AdviceScreen extends StatefulWidget {
  late String userId;

  AdviceScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _AdviceScreenState createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen> {
  final ApiService _apiService = ApiService();
  String? _randomAdvice = 'Carregando...';
  bool _isFavorited = false;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');

  @override
  void initState() {
    super.initState();
    _loadRandomAdvice();
  }

  Future<void> _loadRandomAdvice() async {
    final advice = await _apiService.fetchRandomAdvice();
    setState(() {
      _randomAdvice = advice ?? 'Erro ao carregar conselho aleatório';
    });
    _isFavorited = false;
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
      if (_isFavorited) {
        ref.child(widget.userId)
        .child('favoritos')
        .push()
        .set(_randomAdvice).whenComplete(() => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Conselho Favoritado'),
          ),
        ));
        
      } else {
        DatabaseReference favoritosReference = ref.child(widget.userId)
        .child('favoritos');
        _removeAdviceFromFavorites(favoritosReference, _randomAdvice);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Conselho Removido'),
          ),
        );
      }
    });
  }

  Future<void> _removeAdviceFromFavorites(
    DatabaseReference favoritosReference, String? adviceToRemove) async {
    DatabaseEvent event = await favoritosReference.once();
    DataSnapshot snapshot = event.snapshot;
    Map<dynamic, dynamic> favoritosMap = snapshot.value as Map<dynamic, dynamic>;

    // Procurar a chave do conselho a ser removido
    String? keyToRemove;
    favoritosMap.forEach((key, value) {
      if (value == adviceToRemove) {
        keyToRemove = key;
      }
    });

    // Remover o conselho da lista de favoritos
    if (keyToRemove != null) {
      favoritosReference.child(keyToRemove!).remove();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conselho Aleatório'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Container(
            width: 300,
            height: 200,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                _randomAdvice ?? 'Carregando...',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontFamily: 'RobotoMono',
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.thumb_up),
                onPressed: () {
                  // Lógica para curtir o conselho
                },
              ),
              IconButton(
                icon: Icon(Icons.thumb_down),
                onPressed: () {
                  // Lógica para não curtir o conselho
                },
              ),
              IconButton(
                icon: Icon(
                  _isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorited ? Colors.red : null,
                ),
                onPressed: _toggleFavorite,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadRandomAdvice,
        child: Icon(Icons.refresh),
      ),
    );
  }
}