import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';

class DetallesEquipo extends StatelessWidget {
  final String nombre;
  const DetallesEquipo({super.key, required this.nombre});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
              Tab(icon: Icon(Icons.diversity_3), text: 'Integrantes'),
              Tab(
                icon: Icon(Icons.videogame_asset),
                text: "Juegos",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [Text('hola'), const Text("Juegos")],
        ),
      ),
    );
  }
}
