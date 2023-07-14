import 'package:flutter/material.dart';

import '../controller/login_controller.dart';
import '../model/user.dart';
import 'home.dart';

enum LoginStatus{
  notSignIn,
  signIn
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  final _formKey = GlobalKey<FormState>(); 
  // chave pra representar o formulario na aplicação, esse widget precisa dessa chave
  String? _username, _password;
  // late so instancia quando precisar usar
  late LoginController controller;

  // ou seja, instancia o controller se a pagina for chamada
  _LoginPageState(){
    controller = LoginController();
  }


  void _submit() async{
    final form = _formKey.currentState;

    // valida todos os campos
    if (form!.validate()){
      form.save();

      //verifica se login e usuario bate com banco de dados
      
      try{
        User user = await controller.getLogin(_username!, _password!);

        if (user.id != -1){
          _loginStatus = LoginStatus.signIn;
        } else {

          // exemplo de saveUser na mao

          await controller.saveUser(
            User(
              username: _username!, 
              password: _password!)
            );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Usuário não registrado!")
            )
        );
        }

      } catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString())
          )
        );
      }
    }
  }

  // switch case dentro do build dependendo do status
  @override
  Widget build(BuildContext context) {
    switch(_loginStatus){
      case LoginStatus.notSignIn:
        return Scaffold(
          appBar: AppBar(title: Text("Login Page")),
          body: Container(
            child: Center(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: TextFormField(
                            onSaved: (newValue) => _username = newValue,  
                            //muda a variavel, ao inves de usar controller
                            decoration: InputDecoration(
                              labelText: "Usuário",
                              border: OutlineInputBorder(),
                            ),
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: TextFormField(
                            onSaved: (newValue) => _password = newValue,  
                            //muda a variavel, ao inves de usar controller
                            decoration: InputDecoration(
                              labelText: "Senha",
                              border: OutlineInputBorder(),
                            ),
                          )
                        )
                      ]),
                  ), 
                  ElevatedButton(onPressed: _submit, child: Text("Login"))]),)),
        );
      case LoginStatus.signIn:
        return HomePage();
    }
  }
}