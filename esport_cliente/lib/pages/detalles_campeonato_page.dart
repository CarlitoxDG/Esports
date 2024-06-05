import 'package:esport_cliente/services/http_service.dart';
import 'package:flutter/material.dart';

class DetalleCampeonato extends StatelessWidget {
  final int idCampeonato;
  final String nombre;
  final String reglas;
  final String premios;
  const DetalleCampeonato(
      {super.key,
      required this.nombre,
      required this.reglas,
      required this.premios,
      required this.idCampeonato});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Column(
            children: [
              Container(
                color: Colors.deepPurple,
                height: 40,
                child: Image.asset(
                  'assets/images/esportsapp_text.png',
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                color: Colors.deepPurple,
                height: 30,
                child: Text(nombre),
              )
            ],
          ),
          bottom: const TabBar(
            labelColor: Color.fromARGB(255, 255, 255, 255),
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.videogame_asset), text: 'Reglas'),
              Tab(icon: Icon(Icons.people), text: 'Premios'),
              Tab(
                text: "integrantes",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Text(reglas),
            Text(premios),
            FutureBuilder<List<dynamic>>(
              future: HttpService().equiposEnCampeonato(idCampeonato),
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurple,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<dynamic>? equipos = snapshot.data;
                  return ListView.builder(
                    itemCount: equipos?.length,
                    itemBuilder: (BuildContext context, int index) {
                      String? nombreEquipo = equipos?[index]['nombre'];
                      String? urlImagen =
                          'assets/images/Equipos/$nombreEquipo.png';
                      return ListTile(
                          title: Text(nombreEquipo ?? 'Nombre del Equipo'),
                          leading: Image(
                            image: AssetImage(urlImagen),
                            height: 40,
                            width: 40,
                          ));
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
