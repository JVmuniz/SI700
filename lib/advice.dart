import 'package:flutter/material.dart';

class AdviceScreen extends StatefulWidget {
  @override
  _AdviceScreenState createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen> {
  bool _isFavorited = false;

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
    return Column(
      children: <Widget>[
        AdviceContainer(),
        const SizedBox(height: 20),
        ButtonRow(
          onFavoritePressed: _toggleFavorite,
          isFavorited: _isFavorited,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Lógica para gerar um novo conselho
          },
          child: Text(
            'Gerar Conselho',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(primary: Colors.blue),
        ),
      ],
    );
  }
}

class AdviceContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text(
          '"Aproveite cada momento da sua vida!"',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontFamily: 'RobotoMono',
          ),
        ),
      ),
    );
  }
}

class ButtonRow extends StatelessWidget {
  final Function()? onFavoritePressed;
  final bool isFavorited;

  const ButtonRow({
    Key? key,
    required this.onFavoritePressed,
    required this.isFavorited,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
            isFavorited ? Icons.favorite : Icons.favorite_border,
            color: isFavorited ? Colors.red : null,
          ),
          onPressed: onFavoritePressed,
        ),
      ],
    );
  }
}
