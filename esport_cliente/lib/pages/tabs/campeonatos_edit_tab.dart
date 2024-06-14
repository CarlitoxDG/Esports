import 'package:esport_cliente/pages/crud/agregar_campeonato.dart';
import 'package:flutter/material.dart';
import 'package:esport_cliente/pages/crud/campeonato_edit.dart';
import 'package:esport_cliente/services/http_service.dart';
import 'package:esport_cliente/widgets/campeonato_edit_tile.dart';

class CampeonatosEditTab extends StatefulWidget {
  const CampeonatosEditTab({Key? key}) : super(key: key);

  @override
  State<CampeonatosEditTab> createState() => _CampeonatosEditTabState();
}

class _CampeonatosEditTabState extends State<CampeonatosEditTab> {
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
                      return CampeonatoTileEdit(
                        id: campeonato['id'],
                        nombre: campeonato['nombre'],
                        fechaInicio: campeonato['fecha_inicio'],
                        fechaFin: campeonato['fecha_fin'],
                        reglas: campeonato['reglas'],
                        premios: campeonato['premios'],
                        onUpdate: _actualizarCampeonatos, // Pasar la función onUpdate
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
            MaterialPageRoute(builder: (context) => AgregarCampeonato(onUpdate: () {  },)),
          ).then((value) {
            if (value == true) {
              _actualizarCampeonatos();
            }
          });
        },
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          'Agregar Campeonato',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
