import 'package:flutter/material.dart';

class Textos extends StatelessWidget {
  final String s;
  final Color cor;
  final double tamanhoFonte; // Novo parâmetro para o tamanho da fonte

  const Textos(this.s, this.cor, this.tamanhoFonte, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      s,
      style: TextStyle(
        color: cor,
        fontSize: tamanhoFonte, // Usa o tamanho da fonte passado
      ),
    );
  }
}