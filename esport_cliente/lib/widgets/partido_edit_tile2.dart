import 'package:esport_cliente/widgets/partido_edit_tile.dart';
import 'package:flutter/material.dart';
import 'package:esport_cliente/services/http_service.dart';
import 'package:esport_cliente/pages/crud/campeonato_add.dart';

class CampeonatoPartidoEdit extends StatefulWidget {
  const CampeonatoPartidoEdit({Key? key}) : super(key: key);

  @override
  State<CampeonatoPartidoEdit> createState() => _CampeonatoPartidoEditState();
}

class _CampeonatoPartidoEditState extends State<CampeonatoPartidoEdit> {
  late Future<List<dynamic>> _futureCampeonatos;

  @override
  void initState() {
    super.initState();
    _futureCampeonatos = HttpService().campeonatos();
  }

  Future<void> _actualizarCampeonatos() async {
    setState(() {
      _futureCampeonatos = HttpService().campeonatos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: _futureCampeonatos,
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.black),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var campeonato = snapshot.data[index];
                      return CampeonatoPartidoTileEdit(
                        id: campeonato['id'],
                        nombre: campeonato['nombre'],
                        fechaInicio: campeonato['fecha_inicio'],
                        fechaFin: campeonato['fecha_fin'],
                        reglas: campeonato['reglas'],
                        premios: campeonato['premios'],
                        onUpdate: _actualizarCampeonatos,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CampeonatoAdd(
                      onUpdate: _actualizarCampeonatos,
                    )),
          ).then((value) {
            if (value == true) {
              _actualizarCampeonatos();
            }
          });
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Agregar Partido',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
