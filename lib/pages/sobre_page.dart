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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Descarte Bem',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
          Text('Versão 1.3\n'),
          Text(
            'FURB - Fundação Universidade Regional de Blumenau',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('Curso de Sistemas de Informação 2024/1'),
          Text('Projeto de Software II'),
          Text('Blumenau - Santa Catarina'),
          Text(''),
          Text(
            'Notas da versão 1.3 (11/06/2024):',
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'Autor: Jonas Fernando Schuh \n',
            textAlign: TextAlign.left,
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          Text(
            '- Criação tela de Materiais.',
            textAlign: TextAlign.left,
          ),
          Text(
            '- Criação de fonte de dados para acesso a registros de Materiais.',
            textAlign: TextAlign.left,
          ),
          Text(
            '- Criação de funcionalidade para manutenção da fonte de dados de registros de Materiais.',
            textAlign: TextAlign.left,
          ),
          Text(
            '- Criação tela de inclusão, exclusão e alteração de Materiais.',
            textAlign: TextAlign.left,
          ),
          Text(
            '- Ajuste de mensagens de rodapé ao salvar registros de pontos de coleta, materiais e entidades.',
            textAlign: TextAlign.left,
          ),
          Text(
            '- Criação de caixa de seleção de materiais cadastrados na tela de inserção e manutenção de pontos de coleta.',
            textAlign: TextAlign.left,
          ),
        ],
      )),
    );
  }
}
