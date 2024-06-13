import 'package:esport_cliente/pages/crud/agregar_campeonato.dart';
import 'package:esport_cliente/services/http_service.dart';
import 'package:esport_cliente/widgets/campeonato_edit_tile.dart';
import 'package:flutter/material.dart';

class CampeonatosEditTab extends StatefulWidget {
  const CampeonatosEditTab({super.key});

  @override
  State<CampeonatosEditTab> createState() => _CampeonatosEditTabState();
}

class _CampeonatosEditTabState extends State<CampeonatosEditTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: HttpService().campeonatos(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData ||
                        snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.black),
                      ));
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AgregarCampeonato()));
          },
          child: Icon(Icons.add),
        ));
  }
}
