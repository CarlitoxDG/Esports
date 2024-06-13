import 'package:esport_cliente/pages/crud/partido_add.dart';
import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';

class DetalleCampeonato extends StatefulWidget {
  final int idCampeonato;
  final String nombre;
  final String reglas;
  final String premios;

  const DetalleCampeonato({
    Key? key,
    required this.nombre,
    required this.reglas,
    required this.premios,
    required this.idCampeonato,
  }) : super(key: key);

  @override
  State<DetalleCampeonato> createState() => _DetalleCampeonatoState();
}

class _DetalleCampeonatoState extends State<DetalleCampeonato> {
  late Future<List<dynamic>> _futurePartidos;

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
  void initState() {
    super.initState();
    _actualizarPartidos();
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
                child: Text(widget.nombre),
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
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Reglas del campeonato',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ..._buildList(widget.reglas),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Premios del campeonato',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ..._buildList(widget.premios),
                      ],
                    ),
                  ),
                ),
                FutureBuilder<List<dynamic>>(
                  future: HttpService().equiposEnCampeonato(widget.idCampeonato),
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
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Integrantes del campeonato',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ...equipos
                                  ?.map((equipo) => Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                              equipo['nombre'] ??
                                                  'Nombre del Equipo',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
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
                  future: _futurePartidos,
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
                      List<dynamic>? partidos = snapshot.data;
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Partidos del campeonato',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ...partidos
                                  ?.map((partido) => Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${partido['equipo1_nombre']} vs ${partido['equipo2_nombre']}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              partido['fecha'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  partido['resultado'],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  " | ${partido['pais']}, ${partido['ciudad']}, ${partido['sede']}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList() ??
                                  [],
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PartidoCrear(
                                          campeonatoId: widget.idCampeonato,
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white, backgroundColor: Colors.red, 
                                  ),
                                  child: const Text("Desafiar"),
                                ),
                              ),
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

   Future<void> _actualizarPartidos() async {
    setState(() {
      _futurePartidos = HttpService().partidosPorCampeonato(widget.idCampeonato);
    });
  }
}
  
