import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class MaterialRepository extends ChangeNotifier {
  //final List<PontoColeta> _pontoscoleta = [];
  late DatabaseReference _dbRef;
  late List _materiaisItemList = [];
  // ignore: unused_field
  late List _materiaisList = [];
  late Map<String, dynamic> _materiais;

  DatabaseReference get dbRef => _dbRef;

  Map<String, dynamic> get materiais => _materiais;
  UnmodifiableListView get materiaisItemList =>
      UnmodifiableListView(_materiaisItemList);

  Map getMaterialByKey(String key) {
    return _materiais[key];
  }

  String getNomeMaterialByKey(String key) {
    return _materiais[key]['nome'];
  }

  MaterialRepository() {
    initRepository();
  }

  initRepository() async {
    _dbRef = FirebaseDatabase.instance.ref().child('material');
    await loadData();
  }

  Future<void> inserir(Map<String, String> material) async {
    DatabaseReference newChildRef = dbRef.push();
    String key = newChildRef.key as String;
    dbRef.child(key).update(material);

    _materiais[key] = material;
    _materiais = Utils.addKeyIntoMapValue(_materiais);
    notifyListeners();
  }

  Future<void> alterar(String key, Map<String, String> material) async {
    await dbRef.child(key).update(material);
    _materiais[key] = material;
    _materiais = Utils.addKeyIntoMapValue(_materiais);
    notifyListeners();
  }

  Future<void> remover(String key) async {
    await dbRef.child(key).remove();
    _materiais.remove(key);

    notifyListeners();
  }

  loadData() async {
    if (Utils.onLineMode) {
      DataSnapshot snapshot = await dbRef.get();
      _materiais = Map<String, dynamic>.from(snapshot.value as Map);
      _materiais = Utils.addKeyIntoMapValue(_materiais);
      _materiaisList = _materiais.values.toList();
    } else {
      _materiais = getMaterialMock();
    }

    _materiaisItemList.add({"id": "0", "label": "Selecione o material"});
    _materiais.forEach((key, value) {
      print(key);
      print(value['nome']);
      _materiaisItemList.add({"id": key, "label": value['nome']});
    });
    print('dentro initRepository: ' + _materiaisItemList.length.toString());
    notifyListeners();
  }

  static Map<String, dynamic> getMaterialMock() {
    return Utils.addKeyIntoMapValue(Map<String, dynamic>.from(materiaisMock));
  }

  static Map materiaisMock = {
    "-NsWuUvb1fyw1HsExEg0": {
      "ativo": "S",
      "dataAlteracao": "2019-07-22T16:00:04.8579075",
      "dataRegistro": "2019-07-22T16:00:04.8579075",
      "nome": "Pilhas",
      "usuarioAtivador": "jonas"
    },
    "-NsWuX9Uy855Zs-B3qd8": {
      "ativo": "S",
      "dataAlteracao": "2019-07-22T16:00:04.8579075",
      "dataRegistro": "2019-07-22T16:00:04.8579075",
      "nome": "Lampadas",
      "usuarioAtivador": "jonas"
    },
    "-NsWuZ18rKAW5SGQCZVv": {
      "ativo": "S",
      "dataAlteracao": "2019-07-22T16:00:04.8579075",
      "dataRegistro": "2019-07-22T16:00:04.8579075",
      "nome": "Baterias",
      "usuarioAtivador": "jonas"
    }
  };
}
