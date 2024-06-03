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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          // title: Text('Formula 1'),
          title: Column(
            children: [
              Container(
                color: Colors.deepPurple,
                height: 40,
                child: Image.asset(
                  'assets/images/esportsapp_text.png',
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                color: Colors.deepPurple,
                height: 30,
                child: Text(nombre),
              )
            ],
          ),
          bottom: const TabBar(
            labelColor: Color.fromARGB(255, 255, 255, 255),
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.videogame_asset), text: 'Reglas'),
              Tab(icon: Icon(Icons.people), text: 'Premios'),
              Tab(
                text: "integrantes",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [Text(reglas), Text(premios), const Text("integrantes")],
        ),
      ),
    );
  }
}
