import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  bool _notificationsSwitch = true;

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  late DatabaseReference ref;

  @override
  void initState() {
    super.initState();
    ref = FirebaseDatabase.instance.ref().child('Users');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: _nomeController,
            decoration: InputDecoration(labelText: 'Nome'),
          ),
          TextFormField(
            controller: _idadeController,
            decoration: InputDecoration(labelText: 'Idade'),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          TextFormField(
            controller: _senhaController,
            decoration: InputDecoration(labelText: 'Senha'),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text('Notificações'),
              Switch(
                value: _notificationsSwitch,
                onChanged: (value) {
                  setState(() {
                    _notificationsSwitch = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // final user = ({
              //   "nome" : _nomeController.text,
              //   "idade" : _idadeController.text,
              //   "senha" : _senhaController.text,
              //   "email" : _emailController.text,
              //   "notificacoes" : _notificationsSwitch.toString(),
              //   "favoritos" : []
              // });

              // ref.push().set(user).whenComplete(() => ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(
              //     content: Text('Cadastro Atualizado'),
              //   ),
              // ));

              final snapshot = ref.orderByChild('email').equalTo(_emailController.text).once();
              print(snapshot);

              // final userInfo = {
              //   "{$_emailController.text}/nome": _nomeController,
              //   "{$_emailController.text}/idade": _idadeController,
              //   "{$_emailController.text}/notificacoes": _notificationsSwitch,
              //   "{$_emailController.text}/senha": _senhaController,
              // };
              

              
            },
            child: const Text(
              'Atualizar Cadastro',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(primary: Colors.blue),
          ),
        ],
      ),
    );
  }
}

