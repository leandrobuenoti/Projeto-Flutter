import 'package:flutter/material.dart';

class Inputs extends StatelessWidget {
  final String rotulo;
  final String label;
  final TextEditingController controller;

  const Inputs(this.rotulo, this.label, {super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        //labelText: "", // Rótulo em branco
        hintText: label,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        filled: true, // Ativa o preenchimento do fundo
        fillColor: Colors.white, // Define o fundo branco
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0), // Deixa o retângulo com bordas retas
          borderSide: BorderSide.none, // Remove a borda
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0), // Ajusta o padding para garantir espaço suficiente
        //floatingLabelBehavior: FloatingLabelBehavior.auto, // Faz o label subir apenas quando o campo for focado
      ),
    );
  }
}