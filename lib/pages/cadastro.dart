import 'package:catalogo_de_videos/components/form/form_input.dart';
import 'package:flutter/material.dart';
import '../controller/login_controller.dart';
import '../model/user.dart';
import '../styles/theme_colors.dart';
import 'home.dart';

enum LoginStatus{
  notSignIn,
  signIn
}

class CadastroPage extends StatefulWidget {
  static String routeName = "/cadastro";
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  final _formKey = GlobalKey<FormState>(); 
  // chave pra representar o formulario na aplicação, esse widget precisa dessa chave
  String? _name,_email, _password;
  // late so instancia quando precisar usar
  late LoginController controller;

  // ou seja, instancia o controller se a pagina for chamada
  _CadastroPageState(){
    controller = LoginController();
  }


  void _submit() async{
    final form = _formKey.currentState;

    // valida todos os campos
    if (form!.validate()){
      form.save();

      //verifica se login e usuario bate com banco de dados
      
      try{
        User user = await controller.getLogin(_name!, _password!);

        if (user.id != -1){
          _loginStatus = LoginStatus.signIn;
        } else {

          // exemplo de saveUser na mao

          await controller.saveUser(
            User(
              name: _name!, 
              password: _password!)
            );

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
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
          appBar: AppBar(
            title: const Text("Cadastro Page"), 
            backgroundColor: ThemeColors.appBar),
            backgroundColor: ThemeColors.background,
          body: Container(
            child: Center(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormInput(label: "Nome", maxLines: 1, onChanged: (value)=> {print(value)}, keyboardType:TextInputType.text, validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira seu nome!';
                        }
                        return null;
                      }),
                        FormInput(label: "E-mail", maxLines: 1, onChanged: (value)=> {print(value)}, keyboardType:TextInputType.emailAddress, validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira seu e-mail!';
                        }
                        return null;
                      }),
                      FormInput(label: "Senha", maxLines: 1, onChanged: (value)=> {print(value)}, keyboardType:TextInputType.text, validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira sua senha!';
                        }
                        return null;
                      }),
                      ]),
                  ), 
                  ElevatedButton(onPressed: _submit, child: const Text("Login"))]),)),
        );
      case LoginStatus.signIn:
        return const HomePage();
    }
  }
}