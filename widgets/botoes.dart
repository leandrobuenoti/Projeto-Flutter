import 'package:flutter/material.dart';
class Botoes extends StatelessWidget {

  String texto;
  void Function() onPressed;
  Botoes(this.texto, {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Text(texto)
    );
  }
}