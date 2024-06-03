import 'package:esport_cliente/pages/tabs/campeonatos_tab.dart';
import 'package:esport_cliente/pages/tabs/equipos_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Color de fondo del botón
                elevation: 0, // Elimina la sombra
              ),
              child: const  Text(
                'Modo Editor',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
          backgroundColor: Colors.deepPurple,
          // title: Text('Formula 1'),
          title: Container(
            color: Colors.deepPurple,
            height: 40,
            child: Image.asset(
              'assets/images/esportsapp_text.png',
              fit: BoxFit.contain,
            ),
          ),
          bottom: const TabBar(
            labelColor: Color.fromARGB(255, 255, 255, 255),
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.videogame_asset), text: 'Campeonatos'),
              Tab(icon: Icon(Icons.people), text:'Equipos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CampeonatosTab(),
            const EquiposTab(),
          ],
        ),
      ),
    );
  }
}
