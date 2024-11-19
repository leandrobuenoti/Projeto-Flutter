import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VagasPage extends StatelessWidget {
  const VagasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vagas Disponíveis"),
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
                'lib/images/ha_vagas.png',
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

                    // Lista as vagas
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
                            onTap: () {
                              // Abre os detalhes da vaga
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetalhesVagaPage(
                                    vaga: vaga,
                                  ),
                                ),
                              );
                            },
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

class DetalhesVagaPage extends StatelessWidget {
  final QueryDocumentSnapshot vaga;

  const DetalhesVagaPage({super.key, required this.vaga});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vaga['nome']),
        backgroundColor: Colors.indigo,
      ),
      body: Stack(
        children: [
          // Imagem de fundo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/background_vagas.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Detalhes da vaga
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Detalhes da Vaga:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amber)),
                const SizedBox(height: 10),
                Text("Código: ${vaga['codigo']}", style: const TextStyle(fontSize: 16, color: Colors.white)),
                Text("Função: ${vaga['nome']}", style: const TextStyle(fontSize: 20, color: Colors.amber)),
                Text("Salário: R\$ ${vaga['salario']}", style: const TextStyle(fontSize: 18, color: Colors.amber)),
                Text("Tipo: ${vaga['tipo']}", style: const TextStyle(fontSize: 16, color: Colors.white)),
                Text("Benefícios: ${vaga['beneficios']}", style: const TextStyle(fontSize: 16, color: Colors.white)),
                const SizedBox(height: 20),
                const Text("Descrição:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amber)),
                Text(vaga['detalhes'], style: const TextStyle(fontSize: 16, color: Colors.white)),
                const SizedBox(height: 20),
                Text("Contato:", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amber)),
                Text("Empresa: ${vaga['empresa']}", style: const TextStyle(fontSize: 18, color: Colors.white)),
                Text("Contato: ${vaga['telefone']}", style: const TextStyle(fontSize: 16, color: Colors.white)),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  child: const Text("Voltar"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
