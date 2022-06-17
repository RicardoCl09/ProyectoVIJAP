import 'package:flutter/material.dart';
import 'package:proyecto_vijap/widgets/widgets.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Personas Desaparecidas')),
        body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: const [
              // CustomCardType1(),
              SizedBox(height: 20),
              CustomCardType2(
                name: 'Humberto Jenner',
                imageUrl: 'assets/foto1.jpg',
              ),
              SizedBox(height: 20),
              CustomCardType2(
                name: 'Adolf Hitler',
                imageUrl: 'assets/foto2.jpg',
              ),
              SizedBox(height: 20),
              CustomCardType2(
                name: 'Apu',
                imageUrl: 'assets/foto3.jpg',
              ),
              SizedBox(height: 20),
              CustomCardType2(
                name: 'Madame Courie',
                imageUrl: 'assets/foto4.jpg',
              ),
              SizedBox(height: 20),
              CustomCardType2(
                name: 'Kratos de Esparta',
                imageUrl: 'assets/foto5.jpg',
              ),
              SizedBox(height: 20),
              CustomCardType2(
                name: 'John F. Kennedy',
                imageUrl: 'assets/foto6.jpg',
              ),
            ]));
  }
}
