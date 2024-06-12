//import 'package:esport_cliente/pages/crud/partido_add.dart';
import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';

class DetalleCampeonato extends StatelessWidget {
  final int idCampeonato;
  final String nombre;
  final String reglas;
  final String premios;
  const DetalleCampeonato(
      {super.key,
      required this.nombre,
      required this.reglas,
      required this.premios,
      required this.idCampeonato});

  List<Widget> _buildList(String content) {
    List<String> items = content.split('\\n');
    return items
        .map((item) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.trim(),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),
              ],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
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
              Tab(icon: Icon(Icons.fact_check), text: 'Reglas'),
              Tab(icon: Icon(Icons.emoji_events), text: 'Premios'),
              Tab(
                icon: Icon(Icons.groups),
                text: "Integrantes",
              ),
              Tab(icon: Icon(Icons.sports), text: 'Partidos'),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/fondo_detcampeonato.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            TabBarView(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.deepPurple.withOpacity(0.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Reglas del campeonato',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        ..._buildList(reglas),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.deepPurple.withOpacity(0.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Premios del campeonato',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        ..._buildList(premios),
                      ],
                    ),
                  ),
                ),
                FutureBuilder<List<dynamic>>(
                  future: HttpService().equiposEnCampeonato(idCampeonato),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepPurple,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      List<dynamic>? equipos = snapshot.data;
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          color: Colors.deepPurple.withOpacity(0.8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Integrantes del campeonato',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              ...equipos
                                      ?.map((equipo) => Column(
                                            children: [
                                              ListTile(
                                                title: Text(
                                                  equipo['nombre'] ??
                                                      'Nombre del Equipo',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                leading: Image.asset(
                                                  'assets/images/Equipos/${equipo['nombre']}.png',
                                                  height: 40,
                                                  width: 40,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                            ],
                                          ))
                                      .toList() ??
                                  [],
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
                FutureBuilder<List<dynamic>>(
                  future: HttpService().partidosPorCampeonato(idCampeonato),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepPurple,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      List<dynamic>? equipos = snapshot.data;
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          color: Colors.deepPurple.withOpacity(0.8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Partidos del campeonato',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              ...equipos
                                      ?.map((partido) => Column(
                                            children: [
                                              ListTile(
                                                title: Text(
                                                  "${partido['equipo1_nombre']} vs ${partido['equipo2_nombre']}",
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                subtitle: Text(partido['fecha']
                                                    .toString()),
                                                leading: Text(
                                                    partido['resultado']
                                                        .toString()),
                                                trailing: Text(
                                                    "${partido['pais']}, ${partido['ciudad']}, ${partido['sede']}"),
                                              ),
                                              const SizedBox(height: 10),
                                            ],
                                          ))
                                      .toList() ??
                                  [],
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("Desafiar"),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
