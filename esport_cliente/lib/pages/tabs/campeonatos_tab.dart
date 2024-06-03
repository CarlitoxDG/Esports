// ignore_for_file: prefer_const_constructors

import 'package:esport_cliente/services/http_service.dart';
import 'package:esport_cliente/widgets/campeonato_tile.dart';
import 'package:esport_cliente/widgets/titulo_seccion.dart';
import 'package:flutter/material.dart';

class CampeonatosTab extends StatelessWidget {
  final fondo = AssetImage('assets/images/fondo_app.jpg');

  CampeonatosTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: fondo, fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            //TITULO SECCION
            TituloSeccion(titulo: 'Campeonatos', subtitulo: 'Listado'),
            //FIN TITULO SECCION

            //lista de campeonatos
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
                      var piloto = snapshot.data[index];
                      return CampeonatoTile(
                        nombre: piloto['nombre'],
                        fecha_inicio: piloto['fecha_inicio'],
                        fecha_fin: piloto['fecha_fin'],
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
