import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'EditVagaScreen.dart';

class listaVagas extends StatelessWidget {
  final String parametro;
  const listaVagas(this.parametro, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Vagas"),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/background_vagas.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                'lib/images/edit_vagas.png',
                width: 300,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('vagas').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text("Erro ao carregar vagas"));
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text(
                          "Nenhuma vaga disponível",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return ListView(
                      children: snapshot.data!.docs.map((vaga) {
                        return Card(
                          color: Colors.white.withOpacity(0.9),
                          child: ListTile(
                            title: Text(
                              vaga['nome'],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Salário R\$: ${vaga['salario']}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditVagaScreen(vagaId: vaga.id, vagaData: vaga.data() as Map<String, dynamic>),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    bool? confirmDelete = await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("Confirmação"),
                                        content: const Text("Deseja realmente excluir esta vaga?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(false),
                                            child: const Text("Cancelar"),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(true),
                                            child: const Text("Excluir"),
                                          ),
                                        ],
                                      ),
                                    );

                                    if (confirmDelete ?? false) {
                                      await FirebaseFirestore.instance
                                          .collection('vagas')
                                          .doc(vaga.id)
                                          .delete()
                                          .catchError((error) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("Erro ao excluir a vaga."),
                                          ),
                                        );
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),

                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
