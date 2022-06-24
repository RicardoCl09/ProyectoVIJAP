import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto_vijap/screens/home_screen.dart';
import 'package:proyecto_vijap/theme/app_theme.dart';
import 'package:proyecto_vijap/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  final Map<String, dynamic> formValues = {'dni': '', 'password': ''};

  @override
  Widget build(BuildContext context) {
    bool encontrado = false;
    bool validado = false;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Form(
                  key: myFormKey,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/logo1.png',
                        height: 400,
                      ),
                      CustomInputFieldDNI(
                          labelText: 'DNI',
                          hintText: '12345678',
                          keyboardType: TextInputType.number,
                          formProperty: 'dni',
                          formValues: formValues),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomInputField(
                          labelText: 'Contraseña',
                          hintText: 'Contraseña',
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          formProperty: 'password',
                          formValues: formValues),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (!myFormKey.currentState!.validate()) {
                              loginToast('Datos inválidos');
                              return;
                            }
                            try {
                              CollectionReference ref = FirebaseFirestore
                                  .instance
                                  .collection('Users');
                              QuerySnapshot usuario = await ref.get();
                              if (usuario.docs.isNotEmpty) {
                                for (dynamic cursor in usuario.docs) {
                                  encontrado = false;
                                  validado = false;
                                  if (cursor.get('dni') == formValues['dni']) {
                                    encontrado = true;
                                    if (cursor.get('password') ==
                                        formValues['password']) {
                                      validado = true;
                                      print('Ingresando...');
                                      break;
                                    } else {
                                      loginToast('Contraseña Incorrecta');
                                    }
                                  }
                                }
                                if (!encontrado) {
                                  loginToast('Usuario no registrado');
                                }
                                if (encontrado == true && validado == true) {
                                  loginToast('Inicio de Sesion Exitoso');
                                  myFormKey.currentState?.reset();
                                  Navigator.pushNamed(context, 'home');
                                }
                              } else {
                                print('No hay registros');
                              }
                            } catch (e) {
                              print('Error... $e');
                            }
                          },
                          child: const SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text('Iniciar Sesión'),
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, 'sign'),
                          child: const SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text('Registrarse'),
                            ),
                          ))
                    ],
                  )),
            ),
          )),
    );
  }

  void loginToast(msg) => Fluttertoast.showToast(
      msg: msg, backgroundColor: AppTheme.primary, textColor: Colors.white);
}
