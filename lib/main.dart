// ignore_for_file: prefer_const_constructors
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'adviceList.dart';
import 'profile.dart';
import 'advice.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,  
  );
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TabBarDemo(),
    );
  }
}

class TabBarDemo extends StatefulWidget {
  const TabBarDemo({Key? key}) : super(key: key);

  @override
  _TabBarDemoState createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    AdviceScreen(), // Primeira Tela (Dicas)
    ProfileForm(), // Segunda Tela (Perfil)
    AdviceListScreen(), // Terceira Tela (Favoritos)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trabalho'),
      ),
      body: _screens[_currentIndex], // Troca de tela com base no índice atual
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Índice da guia atual
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Atualiza o índice para a guia selecionada
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.tips_and_updates),
            label: 'Dicas', // Nome da guia 1
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Perfil', // Nome da guia 2
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos', // Nome da guia 3
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu Principal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Opção 1'),
              onTap: () {
                // Implemente a ação que deseja executar quando a opção 1 for selecionada
                Navigator.pop(context); // Fecha o Drawer após a seleção
              },
            ),
            ListTile(
              title: Text('Opção 2'),
              onTap: () {
                // Implemente a ação que deseja executar quando a opção 2 for selecionada
                Navigator.pop(context); // Fecha o Drawer após a seleção
              },
            ),
            // Adicione mais opções de menu conforme necessário
          ],
        ),
      ),
    );
  }
}