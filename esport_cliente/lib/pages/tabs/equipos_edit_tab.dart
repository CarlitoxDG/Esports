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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: HttpService().equipos(),
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
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AgregarEquipo()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
