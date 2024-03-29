import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class PontoColetaRepository extends ChangeNotifier {
  late DatabaseReference _dbRef;
  late List _pontoscoletaList = [];
  late Map<String, dynamic> _pontoscoleta = {};

  DatabaseReference get dbRef => _dbRef;

  Map<String, dynamic> get pontoscoleta => _pontoscoleta;
  UnmodifiableListView get pontoscoletaList =>
      UnmodifiableListView(_pontoscoletaList);

  Map getPontoColetaByKey(String key) {
    return _pontoscoleta[key];
  }

  Future<void> inserir(Map<String, String> pontoColeta) async {
    DatabaseReference newChildRef = dbRef.push();
    String key = newChildRef.key as String;
    dbRef.child(key).update(pontoColeta);

    _pontoscoleta[key] = pontoColeta;
    _pontoscoleta = Utils.addKeyIntoMapValue(_pontoscoleta);
    notifyListeners();
  }

  Future<void> alterar(String key, Map<String, String> pontoColeta) async {
    await dbRef.child(key).update(pontoColeta);
    _pontoscoleta[key] = pontoColeta;
    _pontoscoleta = Utils.addKeyIntoMapValue(_pontoscoleta);
    notifyListeners();
  }

  Future<void> remover(String key) async {
    await dbRef.child(key).remove();
    _pontoscoleta.remove(key);

    notifyListeners();
  }

  PontoColetaRepository() {
    initRepository();
  }

  initRepository() async {
    _dbRef = FirebaseDatabase.instance.ref().child('PontoColeta');
    await loadData();
  }

  loadData() async {
    DataSnapshot snapshot = await dbRef.get();
    _pontoscoleta = Map<String, dynamic>.from(snapshot.value as Map);
    _pontoscoleta = Utils.addKeyIntoMapValue(_pontoscoleta);
    _pontoscoletaList = _pontoscoleta.values.toList();
    notifyListeners();
  }
}
