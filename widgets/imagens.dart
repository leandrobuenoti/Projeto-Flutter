import 'package:flutter/material.dart';
class SuaImagem extends StatefulWidget {
  final String caminhoArquivo;
  const SuaImagem({super.key, required this.caminhoArquivo});

  @override
  State<SuaImagem> createState() => _SuaImagemState();
}

class _SuaImagemState extends State<SuaImagem> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
        widget.caminhoArquivo,
        fit: BoxFit.cover,
        scale: 50,
    );
  }
}
