import 'package:flutter/material.dart';


class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  bool _notificationsSwitch = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Nome'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Idade'),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          TextFormField(
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
              // Lógica para atualizar o cadastro
            },
            child: Text(
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

