import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:proyecto_vijap/theme/app_theme.dart';
import 'package:proyecto_vijap/widgets/widgets.dart';

class InputsScreen extends StatefulWidget {
  const InputsScreen({Key? key}) : super(key: key);

  @override
  State<InputsScreen> createState() => _InputsScreenState();
}

class _InputsScreenState extends State<InputsScreen> {
  String? imageUrl;
  String? url;
  @override
  Widget build(BuildContext context) {
    final firebase = FirebaseFirestore.instance;
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String, dynamic> formValues = {
      'dni': '',
      'first_name': '',
      'last_name': '',
      'age': 0,
      'image': ''
    };

    return Scaffold(
        appBar: AppBar(
          title: const Text('Reportar Persona Desaparecida'),
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
                    hintText: 'DNI del Desaparecido',
                    keyboardType: TextInputType.number,
                    formProperty: 'dni',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomInputField(
                    labelText: 'Nombre',
                    hintText: 'Nombre del Desaparecido',
                    keyboardType: TextInputType.name,
                    formProperty: 'first_name',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomInputField(
                    labelText: 'Apellido',
                    hintText: 'Apellido del Desaparecido',
                    keyboardType: TextInputType.name,
                    formProperty: 'last_name',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomInputField(
                    labelText: 'Edad',
                    hintText: 'Edad del Desaparecido',
                    keyboardType: TextInputType.number,
                    formProperty: 'age',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      (imageUrl != null)
                          ? Image.network(imageUrl!)
                          : const Placeholder(
                              fallbackHeight: 10.0, fallbackWidth: 10.0),
                      const Text("Seleccionar Imagen: "),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                        child: const Text("Cargar Imagen"),
                        onPressed: () async {
                          final _storage = FirebaseStorage.instance;
                          final _picker = ImagePicker();
                          XFile? image;

                          image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            var file = File(image.path);
                            for (int i = 5; i >= 0; i--) {
                              inputToast('Espere $i segundos...');
                            }
                            var snapshot = await _storage
                                .ref()
                                .child("fotos/${image.path}")
                                .putFile(file);
                            imageUrl = await snapshot.ref.getDownloadURL();
                            formValues['image'] = imageUrl;
                          } else {
                            print("No se recibio");
                          }
                        },
                      )
                    ],
                  ),
                  Column(
                    children: [],
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        bool encontrado = false;
                        if (!myFormKey.currentState!.validate()) {
                          inputToast('Formulario no válido');
                          return;
                        } else {
                          try {
                            CollectionReference ref = FirebaseFirestore.instance
                                .collection('Desaparecidos');
                            QuerySnapshot usuario = await ref.get();
                            if (usuario.docs.isNotEmpty) {
                              for (dynamic cursor in usuario.docs) {
                                if (cursor.get('dni') == formValues['dni']) {
                                  inputToast('Persona reportada anteriormente');
                                  encontrado = true;
                                  break;
                                }
                              }
                            }
                            if (!encontrado) {
                              await firebase
                                  .collection('Desaparecidos')
                                  .doc()
                                  .set({
                                'dni': formValues['dni'],
                                'first_name': formValues['first_name'],
                                'last_name': formValues['last_name'],
                                'age': formValues['age'],
                                'image': formValues['image'],
                                'Estado': 'Desaparecido'
                              });
                              Navigator.pop(context);
                              print(formValues);
                              print(imageUrl);
                              inputToast('Reporte exitoso');
                            }
                          } catch (e) {
                            print('Error... $e');
                          }
                        }
                      },
                      child: const SizedBox(
                        width: double.infinity,
                        child: Center(child: Text('Reportar')),
                      ))
                ],
              ),
            ),
          ),
        ));
  }

  void inputToast(msg) => Fluttertoast.showToast(
      msg: msg, backgroundColor: AppTheme.primary, textColor: Colors.white);
}
