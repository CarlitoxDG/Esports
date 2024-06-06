import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';

class DetallesEquipo extends StatelessWidget {
  final int equipoId;
  final String nombre;
  const DetallesEquipo({super.key, required this.nombre, required this.equipoId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
              Tab(icon: Icon(Icons.diversity_3), text: 'Integrantes'),
              Tab(icon: Icon(Icons.videogame_asset), text: "Juegos"),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/fondoequipo1.jpg'), 
                  fit: BoxFit.cover,
                ),
              ),
            ),
            TabBarView(
              children: [
                FutureBuilder<List<dynamic>>(
                  future: HttpService().listarParticipantes(equipoId),
                  builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepPurple,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      List? participantes = snapshot.data;
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          color: Colors.deepPurple.withOpacity(0.8), 
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Integrantes del equipo',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10), // Espacio adicional
                              ...participantes?.map((participante) => Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          participante['nombre'] ?? 'Nombre del Participante',
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                        subtitle: Text(
                                          participante['pais'] ?? 'País',
                                          style: const TextStyle(color: Colors.white70),
                                        ),
                                      ),
                                      const SizedBox(height: 10), 
                                    ],
                                  )).toList() ?? [],
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
                FutureBuilder<List<dynamic>>(
                  future: HttpService().listarJuegos(equipoId),
                  builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepPurple,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      List? juegos = snapshot.data;
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          color: Colors.deepPurple.withOpacity(0.8), 
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Juegos del equipo',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10), 
                              ...juegos?.map((juego) => Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          juego['nombre'] ?? 'Nombre del Juego',
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                        subtitle: Text(
                                          juego['categoria'] ?? 'Categoría',
                                          style: const TextStyle(color: Colors.white70),
                                        ),
                                      ),
                                      const SizedBox(height: 10), 
                                    ],
                                  )).toList() ?? [],
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

