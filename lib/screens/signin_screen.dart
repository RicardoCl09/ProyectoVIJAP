import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proyecto_vijap/theme/app_theme.dart';
import 'package:proyecto_vijap/widgets/widgets.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  void displayDialogAndroid(BuildContext context, String mensaje,
      GlobalKey<FormState> myFormKey, Map<String, dynamic> formValues) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 5,
            title: Text(mensaje),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.android_outlined,
                  size: 100,
                  color: AppTheme.primary,
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar')),
              TextButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (!myFormKey.currentState!.validate()) {
                      print('Formulario no válido');
                      Navigator.pop(context);
                      return;
                    }
                    Navigator.pop(context);
                    Navigator.pop(context);
                    print(formValues);
                  },
                  child: const Text('Aceptar'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String, dynamic> formValues = {
      'dni': '',
      'first_name': '',
      'last_name': '',
      'user_name': '',
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
                      labelText: 'Nombre de Usuario',
                      hintText: 'Nombre de Usuario',
                      keyboardType: TextInputType.text,
                      formProperty: 'user_name',
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
                      onPressed: () => Platform.isAndroid
                          ? displayDialogAndroid(
                              context, 'Tudo ben', myFormKey, formValues)
                          : print('No hay IOS implementado'),
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
}
