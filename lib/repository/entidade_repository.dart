import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class EntidadeRepository extends ChangeNotifier {
  //final List<PontoColeta> _pontoscoleta = [];
  late DatabaseReference _dbRef;
  late List _entidadesItemList = [];
  late Map<String, dynamic> _entidades;

  DatabaseReference get dbRef => _dbRef;

  Map<String, dynamic> get entidades => _entidades;
  UnmodifiableListView get entidadesItemList =>
      UnmodifiableListView(_entidadesItemList);

  Map getEntidadeByKey(String key) {
    return _entidades[key];
  }

  String getNomeEntidadeByKey(String key) {
    return _entidades[key]['nomeFantasia'];
  }

  EntidadeRepository() {
    initRepository();
  }

  initRepository() async {
    _dbRef = FirebaseDatabase.instance.ref().child('entidade');
    await loadData();
  }

  loadData() async {
    if (Utils.onLineMode) {
      DataSnapshot snapshot = await dbRef.get();
      _entidades = Map<String, dynamic>.from(snapshot.value as Map);
    } else {
      _entidades = getEntidadesMock();
    }

    _entidadesItemList.add({"id": "0", "label": "Selecione a entidade"});
    _entidades.forEach((key, value) {
      print(key);
      print(value['nomeFantasia']);
      _entidadesItemList.add({"id": key, "label": value['nomeFantasia']});
    });
    print('dentro initRepository: ' + _entidadesItemList.length.toString());
    notifyListeners();
  }

  static Map<String, dynamic> getEntidadesMock() {
    return Utils.addKeyIntoMapValue(Map<String, dynamic>.from(entidadesMock));
  }

  static Map entidadesMock = {
    "-NsX0wrNLe19kPdtLrXv": {
      "CNPJ": "01020150500",
      "dataAlteracao": "2019-07-22T16:00:04.8579075",
      "dataAtivacao": "2019-07-22T16:00:04.8579075",
      "dataAtualizacao": "2019-07-22T16:00:04.8579075",
      "dataRegistro": "2019-07-22T16:00:04.8579075",
      "email": "furb@furb.br",
      "endereco": "Rua Antonio da Veiga, 200",
      "entidade": "FURB",
      "nomeFantasia": "Fundação Universidade Regional de Blumenau",
      "pontosColeta": [
        {
          "endereco": "Benjamin Constant, 2638",
          "materiais": [
            {"nome": "Lampadas"},
            {"nome": "Pilhas"},
            {"nome": "Baterias"}
          ],
          "nome": "Bloco B"
        }
      ],
      "status": "Ativo",
      "telefone": "47 3200 0000"
    },
    "-NsX7HrlHN5BUyvSg2Tc": {
      "CNPJ": "01020150500",
      "dataAlteracao": "2019-07-22T16:00:04.8579075",
      "dataAtivacao": "2019-07-22T16:00:04.8579075",
      "dataAtualizacao": "2019-07-22T16:00:04.8579075",
      "dataRegistro": "2019-07-22T16:00:04.8579075",
      "email": "furb@furb.br",
      "endereco": "Rua São Paulo, 100",
      "entidade": "FURB",
      "nomeFantasia": "Prefeitura Municipal de Blumenau ",
      "pontosColeta": [
        {
          "endereco": "Benjamin Constant, 2638",
          "materiais": [
            {"nome": "Lampadas"},
            {"nome": "Pilhas"},
            {"nome": "Baterias"}
          ],
          "nome": "Bloco B"
        }
      ],
      "status": "Ativo",
      "telefone": "47 3200 0000"
    },
    "-NsX7Mb3xTHPZZrAStAt": {
      "CNPJ": "01020150500",
      "dataAlteracao": "2019-07-22T16:00:04.8579075",
      "dataAtivacao": "2019-07-22T16:00:04.8579075",
      "dataAtualizacao": "2019-07-22T16:00:04.8579075",
      "dataRegistro": "2019-07-22T16:00:04.8579075",
      "email": "furb@furb.br",
      "endereco": "Rua São Paulo, 400",
      "entidade": "FURB",
      "nomeFantasia": "Giassi Supermercados 2",
      "pontosColeta": [
        {
          "endereco": "Benjamin Constant, 2638",
          "materiais": [
            {"nome": "Lampadas"},
            {"nome": "Pilhas"},
            {"nome": "Baterias"}
          ],
          "nome": "Bloco B"
        }
      ],
      "status": "Ativo",
      "telefone": "47 3200 0000"
    },
    "-NsX7QLeVz84Yglmey8N": {
      "CNPJ": "01020150500",
      "dataAlteracao": "2019-07-22T16:00:04.8579075",
      "dataAtivacao": "2019-07-22T16:00:04.8579075",
      "dataAtualizacao": "2019-07-22T16:00:04.8579075",
      "dataRegistro": "2019-07-22T16:00:04.8579075",
      "email": "furb@furb.br",
      "endereco": "Rua dos Caçadores, 300",
      "entidade": "COOPER",
      "nomeFantasia": "Cooper Velha",
      "pontosColeta": [
        {
          "endereco": "Benjamin Constant, 2638",
          "materiais": [
            {"nome": "Lampadas"},
            {"nome": "Pilhas"},
            {"nome": "Baterias"}
          ],
          "nome": "Bloco B"
        }
      ],
      "status": "Ativo",
      "telefone": "47 3200 0000"
    },
    "-NsX7TjvNXZjqVeWR9a1": {
      "CNPJ": "01020150500",
      "dataAlteracao": "2019-07-22T16:00:04.8579075",
      "dataAtivacao": "2019-07-22T16:00:04.8579075",
      "dataAtualizacao": "2019-07-22T16:00:04.8579075",
      "dataRegistro": "2019-07-22T16:00:04.8579075",
      "email": "furb@furb.br",
      "endereco": "Rua Benjamin Constant, 2400",
      "entidade": "COOPER",
      "nomeFantasia": "Cooper Vila Nova",
      "pontosColeta": [
        {
          "endereco": "Benjamin Constant, 2638",
          "materiais": [
            {"nome": "Lampadas"},
            {"nome": "Pilhas"},
            {"nome": "Baterias"}
          ],
          "nome": "Bloco B"
        }
      ],
      "status": "Ativo",
      "telefone": "47 3200 0000"
    }
  };
}
