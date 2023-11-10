import 'package:flutter/material.dart';
import 'login.dart';



class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.login),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue, // Define a cor de fundo como azul
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Advicer',
                style: TextStyle(
                  fontSize: 36, // Tamanho da fonte maior
                  fontWeight: FontWeight.bold, // Fonte em negrito
                  color: Colors.white, // Cor do texto branca
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50, // Tamanho do círculo da imagem
                    backgroundImage: AssetImage('assets/images/EU.jpg'), // Caminho da imagem do criador 1
                  ),
                  SizedBox(width: 20), // Espaço entre os círculos
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/Thiago.jpg'), // Caminho da imagem do criador 2
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


