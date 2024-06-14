import 'package:flutter/material.dart';
import 'package:esport_cliente/pages/crud/partido_add.dart';
import 'package:esport_cliente/pages/crud/partido_edit.dart';
import 'package:esport_cliente/services/http_service.dart';

class CampeonatoTileEdit extends StatelessWidget {
  final int id;
  final String nombre;
  final String fechaInicio;
  final String fechaFin;
  final String reglas;
  final String premios;
  final Function onUpdate;

  const CampeonatoTileEdit({
    Key? key,
    required this.id,
    required this.nombre,
    required this.fechaInicio,
    required this.fechaFin,
    required this.reglas,
    required this.premios,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Text(nombre),
        subtitle: Text('Inicio: $fechaInicio - Fin: $fechaFin'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Reglas: $reglas'),
                Text('Premios: $premios'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PartidoAdd(
                          campeonatoId: id,
                          onUpdate: onUpdate,
                        ),
                      ),
                    );
                  },
                  child: const Text('Agregar Partido'),
                ),
                const SizedBox(height: 10),
                FutureBuilder(
                  future: HttpService().partidosPorCampeonato(id),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData ||
                        snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.data.isEmpty) {
                      return const Text('No hay partidos disponibles.');
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var partido = snapshot.data[index];
                        return ListTile(
                          title: Text(
                              '${partido['equipo1_nombre']} vs ${partido['equipo2_nombre']}'),
                          subtitle: Text('Fecha: ${partido['fecha']}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PartidoEdit(
                                    partidoId: partido['id'],
                                    fecha: partido['fecha'],
                                    pais: partido['pais'],
                                    ciudad: partido['ciudad'],
                                    sede: partido['sede'],
                                    resultado: partido['resultado'] ?? '',
                                    campeonatoId: id,
                                    equipo1Id: partido['equipo1_id'],
                                    equipo2Id: partido['equipo2_id'],
                                    onUpdate: onUpdate,
                                  ),
                                ),
                              ).then((value) {
                                if (value == true) {
                                  onUpdate();
                                }
                              });
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
