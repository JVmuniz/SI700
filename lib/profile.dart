import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfileForm extends StatefulWidget {
  late String userId;

  ProfileForm({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}


class _ProfileFormState extends State<ProfileForm> {
  bool _notificationsSwitch = true;
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    DatabaseReference userRef = FirebaseDatabase.instance
        .ref()
        .child('Users')
        .child(widget.userId);
    // Carregar informações do usuário ao iniciar
    _loadUserData(userRef);
  }

  // Método para carregar informações do usuário do banco de dados
  Future<void> _loadUserData(DatabaseReference userReference) async{
    DatabaseEvent event = await userReference.once();
    DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      Map<String, dynamic> userData = snapshot.value as Map<String, dynamic>;
        _nameController.text = userData['nome'] ?? '';
        _ageController.text = userData['idade']?.toString() ?? '';
        _emailController.text = userData['email'] ?? '';
        _notificationsSwitch = userData['notificacoes'] == false;
    }
  
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Nome'),
          ),
          TextFormField(
            controller: _ageController,
            decoration: InputDecoration(labelText: 'Idade'),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
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
              _updateUserProfile();
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

  // Método para atualizar o perfil do usuário no banco de dados
  void _updateUserProfile() {
    DatabaseReference userRef = FirebaseDatabase.instance
        .ref()
        .child('Users')
        .child(widget.userId);

    userRef.update({
      'nome': _nameController.text,
      'idade': _ageController.text,
      'email': _emailController.text,
      'notificacoes': _notificationsSwitch,
    }).whenComplete(() => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cadastro Atualizado'),
          ),
        ));

    // Lógica adicional, se necessário
  }

}