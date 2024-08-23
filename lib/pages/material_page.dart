import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navigationrail2/pages/material_data.dart';
import 'package:provider/provider.dart';

import '../controllers/theme_controller.dart';
import '../repository/material_repository.dart';

class MateriallPage extends StatefulWidget {
  @override
  State<MateriallPage> createState() => _MateriallPageState();
}

class _MateriallPageState extends State<MateriallPage> {
  late MaterialRepository materialRepository;
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
        var nome = clientSnapShot['nome'].toString().toLowerCase();
        //var endereco = clientSnapShot['endereco'].toString().toLowerCase();
        //var entidade = clientSnapShot['entidade'].toString().toLowerCase();
        if (nome.contains(_searchController.text.toLowerCase())) {
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
    materialRepository = Provider.of<MaterialRepository>(context);
    getClientStream();
    super.didChangeDependencies();
  }

  getClientStream() async {
    setState(() {
      _allresults = materialRepository.materiais.values.toList();
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
              title: Center(child: Text('    Materiais')),
              actions: [
                getFilterIcon(),
                IconButton(
                  onPressed: () {
                    Get.to(
                      () => MaterialData(isInserting: true, isBrowse: false),
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
                Text(tabela[i]['nome']),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ativo: ' + tabela[i]['ativo']),
              ],
            ),
            trailing: Wrap(
              spacing: -16,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Get.to(
                      () => MaterialData(
                          isInserting: false,
                          isBrowse: false,
                          materialKey: tabela[i]['key']),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    materialRepository.remover(tabela[i]['key']);
                    //Get.back();
                  },
                ),
              ],
            ),
            onTap: () {
              Get.to(
                () => MaterialData(
                    isInserting: false,
                    isBrowse: true,
                    materialKey: tabela[i]['key']),
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
