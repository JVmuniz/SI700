import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'adviceList.dart';
import 'profile.dart';
import 'advice.dart';
//import 'home.dart';



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
      home: const TabBarDemo(),
    );
  }
}

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.tips_and_updates)),
                Tab(icon: Icon(Icons.account_box)),
                Tab(icon: Icon(Icons.favorite)),
              ],
            ),
            title: const Text('Trabalho'),
          ),
          body: TabBarView(
            children: [
              AdviceScreen(), // Primeira Tela
              ProfileForm(), // Segunda Tela
              AdviceListScreen(userId : 'Nkv1P7qgH4uwQitmbN6'), // Terceira Tela
            ],
          ),
        ),
      ),
    );
  }
}


