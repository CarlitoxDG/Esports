import 'package:flutter/material.dart';

class DetalleCampeonato extends StatelessWidget {
  final String nombre;
  final String reglas;
  final String premios;
  const DetalleCampeonato(
      {super.key,
      required this.nombre,
      required this.reglas,
      required this.premios});

  List<Widget> _buildList(String content) {
    List<String> items = content.split('\\n');
    return items
        .map((item) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.trim()),
                const SizedBox(height: 10), 
              ],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Column(
            children: [
              Container(
                color: Colors.deepPurple, height: 40,
                child: Image.asset('assets/images/esportsapp_text.png', fit: BoxFit.contain),
              ),
              Container(
                color: Colors.deepPurple, height: 30, child: Text(nombre),
              )
            ],
          ),
          bottom: const TabBar(
            labelColor: Color.fromARGB(255, 255, 255, 255),
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.rule), text: 'Reglas'),
              Tab(icon: Icon(Icons.monetization_on), text: 'Premios'),
              Tab(icon: Icon(Icons.people), text: "integrantes"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Lista ordenada para reglas
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Reglas del campeonato',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10), 
                  ..._buildList(reglas), 
                ],
              ),
            ),
            // Lista ordenada para premios
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Premios del campeonato',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10), 
                  ..._buildList(premios), 
                ],
              ),
            ),
            const Text("integrantes"),
          ],
        ),
      ),
    );
  }
}

