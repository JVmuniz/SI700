import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AdviceListScreen extends StatefulWidget {
  late String userId;

  AdviceListScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _AdviceListScreenState createState() => _AdviceListScreenState();
}

class _AdviceListScreenState extends State<AdviceListScreen> {
  List<String> favoritosList = [];
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');

  @override
  void initState() {
    super.initState();
    _loadUserFavorites();
  }

  Future<void> _loadUserFavorites() async {
    try {
      // Substitua 'ID_DO_USUARIO' pelo ID real do usuário
      DatabaseEvent event = await FirebaseDatabase.instance
          .ref()
          .child('Users')
          .child(widget.userId)
          .child('favoritos')
          .once();
      DataSnapshot dataSnapshot = event.snapshot;

      if (dataSnapshot.value != null) {
        Map<dynamic, dynamic> favoritosMap = dataSnapshot.value as Map<dynamic, dynamic>;
        favoritosList = favoritosMap.values.cast<String>().toList();
      }

      // Atualizar o estado para reconstruir a UI com os favoritos carregados
      setState(() {});
    } catch (error) {
      print('Error loading favorites: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoritosList.length,
      itemBuilder: (context, index) {
        final advice = favoritosList[index];

        return AdviceListItem(
          advice: advice,
          onFavoritePressed: () {
            // Lógica para desfavoritar o conselho (opcional)
            setState(() {
              DatabaseReference favoritosReference = ref.child(widget.userId)
              .child('favoritos');
              favoritosList.remove(advice);
              _removeAdviceFromFavorites(favoritosReference, advice);
            });
          },
        );
      },
    );
  }
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


class AdviceListItem extends StatelessWidget {
  final String advice;
  final VoidCallback onFavoritePressed;

  const AdviceListItem({
    required this.advice,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(advice),
      trailing: IconButton(
        icon: const Icon(Icons.favorite),
        onPressed: onFavoritePressed,
      ),
    );
  }
}
