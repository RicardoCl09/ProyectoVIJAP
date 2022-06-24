import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto_vijap/theme/app_theme.dart';
import 'package:proyecto_vijap/widgets/widgets.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebase = FirebaseFirestore.instance;
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String, dynamic> formValues = {
      'dni': '',
      'first_name': '',
      'last_name': '',
      'password': '',
    };
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Registro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
              key: myFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  CustomInputFieldDNI(
                    labelText: 'DNI',
                    hintText: '12345678',
                    keyboardType: TextInputType.number,
                    formProperty: 'dni',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomInputField(
                      labelText: 'Nombre',
                      hintText: 'Nombre',
                      keyboardType: TextInputType.name,
                      formProperty: 'first_name',
                      formValues: formValues),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomInputField(
                      labelText: 'Apellido',
                      hintText: 'Apellido',
                      keyboardType: TextInputType.name,
                      formProperty: 'last_name',
                      formValues: formValues),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomInputField(
                      labelText: 'Contraseña',
                      hintText: 'Contraseña',
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      formProperty: 'password',
                      formValues: formValues),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        bool encontrado = false;
                        if (!myFormKey.currentState!.validate()) {
                          registroToast('Formulario no válido');
                          return;
                        } else {
                          try {
                            CollectionReference ref =
                                FirebaseFirestore.instance.collection('Users');
                            QuerySnapshot usuario = await ref.get();
                            if (usuario.docs.isNotEmpty) {
                              for (dynamic cursor in usuario.docs) {
                                if (cursor.get('dni') == formValues['dni']) {
                                  registroToast('DNI está en uso');
                                  encontrado = true;
                                  break;
                                }
                              }
                            }
                            if (!encontrado) {
                              await firebase.collection('Users').doc().set({
                                "dni": formValues['dni'],
                                "first_name": formValues['first_name'],
                                "last_name": formValues['last_name'],
                                "password": formValues['password'],
                                "Estado": "Activo"
                              });
                              Navigator.pop(context);
                              print(formValues);
                              registroToast('Registro Exitoso');
                            }
                          } catch (e) {
                            print('Error... $e');
                          }
                        }
                      },
                      child: const SizedBox(
                        width: double.infinity,
                        child: Center(child: Text('Guardar')),
                      ))
                ],
              )),
        ),
      ),
    );
  }

  void registroToast(msg) => Fluttertoast.showToast(
      msg: msg, backgroundColor: AppTheme.primary, textColor: Colors.white);
}
