import 'package:atividade_2/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart'; // Importe sua tela principal aqui

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Redirecione para a tela principal após o login bem-sucedido
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TabBarDemo(userEmail: emailController.text,)), // Substitua MyHomePage() pela sua tela principal
      );
    } catch (e) {
      // Lidar com erros de autenticação, por exemplo, exibir uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Usuário ou senha inválidos'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Redirecione para a tela de cadastro quando o botão for pressionado
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()), // Substitua RegisterPage() pela sua tela de cadastro
                );
              },
              child: Text('Ainda não tem uma conta? Cadastre-se'),
            ),
          ],
        ),
      ),
    );
  }
}