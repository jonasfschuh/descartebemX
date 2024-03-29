import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navigationrail2/pages/autenticacao_page.dart';
import 'package:navigationrail2/pages/pontocoleta_data.dart';
import 'package:navigationrail2/widget/logotipo.dart';
import 'package:provider/provider.dart';

import '../controllers/theme_controller.dart';
import '../repository/ponto_coleta_repository.dart';
import '../services/auth_service.dart';
import '../utils/menu.dart';
import 'ponto_coleta_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PontoColetaRepository pontoColetaRepository;
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
        var nomeFantasia = clientSnapShot['nome'].toString().toLowerCase();
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
    pontoColetaRepository = Provider.of<PontoColetaRepository>(context);
    getClientStream();
    super.didChangeDependencies();
  }

  getClientStream() async {
    setState(() {
      _allresults = pontoColetaRepository.pontoscoleta.values.toList();
    });
    searchResultList();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: filter == false
          ? AppBar(
              //backgroundColor: Colors.green[200],
              title: Center(child: Text('    Descarte Bem')),
              actions: [getFilterIcon(), getPopupMenuButton()],
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
            leading: Logotipo(
                image: tabela[i]['logotipo'] ?? '',
                width: 60,
                chave: tabela[i]['key']),
            title: Text(tabela[i]['entidade'] + ' - ' + tabela[i]['nome']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tabela[i]['endereco']),
                Text(tabela[i]['material'] ?? ''),
              ],
            ),
            onTap: () {
              Get.to(
                () => PontoColetaPage(
                  key: Key(tabela[i]['key']),
                  chave: tabela[i]['key'],
                ),
              );
            },
          );
        },
        separatorBuilder: (_, __) => Divider(),
        padding: EdgeInsets.all(10),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_important),
            label: 'Notificações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Incluir',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[500],
        onTap: _onItemTapped,
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

  PopupMenuButton getPopupMenuButton() {
    return PopupMenuButton(
      offset: const Offset(0, 51),
      icon: Icon(Icons.more_vert),
      itemBuilder: (_) => [
        PopupMenuItem(
          child: ListTile(
            leading: Obx(() => controller.isDark.value
                ? Icon(Icons.brightness_7)
                : Icon(Icons.brightness_2)),
            title: Obx(
                () => controller.isDark.value ? Text('Light') : Text('Dark')),
            onTap: () {
              controller.changeTheme();
              Navigator.pop(context);
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Obx(() => AuthService.to.userIsAuthenticated.value
                ? Icon(Icons.logout)
                : Icon(Icons.login)),
            title: Obx(() => AuthService.to.userIsAuthenticated.value
                ? Text('Logout')
                : Text('Login')),
            onTap: () {
              if (AuthService.to.userIsAuthenticated.value) {
                Navigator.pop(context);
                AuthService.to.logout();
                Get.back();
              } else {
                Get.to(() => AutenticacaoPage());
              }
            },
          ),
        )
      ],
    );
  }
}
