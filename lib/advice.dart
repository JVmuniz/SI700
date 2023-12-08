import 'package:flutter/material.dart';
import 'api_service.dart';

class AdviceScreen extends StatefulWidget {
  @override
  _AdviceScreenState createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen> {
  final ApiService _apiService = ApiService();
  String? _randomAdvice = 'Carregando...';
  bool _isFavorited = false;

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
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
      if (_isFavorited) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Conselho Favoritado'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Conselho Removido'),
          ),
        );
      }
    });
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