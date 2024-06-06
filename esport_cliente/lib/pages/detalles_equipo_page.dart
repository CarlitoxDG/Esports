// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';

class DetallesEquipo extends StatelessWidget {
  final int equipoId;
  final String nombre;
  const DetallesEquipo(
      {super.key, required this.nombre, required this.equipoId});

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
          children: [
            Expanded(
                child: FutureBuilder<List<dynamic>>(
                    future: HttpService().listarParticipantes(equipoId),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: Colors.deepPurple,
                        ));
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        List? participantes = snapshot.data;
                        return Scaffold(
                          body: ListView.builder(
                            itemCount: participantes?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(participantes?[index]['nombre']),
                                subtitle: Text(participantes?[index]['pais']),
                              );
                            },
                          ),
                        );
                      }
                    })),
            Expanded(
                child: FutureBuilder<List<dynamic>>(
                    future: HttpService().listarJuegos(equipoId),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: Colors.deepPurple,
                        ));
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        List? participantes = snapshot.data;
                        return Scaffold(
                          body: ListView.builder(
                            itemCount: participantes?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(participantes?[index]['nombre']),
                                subtitle:
                                    Text(participantes?[index]['categoria']),
                              );
                            },
                          ),
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
