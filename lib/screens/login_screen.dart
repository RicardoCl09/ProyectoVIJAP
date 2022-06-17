import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_vijap/theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  validarDatos() async {
    try {
      CollectionReference ref = FirebaseFirestore.instance.collection('Users');
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 199, 199, 199),
          body: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Image.asset(
                      'assets/logo.png',
                      height: 500,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _userTextField(user),
                  const SizedBox(
                    height: 15,
                  ),
                  _passwordTextField(pass),
                  const SizedBox(
                    height: 25,
                  ),
                  _buttonLogin(),
                  const SizedBox(
                    height: 25,
                  ),
                  _buttonSignin(),
                ],
              ),
            ),
          )),
    );
  }

  Widget _userTextField(TextEditingController user) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: TextField(
          controller: user,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            icon: Icon(Icons.person_rounded, color: AppTheme.primary),
            hintText: 'Nombre de Usuario',
            labelText: 'Usuario',
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  Widget _passwordTextField(TextEditingController pass) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: TextField(
          controller: pass,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: const InputDecoration(
            icon: Icon(
              Icons.lock,
              color: AppTheme.primary,
            ),
            hintText: 'Contraseña',
            labelText: 'Contraseña',
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  Widget _buttonLogin() {
    // final ButtonStyle style = ElevatedButton.styleFrom(textStyle: cont)
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, 'home');
        },
        style: ElevatedButton.styleFrom(
            primary: AppTheme.primary,
            elevation: 10.0,
            padding: const EdgeInsets.symmetric(horizontal: 60)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
          child: const Text(
            'Login',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    });
  }

  Widget _buttonSignin() {
    // final ButtonStyle style = ElevatedButton.styleFrom(textStyle: cont)
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, 'sign');
        },
        style: ElevatedButton.styleFrom(
            primary: AppTheme.primary,
            elevation: 10.0,
            padding: const EdgeInsets.symmetric(horizontal: 20)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
          child: const Text(
            'Registro',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    });
  }
}
