import 'package:flutter/material.dart';
import 'package:navigationrail2/repository/entidade_repository.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

// ignore: must_be_immutable
class EntidadeData extends StatefulWidget {
  final bool isInserting;
  final bool isBrowse;
  late String? entidadeKey;

  EntidadeData(
      {Key? key,
      required this.isInserting,
      this.entidadeKey,
      required this.isBrowse})
      : super(key: key);

  @override
  State<EntidadeData> createState() => _EntidadeDataState();
}

class _EntidadeDataState extends State<EntidadeData> {
  final _formKey = GlobalKey<FormState>();
  final nomeFantasiaController = TextEditingController();
  final enderecoController = TextEditingController();
  final cnpjController = TextEditingController();
  final dataAlteracaoController = TextEditingController();
  final dataAtivacaoController = TextEditingController();
  final telefoneController = TextEditingController();

  String selectedValue = "0";
  List entidadesItemList = [];
  Map entidades = EntidadeRepository.getEntidadesMock();
  bool isAtivo = false;

  late EntidadeRepository entidadeRepository;

  salvar() {
    Map<String, String> entidade = {
      'nomeFantasia': nomeFantasiaController.text,
      'endereco': enderecoController.text,
      'CNPJ': cnpjController.text,
      'entidade2': selectedValue,
      'dataAlteracao': Utils.getDateTime(),
      'dataAtivacao': dataAtivacaoController.text,
      'telefone': telefoneController.text
    };

    if (widget.isInserting) {
      entidadeRepository.inserir(entidade);
    } else {
      entidadeRepository.alterar(widget.entidadeKey as String, entidade);
    }
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Entidade salva com sucesso!')),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    entidadeRepository = Provider.of<EntidadeRepository>(context);
    if (!widget.isInserting) {
      getEntidadeData();
    } else {
      dataAtivacaoController.text = Utils.getDateTime();
    }
    super.didChangeDependencies();
  }

  void getEntidadeData() async {
    Map entidade =
        entidadeRepository.getEntidadeByKey(widget.entidadeKey as String);

    nomeFantasiaController.text = entidade['nomeFantasia'];
    enderecoController.text = entidade['endereco'];
    cnpjController.text = entidade['CNPJ'] ?? '';
    dataAlteracaoController.text = entidade['dataAlteracao'] ?? '';
    dataAtivacaoController.text = entidade['dataAtivacao'] ?? '';
    telefoneController.text = entidade['telefone'] ?? '';

    if (!widget.isInserting) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    String titulo = '';
    if (widget.isBrowse) {
      titulo = 'Consulta entidade';
    } else {
      if (widget.isInserting) {
        titulo = 'Inserir entidade';
      } else {
        titulo = 'Alterar entidade';
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
                  controller: nomeFantasiaController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome Fantasia',
                  ),
                  //keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o nome fantasia da entidade!';
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
                      return 'Informe o endereço da entidade!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: TextFormField(
                  readOnly: widget.isBrowse,
                  controller: cnpjController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CNPJ',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o CNPJ da entidade!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: TextFormField(
                  readOnly: widget.isBrowse,
                  controller: telefoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Telefone',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o telefone!';
                    }
                    return null;
                  },
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
            ],
          ),
        ),
      ),
    );
  }
}
