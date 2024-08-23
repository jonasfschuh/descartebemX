import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navigationrail2/pages/material_page.dart';

import '../pages/entidades_page.dart';
import '../pages/sobre_page.dart';
import '../services/auth_service.dart';

class Menu extends StatelessWidget {
  const Menu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String? emailLogado = AuthService.to.usuarioEmail;
    String? usuarioLogado = AuthService.to.usuarioDisplayName;

    return Builder(
      builder: (context) {
        return Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.green[800],
                  ),
                  currentAccountPicture: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset('lib/assets/images/usuario.jpg'),
                  ),
                  accountName: Text(usuarioLogado),
                  accountEmail: Text(emailLogado),
                ),
                ListTile(
                  leading: Icon(Icons.store),
                  title: Text('Entidades'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.to(() => EntidadesPage());
                  },
                ),
                ListTile(
                  leading: Icon(Icons.store),
                  title: Text('Materiais'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.to(() => MateriallPage());
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Sobre'),
                  onTap: () {
                    Navigator.pop(context);
                    Get.to(() => SobrePage());
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    Navigator.pop(context);
                    AuthService.to.logout();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
