import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _register(BuildContext context) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Crie uma referência para o Firebase Realtime Database
      DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

      // Envie os dados de nome, idade e email para o Firebase Realtime Database
      await databaseReference.child('Users').child(userCredential.user!.uid).set({
        'nome': nameController.text,
        'idade': ageController.text,
        'email': userCredential.user!.email,
        'notificacoes' : false
      });

      // Após o registro bem-sucedido, redirecione para a tela principal ou de login
      Navigator.of(context).pop(); // Fecha a tela de cadastro
    } catch (e) {
      // Lidar com erros de registro, por exemplo, exibir uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro no registro: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Idade'),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _register(context),
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}