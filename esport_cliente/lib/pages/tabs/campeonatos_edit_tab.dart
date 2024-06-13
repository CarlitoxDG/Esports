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
<<<<<<< HEAD
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {
=======
                  if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
>>>>>>> 51a875ec66910d375e5c506e5710f80f6303c3f9
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
<<<<<<< HEAD
                        campeonatoId: campeonato['id'],
=======
                        id: campeonato['id'],
>>>>>>> 51a875ec66910d375e5c506e5710f80f6303c3f9
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
<<<<<<< HEAD
      floatingActionButton: FloatingActionButton(
=======
      floatingActionButton: FloatingActionButton.extended(
>>>>>>> 51a875ec66910d375e5c506e5710f80f6303c3f9
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AgregarCampeonato()),
          );
        },
<<<<<<< HEAD
        child: Icon(Icons.add),
=======
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          'Agregar Campeonato',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red, 
>>>>>>> 51a875ec66910d375e5c506e5710f80f6303c3f9
      ),
    );
  }
}

