import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navigationrail2/pages/entidade_data.dart';
import 'package:provider/provider.dart';

import '../controllers/theme_controller.dart';
import '../repository/entidade_repository.dart';

class EntidadesPage extends StatefulWidget {
  @override
  State<EntidadesPage> createState() => _EntidadesPageState();
}

class _EntidadesPageState extends State<EntidadesPage> {
  late EntidadeRepository entidadeRepository;
  var controller = ThemeController.to;
  List _allresults = [];
  List _resultList = [];
  final TextEditingController _searchController = TextEditingController();
  late bool filter = false;

  @override
  void initState() {
    _searchController.addListener(_onSearchChange);
    super.initState();
  }

  _onSearchChange() {
    print(_searchController.text);
    searchResultList();
  }

  searchResultList() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var clientSnapShot in _allresults) {
        //nome fantasia
        var nomeFantasia =
            clientSnapShot['nomeFantasia'].toString().toLowerCase();
        var endereco = clientSnapShot['endereco'].toString().toLowerCase();
        var entidade = clientSnapShot['entidade'].toString().toLowerCase();
        if (nomeFantasia.contains(_searchController.text.toLowerCase()) ||
            endereco.contains(_searchController.text.toLowerCase()) ||
            entidade.contains(_searchController.text.toLowerCase())) {
          showResults.add(clientSnapShot);
        }
      }
    } else {
      showResults = List.from(_allresults);
    }

    setState(() {
      _resultList = showResults;
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChange);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    entidadeRepository = Provider.of<EntidadeRepository>(context);
    getClientStream();
    super.didChangeDependencies();
  }

  getClientStream() async {
    setState(() {
      _allresults = entidadeRepository.entidades.values.toList();
    });
    searchResultList();
  }

/*
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    switch (index) {
      case 2:
        Get.to(() => PontoColetaData(isInserting: true, isBrowse: false));
        break;
      default:
    }

    setState(() {
      _selectedIndex = index;
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: Menu(),
      appBar: filter == false
          ? AppBar(
              //backgroundColor: Colors.green[200],
              title: Center(child: Text('    Entidades')),
              actions: [
                getFilterIcon(),
                IconButton(
                  onPressed: () {
                    Get.to(
                      () => EntidadeData(isInserting: true, isBrowse: false),
                    );
                  },
                  icon: Icon(Icons.add),
                )
              ],
            )
          : AppBar(
              toolbarHeight: 80, //widget.preferredSize.height,
              title: Column(
                children: [
                  const Text("  Pontos de coleta"),
                  SizedBox(
                    height: 8.0,
                  ),
                  CupertinoSearchTextField(
                    backgroundColor: Colors.white70,
                    placeholder: "Pesquisar",
                    controller: _searchController,
                  )
                ],
              ),
              actions: [
                getFilterIcon(),
              ],
            ),

      // sempre usar o consumer perto da classe que irá usar
      body: ListView.separated(
        itemCount: _resultList.length,
        itemBuilder: (context, i) {
          final List tabela = _resultList;
          return ListTile(
            /*leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tabela[i]['entidade']),
              ],
            ),*/
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tabela[i]['nomeFantasia']),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tabela[i]['endereco']),
              ],
            ),
            trailing: Wrap(
              spacing: -16,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Get.to(
                      () => EntidadeData(
                          isInserting: false,
                          isBrowse: false,
                          entidadeKey: tabela[i]['key']),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    entidadeRepository.remover(tabela[i]['key']);
                    //Get.back();
                  },
                ),
              ],
            ),
            onTap: () {
              Get.to(
                () => EntidadeData(
                    isInserting: false,
                    isBrowse: true,
                    entidadeKey: tabela[i]['key']),
              );
            },
          );
        },
        separatorBuilder: (_, __) => Divider(),
        padding: EdgeInsets.all(10),
      ),
    );
  }

  IconButton getFilterIcon() {
    return IconButton(
        onPressed: () {
          setState(() {
            filter = !filter;
          });
        },
        icon: Icon(Icons.search));
  }
}
