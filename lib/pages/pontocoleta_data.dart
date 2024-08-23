import 'package:flutter/material.dart';
import 'package:navigationrail2/repository/entidade_repository.dart';
import 'package:navigationrail2/repository/ponto_coleta_repository.dart';
import 'package:provider/provider.dart';

import '../repository/material_repository.dart';
import '../utils/utils.dart';

// ignore: must_be_immutable
class PontoColetaData extends StatefulWidget {
  final bool isInserting;
  final bool isBrowse;
  late String? pontoColetaKey;

  PontoColetaData(
      {Key? key,
      required this.isInserting,
      this.pontoColetaKey,
      required this.isBrowse})
      : super(key: key);

  @override
  State<PontoColetaData> createState() => _PontoColetaDataState();
}

class _PontoColetaDataState extends State<PontoColetaData> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final enderecoController = TextEditingController();
  final bairroController = TextEditingController();
  final logotipoController = TextEditingController();
  final dataAlteracaoController = TextEditingController();
  final dataInclusaoController = TextEditingController();
  final ativoController = TextEditingController();
  final materialController = TextEditingController();

  String selectedValue = "0";
  String selectedMaterialValue = "0";
  List entidadesItemList = [];
  List materiaisItemList = [];
  Map entidades = EntidadeRepository.getEntidadesMock();
  bool isAtivo = false;

  late MaterialRepository materialRepository;
  late EntidadeRepository entidadeRepository;
  late PontoColetaRepository pontoColetaRepository;

  salvar() {
    Map<String, String> pontoColeta = {
      'nome': nomeController.text,
      'endereco': enderecoController.text,
      'entidade': entidadeRepository.getNomeEntidadeByKey(selectedValue),
      'bairro': bairroController.text,
      'entidade2': selectedValue,
      'dataalteracao': Utils.getDateTime(),
      'logotipo': logotipoController.text,
      'datainclusao': dataInclusaoController.text,
      'ativo': ativoController.text,
      'material':
          materialRepository.getNomeMaterialByKey(selectedMaterialValue),
      'material2': selectedMaterialValue,
    };

    if (widget.isInserting) {
      pontoColetaRepository.inserir(pontoColeta);
    } else {
      pontoColetaRepository.alterar(
          widget.pontoColetaKey as String, pontoColeta);
    }
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ponto de coleta salvo com sucesso!')),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    materialRepository = Provider.of<MaterialRepository>(context);
    entidadeRepository = Provider.of<EntidadeRepository>(context);
    pontoColetaRepository = Provider.of<PontoColetaRepository>(context);
    if (!widget.isInserting) {
      getPontoColetaData();
    } else {
      dataInclusaoController.text = Utils.getDateTime();
    }
    super.didChangeDependencies();
  }

  void getPontoColetaData() async {
    Map pontoColeta = pontoColetaRepository
        .getPontoColetaByKey(widget.pontoColetaKey as String);

    nomeController.text = pontoColeta['nome'];
    enderecoController.text = pontoColeta['endereco'];
    bairroController.text = pontoColeta['bairro'] ?? '';
    dataAlteracaoController.text = pontoColeta['dataalteracao'] ?? '';
    logotipoController.text = pontoColeta['logotipo'] ?? '';
    dataInclusaoController.text = pontoColeta['datainclusao'] ?? '';
    ativoController.text = pontoColeta['ativo'];
    isAtivo = ativoController.text == 'Sim';
    materialController.text = pontoColeta['material'] ?? '';

    if (!widget.isInserting) {
      selectedValue = pontoColeta['entidade2'];
      selectedMaterialValue = pontoColeta['material2'];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    String titulo = '';
    if (widget.isBrowse) {
      titulo = 'Consulta ponto coleta';
    } else {
      if (widget.isInserting) {
        titulo = 'Inserir ponto coleta';
      } else {
        titulo = 'Alterar ponto coleta';
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
                    labelText: 'Nome',
                  ),
                  //keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o nome do ponto de coleta!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: TextFormField(
                  readOnly: widget.isBrowse,
                  controller: enderecoController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Endereço',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o endereço do ponto de coleta!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: TextFormField(
                  readOnly: widget.isBrowse,
                  controller: bairroController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Bairro',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o bairro do ponto de coleta!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: AbsorbPointer(
                  absorbing: widget.isBrowse,
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Entidade',
                    ),
                    value: selectedValue,
                    items: entidadeRepository.entidadesItemList.map((entidade) {
                      return DropdownMenuItem(
                        value: entidade['id'],
                        child: Text(entidade['label']),
                      );
                    }).toList(),
                    onChanged: (v) {
                      selectedValue = v as String;
                      setState(() {});
                    },
                  ),
                ),
              ),
              // materiais quyron
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: AbsorbPointer(
                  absorbing: widget.isBrowse,
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Material',
                    ),
                    value: selectedMaterialValue,
                    items: materialRepository.materiaisItemList.map((material) {
                      return DropdownMenuItem(
                        value: material['id'],
                        child: Text(material['label']),
                      );
                    }).toList(),
                    onChanged: (v) {
                      selectedMaterialValue = v as String;
                      //materialController.text = selectedMaterialValue;
                      setState(() {});
                    },
                  ),
                ),
              ),
              /* ajuste materiais quyron             
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: TextFormField(
                  readOnly: widget.isBrowse,
                  controller: materialController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Material',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o material!';
                    }
                    return null;
                  },
                ),
              ),
              */ // fim de ajuste de materiais quyron
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: TextFormField(
                  readOnly: widget.isBrowse,
                  controller: logotipoController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'URL do Logotipo (opcional)',
                  ),
                  validator: (value) {
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
                  controller: dataInclusaoController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Data inclusão',
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
