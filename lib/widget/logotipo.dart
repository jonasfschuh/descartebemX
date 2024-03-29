// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Logotipo extends StatelessWidget {
  final String? image;
  final double width;
  final String chave;

  const Logotipo(
      {Key? key, required this.image, required this.width, required this.chave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: chave,
        child: image == null || image!.isEmpty
            ? Image.asset('lib/assets/images/pontocolegagenerico.jpg',
                fit: BoxFit.contain)
            : Image.network(
                image as String,
                fit: BoxFit.contain, //ficar contida dentro do box
              ),
      ),
    );
  }
}
