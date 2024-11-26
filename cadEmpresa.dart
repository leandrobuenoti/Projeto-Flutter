import 'package:flutter/material.dart';
class cadEmpresa extends StatefulWidget {
String parametro;
cadEmpresa(this.parametro, {super.key});
  @override
  State<cadEmpresa> createState() => _cadEmpresaState();
}

class _cadEmpresaState extends State<cadEmpresa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.parametro),
        backgroundColor: Colors.deepOrangeAccent,
      ),
    );
  }
}

