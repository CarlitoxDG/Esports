import 'package:esport_cliente/pages/crud/agregar_equipo.dart';
import 'package:esport_cliente/services/http_service.dart';
import 'package:esport_cliente/widgets/equipo_edit_tile.dart';
import 'package:flutter/material.dart';

class EquiposEditTab extends StatefulWidget {
  const EquiposEditTab({super.key});

  @override
  State<EquiposEditTab> createState() => _EquiposEditTabState();
}

class _EquiposEditTabState extends State<EquiposEditTab> {
  late Future<List<dynamic>> _futureEquipos;

  @override
  void initState() {
    super.initState();
    _futureEquipos = HttpService().equipos();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: _futureEquipos,
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
                      var equipo = snapshot.data[index];
                      return EquipoTileEdit(
                          equipoId: equipo['id'],
                          nombre: equipo['nombre'],
                          onUpdate: _actualizarEquipos);
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
                builder: (context) => AgregarEquipo(
                      onUpdate: _actualizarEquipos,
                    )));
          _actualizarEquipos();
        },
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          'Nuevo Equipo',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _actualizarEquipos() async {
    setState(() {
      _futureEquipos = HttpService().equipos();
    });
  }
}
