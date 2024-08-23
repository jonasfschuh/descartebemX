import 'package:flutter/material.dart';
import 'package:navigationrail2/repository/material_repository.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

// ignore: must_be_immutable
class MaterialData extends StatefulWidget {
  final bool isInserting;
  final bool isBrowse;
  late String? materialKey;

  MaterialData(
      {Key? key,
      required this.isInserting,
      this.materialKey,
      required this.isBrowse})
      : super(key: key);

  @override
  State<MaterialData> createState() => _MaterialDataState();
}

class _MaterialDataState extends State<MaterialData> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final ativoController = TextEditingController();
  final dataAlteracaoController = TextEditingController();
  final dataAtivacaoController = TextEditingController();
  final usuarioAtivadorController = TextEditingController();

  String selectedValue = "0";
  List entidadesItemList = [];
  Map entidades = MaterialRepository.getMaterialMock();
  bool isAtivo = false;

  late MaterialRepository materialRepository;

  salvar() {
    if (ativoController.text == '') {
      ativoController.text = 'Não';
    }

    Map<String, String> material = {
      'nome': nomeController.text,
      'ativo': ativoController.text,
      'dataAlteracao': Utils.getDateTime(),
      'dataAtivacao': dataAtivacaoController.text,
      'usuarioAtivador': usuarioAtivadorController.text
    };

    if (widget.isInserting) {
      materialRepository.inserir(material);
    } else {
      materialRepository.alterar(widget.materialKey as String, material);
    }
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Material salvo com sucesso!')),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    materialRepository = Provider.of<MaterialRepository>(context);
    if (!widget.isInserting) {
      getMaterialData();
    } else {
      dataAtivacaoController.text = Utils.getDateTime();
    }
    super.didChangeDependencies();
  }

  void getMaterialData() async {
    Map material =
        materialRepository.getMaterialByKey(widget.materialKey as String);

    nomeController.text = material['nome'];
    ativoController.text = material['ativo'] ?? 'Não';
    if (ativoController.text == '') {
      ativoController.text = 'Não';
    }
    isAtivo = ativoController.text == 'Sim';
    ativoController.text = isAtivo ? 'Sim' : 'Não';
    dataAlteracaoController.text = material['dataAlteracao'] ?? '';
    dataAtivacaoController.text = material['dataAtivacao'] ?? '';
    usuarioAtivadorController.text = 'sysadmin';

    if (!widget.isInserting) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    String titulo = '';
    if (widget.isBrowse) {
      titulo = 'Consulta material';
    } else {
      if (widget.isInserting) {
        titulo = 'Inserir material';
      } else {
        titulo = 'Alterar material';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        actions: [
          if (!widget.isBrowse)
            IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  salvar();
                }
              },
              icon: Icon(Icons.done),
            )
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(24),
                child: TextFormField(
                  //enabled: !widget.isBrowse,
                  readOnly: widget.isBrowse,
                  controller: nomeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome Material',
                  ),
                  //keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o nome do material!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: Center(
                  child: TextFormField(
                    readOnly: widget.isBrowse,
                    controller: ativoController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ativo',
                      prefixIcon: Checkbox(
                          value: isAtivo,
                          onChanged: (value) {
                            setState(() {
                              isAtivo = value!;
                              ativoController.text = isAtivo ? 'Sim' : 'Não';
                            });
                          }),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: TextFormField(
                  enabled: false,
                  controller: dataAlteracaoController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Data alteracao',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: TextFormField(
                  enabled: false,
                  controller: dataAtivacaoController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Data inclusão',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: TextFormField(
                  enabled: false,
                  controller: usuarioAtivadorController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Usuário Ativador',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
