// ignore_for_file: prefer_const_constructors

import 'package:esport_cliente/pages/crud/agregar_campeonato.dart';
import 'package:esport_cliente/services/http_service.dart';
import 'package:esport_cliente/widgets/campeonato_tile.dart';
import 'package:esport_cliente/widgets/titulo_seccion.dart';
import 'package:flutter/material.dart';

class CampeonatosTab extends StatefulWidget {
  CampeonatosTab({super.key});

  @override
  State<CampeonatosTab> createState() => _CampeonatosTabState();
}

class _CampeonatosTabState extends State<CampeonatosTab> {
  final fondo = AssetImage('assets/images/fondo_app.jpg');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: fondo, fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            
            TituloSeccion(titulo: 'Campeonatos', subtitulo: 'Listado'),
            


            Expanded(
              child: FutureBuilder(
                future: HttpService().campeonatos(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
                    ));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var campeonato = snapshot.data[index];
                      return CampeonatoTile(
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
            //
          ],
        ),
      ),
    );
  }
}
