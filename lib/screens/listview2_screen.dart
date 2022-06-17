import 'package:flutter/material.dart';

class Listview2Screen extends StatelessWidget {
  final options = const [
    'Michael Jackson',
    'Elvis Presley',
    'Marilyn Monroe',
    'Alan García'
  ];

  const Listview2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Personas Encontradas'),
        ),
        body: ListView.separated(
            itemCount: options.length,
            itemBuilder: (context, index) => ListTile(
                  title: Text(options[index]),
                  // trailing: const Icon(Icons.arrow_forward_ios_rounded,
                  // color: Colors.teal),
                  onTap: () {
                    final game = options[index];
                    print(game);
                  },
                ),
            separatorBuilder: (context, index) => const Divider()));
  }
}
