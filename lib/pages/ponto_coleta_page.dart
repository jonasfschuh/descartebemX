// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navigationrail2/widget/logotipo.dart';
import 'package:provider/provider.dart';

import '../repository/ponto_coleta_repository.dart';
import '../widget/maps.dart';
import 'pontocoleta_data.dart';

// ignore: must_be_immutable
class PontoColetaPage extends StatefulWidget {
  final String chave;
  PontoColetaPage({Key? key, required this.chave}) : super(key: key);

  @override
  State<PontoColetaPage> createState() => _PontoColetaPageState();
}

class _PontoColetaPageState extends State<PontoColetaPage> {
  late PontoColetaRepository pontoColetaRepository;
  late Map pontoColeta;

  @override
  void didChangeDependencies() {
    pontoColetaRepository = Provider.of<PontoColetaRepository>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.chave.isNotEmpty) {
      pontoColeta = pontoColetaRepository.getPontoColetaByKey(widget.chave);
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(pontoColeta['entidade'] as String),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => PontoColetaData(
                    pontoColetaKey: pontoColeta['key'],
                    isInserting: false,
                    isBrowse: true));
              },
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                Get.to(() => PontoColetaData(
                    pontoColetaKey: pontoColeta['key'],
                    isInserting: false,
                    isBrowse: false));
                setState(() {});
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                pontoColetaRepository.remover(pontoColeta['key']);
                Get.back();
              },
              icon: Icon(Icons.delete),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.info),
                text: 'Informações',
              ),
              Tab(
                icon: Icon(Icons.shopping_cart),
                text: 'Materiais',
              ),
              Tab(
                icon: Icon(Icons.map),
                text: 'Mapa',
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(24),
                child: Logotipo(
                  image: pontoColeta['logotipo'] as String?,
                  width: 300,
                  chave: pontoColeta['key'],
                ),
              ),
              Text(pontoColeta['nome']),
              Text(pontoColeta['endereco']),
            ],
          ),
          materiais(),
          Maps(),
        ]),
      ),
    );
  }

  Widget materiais() {
    return Scaffold();
  }
}
