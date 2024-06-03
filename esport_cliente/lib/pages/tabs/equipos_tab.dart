import 'package:esport_cliente/services/http_service.dart';
import 'package:esport_cliente/widgets/equipo_tile.dart';
import 'package:esport_cliente/widgets/titulo_seccion.dart';
import 'package:flutter/material.dart';

class EquiposTab extends StatelessWidget {
  final fondo = const AssetImage('assets/images/fondo_equipos.jpg');

  const EquiposTab({super.key});
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
            const TituloSeccion(titulo: 'Equipos', subtitulo: 'Listado'),
            //FIN TITULO SECCION
            Expanded(
              child: FutureBuilder(
                future: HttpService().equipos(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
                    ));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var piloto = snapshot.data[index];
                      return EquipoTile(
                        nombre: piloto['nombre'],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
