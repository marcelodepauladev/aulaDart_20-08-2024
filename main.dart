import 'package:flutter/material.dart';
import 'DataBaseHelp.dart';
import 'User.dart';

void main() {
  runApp(const MaterialApp(title: "Flutter", home: MyHomePage()));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    dbHelper = DataBaseHelper();
    dbHelper.conectaDB().whenComplete(() async {
      setState(() {});
    });

    return Scaffold(
        appBar: AppBar(title: const Text('Flutter')),
        body: Column(children: [
          caixaNome(),
          caixaEmail(),
          botaoIncluir(),
          Expanded(child: lista())
        ]));
  }

  lista() {
    return ListView.builder(
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
                  onTap: () => carregarDados(usuarios[index].name.toString(),
                      usuarios[index].email.toString()),
                  leading:
                      CircleAvatar(child: Text(usuarios[index].id.toString())),
                  title: Text(usuarios[index].email),
                  subtitle: Text(usuarios[index].email),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                        onPressed: () =>
                            alterar(int.parse(usuarios[index].id.toString())),
                        icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: () =>
                            excluir(int.parse(usuarios[index].id.toString())),
                        icon: const Icon(Icons.delete)),
                  ])));
        });
  }

  caixaNome() {
    return TextField(
        controller: txtNome,
        decoration: const InputDecoration(labelText: 'Informe o nome'));
  }

  caixaEmail() {
    return TextField(
        controller: txtEmail,
        decoration: const InputDecoration(labelText: 'Informe o email'));
  }

  botaoIncluir() {
    return ElevatedButton(
        child: const Text('Incluir'), onPressed: () => incluir());
  }

  carregarDados(String nome, String email) {
    txtNome.text = nome;
    txtEmail.text = email;
  }

  limpar() {
    txtNome.clear();
    txtEmail.clear();
  }

  incluir() async {
    User user = User(name: txtNome.text, email: txtEmail.text);
    dbHelper.insertUser(user);
    limpar();
  }

  alterar(int id) async {
    User user = User(name: txtNome.text, email: txtEmail.text);
    dbHelper.updatetUser(user);
    limpar();
  }

  excluir(int id) async {
    dbHelper.deleteUser(id);
    limpar();
  }
}

TextEditingController txtNome = TextEditingController();
TextEditingController txtEmail = TextEditingController();

late DataBaseHelper dbHelper;
List<User> usuarios = [];
