// ignore_for_file: prefer_const_constructors
import 'package:atividade_2/home.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'adviceList.dart';
import 'profile.dart';
import 'advice.dart';
import 'package:firebase_database/firebase_database.dart';

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
      title: 'Seu App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // Defina a LoginScreen como a tela inicial
    );
  }
}
class TabBarDemo extends StatefulWidget {
  late String userEmail;

  TabBarDemo({Key? key, required this.userEmail}) : super(key: key);

  @override
  _TabBarDemoState createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> {
  int _currentIndex = 0;
  late Future<String> _userIdFuture;
  late List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
    _userIdFuture = _getUserId(ref, widget.userEmail);
  }

  Future<String> _getUserId(
      DatabaseReference usersReference, String? userEmail) async {
    DatabaseEvent event = await usersReference.once();
    DataSnapshot snapshot = event.snapshot;
    Map<dynamic, dynamic> usersMap = snapshot.value as Map<dynamic, dynamic>;

    // Procurar a chave do conselho a ser removido
    String userId = '';
    usersMap.forEach((key, userData) {
    String email = userData['email'];
    if (email == userEmail) {
      userId = key;
    }
  });

    return userId; // Retorne um valor padrão se o userId não for encontrado
  }

 void _initializeScreens(String userId) {
    _screens = [
      AdviceScreen(userId: userId), // Primeira Tela (Dicas)
      ProfileForm(userId : userId), // Segunda Tela (Perfil)
      AdviceListScreen(userId : userId), // Terceira Tela (Favoritos)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userIdFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro ao obter userId');
        } else {
          String userId = snapshot.data as String;
          if (userId.isNotEmpty && _screens.isEmpty) {
            _initializeScreens(userId);
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Trabalho'),
            ),
            body: _screens.isNotEmpty ? _screens[_currentIndex] : Container(),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.tips_and_updates),
                  label: 'Dicas',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_box),
                  label: 'Perfil',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favoritos',
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
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Opção 2'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
