import 'package:catalogo_de_videos/pages/cadastro.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/login_controller.dart';
import '../model/user.dart';
import 'home.dart';

enum LoginStatus{
  notSignIn,
  signIn
}

class LoginPage extends StatefulWidget {
  static String routeName = "/";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  final _formKey = GlobalKey<FormState>(); 
  // chave pra representar o formulario na aplicação, esse widget precisa dessa chave
  String? _email, _password;
  // late so instancia quando precisar usar
  late LoginController controller;
  var value;

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
        User user = await controller.getLogin(_email!, _password!);

        if (user.id != -1){
          setState(() {
            _loginStatus = LoginStatus.signIn;
          });
        } else {

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

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      preferences.setInt("value", 0);
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  savePref(int value, String user, String pass) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      preferences.setInt("value", value);
      preferences.setString("user", user);
      preferences.setString("pass", pass);
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  // switch case dentro do build dependendo do status
  @override
  Widget build(BuildContext context) {
    switch(_loginStatus){
      case LoginStatus.notSignIn:
        return Scaffold(
          appBar: AppBar(title: const Text("Login Page")),
          body: Container(
            child: Center(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: TextFormField(
                            onSaved: (newValue) => _email = newValue,  
                            //muda a variavel, ao inves de usar controller
                            decoration: const InputDecoration(
                              labelText: "Usuário",
                              border: OutlineInputBorder(),
                            ),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: TextFormField(
                            onSaved: (newValue) => _password = newValue,  
                            //muda a variavel, ao inves de usar controller
                            decoration: const InputDecoration(
                              labelText: "Senha",
                              border: OutlineInputBorder(),
                            ),
                          )
                        )
                      ]),
                  ), 
                  ElevatedButton(onPressed: _submit, child: const Text("Login")),
                  ElevatedButton(onPressed: ()=>{ Navigator.pushNamed(context, CadastroPage.routeName)}, child: const Text("Cadastre-se"))]),)),
        );
      case LoginStatus.signIn:
        return const HomePage();
    }
  }
}