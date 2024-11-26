import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditVagaScreen extends StatefulWidget {
  final String vagaId;
  final Map<String, dynamic> vagaData;

  const EditVagaScreen({required this.vagaId, required this.vagaData, Key? key}) : super(key: key);

  @override
  State<EditVagaScreen> createState() => _EditVagaScreenState();
}

class _EditVagaScreenState extends State<EditVagaScreen> {
  late TextEditingController empresaController;
  late TextEditingController telefoneController;
  late TextEditingController codigoController;
  late TextEditingController nomeController;
  late TextEditingController detalhesController;
  late TextEditingController salarioController;
  late TextEditingController tipoController;
  late TextEditingController beneficiosController;

  @override
  void initState() {
    super.initState();
    empresaController = TextEditingController(text: widget.vagaData['empresa']);
    telefoneController = TextEditingController(text: widget.vagaData['telefone']);
    codigoController = TextEditingController(text: widget.vagaData['codigo']);
    nomeController = TextEditingController(text: widget.vagaData['nome']);
    detalhesController = TextEditingController(text: widget.vagaData['detalhes']);
    salarioController = TextEditingController(text: widget.vagaData['salario']);
    tipoController = TextEditingController(text: widget.vagaData['tipo']);
    beneficiosController = TextEditingController(text: widget.vagaData['beneficios']);
  }

  @override
  void dispose() {
    empresaController.dispose();
    telefoneController.dispose();
    codigoController.dispose();
    nomeController.dispose();
    detalhesController.dispose();
    salarioController.dispose();
    tipoController.dispose();
    beneficiosController.dispose();
    super.dispose();
  }

  void _atualizarVaga() async {
    try {
      await FirebaseFirestore.instance.collection('vagas').doc(widget.vagaId).update({
        'empresa': empresaController.text,
        'telefone': telefoneController.text,
        'codigo': codigoController.text,
        'nome': nomeController.text,
        'detalhes': detalhesController.text,
        'salario': salarioController.text,
        'tipo': tipoController.text,
        'beneficios': beneficiosController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vaga atualizada com sucesso!")),
      );

      Navigator.pop(context); // Volta para a tela anterior
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao atualizar vaga: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Vaga"),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: empresaController,
              decoration: const InputDecoration(labelText: "Empresa"),
            ),
            TextField(
              controller: telefoneController,
              decoration: const InputDecoration(labelText: "Telefone"),
            ),
            TextField(
              controller: codigoController,
              decoration: const InputDecoration(labelText: "Código da Vaga"),
            ),
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: "Nome da Vaga"),
            ),
            TextField(
              controller: detalhesController,
              decoration: const InputDecoration(labelText: "Detalhes da Vaga"),
            ),
            TextField(
              controller: salarioController,
              decoration: const InputDecoration(labelText: "Salário"),
            ),
            TextField(
              controller: tipoController,
              decoration: const InputDecoration(labelText: "Tipo da Vaga"),
            ),
            TextField(
              controller: beneficiosController,
              decoration: const InputDecoration(labelText: "Benefícios"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _atualizarVaga,
              child: const Text("Salvar Alterações"),
            ),
          ],
        ),
      ),
    );
  }
}
