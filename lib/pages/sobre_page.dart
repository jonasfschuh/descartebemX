import 'package:flutter/material.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre'),
        //backgroundColor: Colors.yellow[400],
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Descarte Bem',
            style: TextStyle(fontSize: 20),
          ),
          Text('Versão 1.1\n'),
          Text('FURB - Fundação Universidade Regional de Blumenau',
              style: TextStyle(fontStyle: FontStyle.italic)),
          Text('Curso de Sistemas de Informação 2024/1'),
          Text('Projeto de Software II'),
          Text('Blumenau - Santa Catarina'),
        ],
      )),
    );
  }
}
