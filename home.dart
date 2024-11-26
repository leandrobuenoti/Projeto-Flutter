import 'package:empregaitape/widgets/textos.dart';
import 'package:flutter/material.dart';
import 'cadVagas.dart';
import 'vagas.dart';
import 'listaVagas.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emprega Itapê", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            onPressed: () {
              _abreTela(context, const cadVagas("Cadastro de Vagas"));
            },
            icon: const Icon(Icons.add_business_rounded, color: Colors.amber),
          ),
          IconButton(
            onPressed: () {
              _abreTela(context, const listaVagas("Lista de Vagas"));
            },
            icon: Icon(Icons.edit_document, color: Colors.amber),
          ),
        ],
      ),
      body: _body(context),
    );
  }

  void _abreTela(BuildContext ctx, Widget page) {
    Navigator.push(ctx, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  Widget _body(BuildContext context) {
    return Stack(
      children: [

        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        Column(
          children: [
            const Spacer(),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _abreTela(context, const VagasPage());
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text("Acessar Vagas"),
                  ),
                  const SizedBox(height: 40),
                  const Textos("Leandro Bueno", Colors.indigo, 12),
                  const Textos("ver 1.01", Colors.indigo, 10),
                ],
              ),
            ),
            const SizedBox(height: 150),
          ],
        ),

      ],
    );
  }
}