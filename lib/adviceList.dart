import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AdviceListScreen extends StatefulWidget {
  final String userId; // Id do usuário no banco de dados

  AdviceListScreen({required this.userId});

  @override
  _AdviceListScreenState createState() => _AdviceListScreenState();
}

class _AdviceListScreenState extends State<AdviceListScreen> {
  final DatabaseReference _userReference = FirebaseDatabase.instance.ref().child('Users');

  List<String> favoritosList = [];

  @override
  void initState() {
    super.initState();
    // Carregar a lista de favoritos quando o widget for iniciado
    loadFavoritosList();
  }

  Future<void> loadFavoritosList() async {
    _userReference
        .child(widget.userId)
        .child('favoritos')
        .onValue.listen((event) {
          if (event.snapshot.value != null) {
            Map<dynamic, dynamic> favoritosMap = (event.snapshot.value as Map<dynamic, dynamic>);
            favoritosList = favoritosMap.values.cast<String>().toList();
            print(favoritosList);
            setState(() {
              build(context);
            });
        }
    },
    onError: (Object error) {
      print('Error fetching favoritos: $error');
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Favoritos'),
      ),
      body: favoritosList.isNotEmpty
          ? ListView.builder(
              itemCount: favoritosList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(favoritosList[index]),
                  // Adicione outros elementos da lista conforme necessário
                );
              },
            )
          : const Center(
              child: Text('Nenhum favorito disponível.'),
            ),
    );
  }
}
