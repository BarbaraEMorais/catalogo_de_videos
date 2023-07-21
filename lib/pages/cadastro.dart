import 'package:catalogo_de_videos/components/form/form_input.dart';
import 'package:catalogo_de_videos/pages/login.dart';
import 'package:flutter/material.dart';
import '../controller/cadastro_controller.dart';
import '../controller/login_controller.dart';
import '../model/user.dart';
import '../styles/theme_colors.dart';
import 'home.dart';

enum LoginStatus { notSignIn, signIn }

class CadastroPage extends StatefulWidget {
  static String routeName = "/cadastro";
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  //LoginStatus _loginStatus = LoginStatus.notSignIn;
  final _formKey = GlobalKey<FormState>();
  // chave pra representar o formulario na aplicação, esse widget precisa dessa chave
  String? _name, _email, _password;
  // late so instancia quando precisar usar
  late CadastroController controller;

  // ou seja, instancia o controller se a pagina for chamada
  _CadastroPageState() {
    controller = CadastroController();
  }

  void _submit() async {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();
      bool cadastrado = await controller.verifyEmail(_email!);
      if (cadastrado) {
        User user = User(email: _email!, name: _name!, password: _password!);
        controller.saveUser(user);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cadastrado com sucesso')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuário já cadastrado')),
        );
      }
    }
  }

  // switch case dentro do build dependendo do status
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
        backgroundColor: ThemeColors.appBar,
        centerTitle: true,
      ),
      backgroundColor: ThemeColors.background,
      body: Container(
          child: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Form(
            key: _formKey,
            child: Column(children: [
              FormInput(
                  label: "Nome",
                  maxLines: 1,
                  onChanged: (value) => {_name = value},
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira seu nome!';
                    }
                    return null;
                  }),
              FormInput(
                  label: "E-mail",
                  maxLines: 1,
                  onChanged: (value) => {_email = value},
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira seu e-mail!';
                    }
                    return null;
                  }),
              FormInput(
                  label: "Senha",
                  maxLines: 1,
                  onChanged: (value) => {_password = value},
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira sua senha!';
                    }
                    return null;
                  }),
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      onPressed: _submit, child: const Text("Cadastrar")))
            ]),
          ),
        ]),
      )),
    );
  }
}
