import 'package:esport_cliente/pages/crud/integrante_add.dart';
import 'package:esport_cliente/pages/crud/integrante_edit.dart';
import 'package:esport_cliente/pages/crud/juego_add.dart';
import 'package:esport_cliente/pages/crud/juego_edit.dart';
import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';

class EquipoEdit extends StatefulWidget {
  final int equipoId;
  final String nombre;

  const EquipoEdit({super.key, required this.equipoId, required this.nombre});

  @override
  State<EquipoEdit> createState() => _EquipoEditState();
}

class _EquipoEditState extends State<EquipoEdit> {
  late Future<List<dynamic>> _futureParticipantes;
  late Future<List<dynamic>> _futureJuegos;

  @override
  void initState() {
    super.initState();
    _futureParticipantes = HttpService().listarParticipantes(widget.equipoId);
    _actualizarIntegrantes();
    _futureJuegos = HttpService().listarJuegos(widget.equipoId);
  }

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
                  child: Text(widget.nombre),
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
                    future: _futureParticipantes,
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
                                ...participantes
                                        ?.map((participante) => Column(
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                    participante['nombre'] ??
                                                        'Nombre del Participante',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  subtitle: Text(
                                                    participante['pais'] ??
                                                        'País',
                                                    style: const TextStyle(
                                                        color: Colors.white70),
                                                  ),
                                                  trailing: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(
                                                            Icons.edit),
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          IntegranteEdit(
                                                                            integranteId:
                                                                                participante['id'],
                                                                            nombre:
                                                                                participante['nombre'],
                                                                            pais:
                                                                                participante['pais'],
                                                                            onUpdate:
                                                                                _actualizarIntegrantes,
                                                                          )));
                                                        },
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(
                                                            Icons.delete),
                                                        onPressed: () async {
                                                          try {
                                                            await HttpService()
                                                                .eliminarParticipante(
                                                                    participante[
                                                                        'id']);
                                                            // Manejar la eliminación exitosa
                                                          } catch (e) {
                                                            // Manejar errores
                                                          }
                                                          _actualizarIntegrantes();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                              ],
                                            ))
                                        .toList() ??
                                    [],
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  IntegranteAdd(
                                                      onUpdate:
                                                          _actualizarIntegrantes,
                                                      equipoId:
                                                          widget.equipoId)));
                                    },
                                    child: const Text("Agregar Integrante"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  FutureBuilder<List<dynamic>>(
                    future: _futureJuegos,
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
                                ...juegos
                                        ?.map((juego) => Column(
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                    juego['nombre'] ??
                                                        'Nombre del Juego',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  subtitle: Text(
                                                    juego['categoria'] ??
                                                        'Categoría',
                                                    style: const TextStyle(
                                                        color: Colors.white70),
                                                  ),
                                                  trailing: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(
                                                            Icons.edit),
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          JuegoEdit(
                                                                            nombre:
                                                                                juego['nombre'],
                                                                            cat:
                                                                                juego['categoria'],
                                                                            onUpdate:
                                                                                _actualizarJuegos,
                                                                            juegoId:
                                                                                juego['id'],
                                                                          )));
                                                        },
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(
                                                            Icons.delete),
                                                        onPressed: () async {
                                                          try {
                                                            await HttpService()
                                                                .eliminarJuego(
                                                                    juego[
                                                                        'id']);
                                                            // Manejar la eliminación exitosa
                                                          } catch (e) {
                                                            // Manejar errores
                                                          }
                                                          _actualizarJuegos;
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                              ],
                                            ))
                                        .toList() ??
                                    [],
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => JuegoAdd(
                                                    onUpdate: _actualizarJuegos,
                                                    equipoId: widget.equipoId,
                                                  )));
                                    },
                                    child: const Text("Agregar Juego"),
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
        ));
  }

  Future<void> _actualizarIntegrantes() async {
    setState(() {
      _futureParticipantes = HttpService().listarParticipantes(widget.equipoId);
    });
  }

  Future<void> _actualizarJuegos() async {
    setState(() {
      _futureJuegos = HttpService().listarJuegos(widget.equipoId);
    });
  }
}
