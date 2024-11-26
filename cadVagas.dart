import 'package:empregaitape/widgets/botoes.dart';
import 'package:empregaitape/widgets/input.dart';
import 'package:empregaitape/widgets/textos.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class cadVagas extends StatefulWidget {
  final String parametro;
  const cadVagas(this.parametro, {super.key});

  @override
  State<cadVagas> createState() => _cadVagasState();
}

class _cadVagasState extends State<cadVagas> {
  final codigoVaga = TextEditingController();
  final nomeVaga = TextEditingController();
  final detalhesVaga = TextEditingController();
  final salarioVaga = TextEditingController();
  final tipoVaga = TextEditingController();
  final beneficioVaga = TextEditingController();
  final empresaVaga = TextEditingController();
  final telefoneVaga = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.parametro),
        backgroundColor: Colors.indigo,
      ),
      body: _body(),
      resizeToAvoidBottomInset: true,
    );
  }

  _body() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/images/background_vagas.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Textos("Empresa", Colors.white, 16),
                Inputs("", "", controller: empresaVaga),
                const SizedBox(height: 10),

                const Textos("Telefone", Colors.white, 16),
                Inputs("", "(XX) XXXXX-XXXX", controller: telefoneVaga),
                const SizedBox(height: 10),

                const Textos("Código da Vaga", Colors.white, 16),
                Inputs("", "", controller: codigoVaga),
                const SizedBox(height: 10),

                const Textos("Função / Nome da vaga", Colors.white, 16),
                Inputs("", "", controller: nomeVaga),
                const SizedBox(height: 10),

                const Textos("Detalhes da Vaga", Colors.white, 16),
                Inputs("", "Faça uma breve descrição das atividades", controller: detalhesVaga),
                const SizedBox(height: 10),

                const Textos("Salário R\$", Colors.white, 16),
                Inputs("", "", controller: salarioVaga),
                const SizedBox(height: 10),

                const Textos("Tipo da Vaga", Colors.white, 16),
                Inputs("", "Ex.: Freelance, CLT, Temporário, etc...", controller: tipoVaga),
                const SizedBox(height: 10),

                const Textos("Benefícios", Colors.white, 16),
                Inputs("", "", controller: beneficioVaga),
                const SizedBox(height: 20),

                Botoes("Cadastrar", onPressed: _cadastrar),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _cadastrar() async {
    try {
      CollectionReference vagas = FirebaseFirestore.instance.collection('vagas');

      await vagas.add({
        'codigo': codigoVaga.text,
        'nome': nomeVaga.text,
        'detalhes': detalhesVaga.text,
        'salario': salarioVaga.text,
        'tipo': tipoVaga.text,
        'beneficios': beneficioVaga.text,
        'empresa': empresaVaga.text,
        'telefone': telefoneVaga.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vaga cadastrada com sucesso!")),
      );

      codigoVaga.clear();
      nomeVaga.clear();
      detalhesVaga.clear();
      salarioVaga.clear();
      tipoVaga.clear();
      beneficioVaga.clear();
      empresaVaga.clear();
      telefoneVaga.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao cadastrar vaga: $e")),
      );
    }
  }
}
