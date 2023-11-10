import 'package:flutter/material.dart';

class AdviceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return AdviceListItem(
          advice: 'Conselho ${index + 1}',
        );
      },
    );
  }
}

class AdviceListItem extends StatelessWidget {
  final String advice;

  const AdviceListItem({required this.advice});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(advice),
      trailing: IconButton(
        icon: const Icon(Icons.favorite),
        onPressed: () {
          // Lógica para desfavoritar o conselho
        },
      ),
    );
  }
}