import 'package:esport_cliente/widgets/titulo_seccion.dart';
import 'package:flutter/material.dart';

class EquiposTab extends StatelessWidget {
  final fondo = AssetImage('assets/images/fondo_equipos.jpg');

  EquiposTab({super.key});
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
            TituloSeccion(titulo: 'Equipos', subtitulo: 'Listado'),
            //FIN TITULO SECCION
          ],
        ),
      ),
    );
  }
}
